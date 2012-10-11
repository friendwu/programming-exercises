#include <assert.h>
#include "allocator.h"
#include "../typedef.h"

#define WORD_SIZE 4
#define DWORD_SIZE 8

//size of header + footer.
#define OVERHEAD WORD_SIZE * 2 

//p means the block header ptr, dp means the data start ptr.
#define PACK(size, alloc) ((size) | (alloc)) 
#define PUT(p, val) (*(size_t*)(p) = (val))
#define GET(p) (*(size_t*)(p))

//the last 3 bits should be 0. sizeof block payload.
#define GET_SIZE(p) (GET(p) & ~0x07) 
#define GET_ALLOC(p) (GET(p) & 0x01)

#define PREV_BLOCK(p) ((p) - GET_SIZE((char* )(p)-WORD_SIZE) -OVERHEAD)
#define NEXT_BLOCK(p) ((char* )(p) + GET_SIZE(p) + OVERHEAD) 

#define FOOTER(p) ((char* )(p) + GET_SIZE(p) + WORD_SIZE)

#define DP_TO_HDRP(dp) ((char* )(dp) - WORD_SIZE)
#define DP_TO_FTRP(dp) ((char* )(dp) + GET_SIZE(DP_TO_HDRP(dp)))

#define HDRP_TO_DP(p) ((char* )(p) + WORD_SIZE)
#define FTRP_TO_DP(p) ((char* )(p) - GET_SIZE(p))

typedef struct _Allocator
{
	size_t size;
	void** data;
}Allocator;

//useless function here.
/*
static void* _allocator_extend_heap(Allocator* thiz, size_t size)
{
	if(size < DWORD_SIZE) alloc_size = DWORD_SIZE;
	else if(size % DWORD_SIZE == 0) alloc_size = size; 
	else alloc_size = (size/DWORD_SIZE + 1) * DWORD_SIZE;

	size_t old_size = thiz->size;

	thiz->data = realloc(thiz->data, size);
	if(thiz->data == NULL) return NULL;

	thiz->size = size;

	//new block header init.
	PUT((char* )(thiz->data) + old_size, PACK(size-old_size, 0));
	//new block footer init.
	PUT((char* )(thiz->data) + size - WORD_SIZE, PACK(size-old_size, 0));

	return *((char* )(thiz->data) + old_size);
}
*/

static void _allocator_try_merge(Allocator* thiz, void* p)
{
	size_t prev_alloc = GET_ALLOC(PREV_BLOCK(p));
	size_t next_alloc = GET_ALLOC(NEXT_BLOCK(p));

	size_t prev_size = GET_SIZE(PREV_BLOCK(p));
	size_t next_size = GET_SIZE(NEXT_BLOCK(p));
	size_t cur_size = GET_SIZE(p);

	if(prev_alloc && !next_alloc)
	{
		//merge with next block.
		PUT(FOOTER(NEXT_BLOCK(p)), PACK(cur_size+next_size+OVERHEAD, 0));
		PUT(p, PACK(cur_size+next_size+OVERHEAD, 0));

		_allocator_try_merge(thiz, p);
	}
	else if(!prev_alloc && next_alloc)
	{
		//merge with previous block.
		PUT(PREV_BLOCK(p), PACK(cur_size+prev_size+OVERHEAD, 0));
		PUT(FOOTER(p), PACK(cur_size+prev_size+OVERHEAD, 0));

		_allocator_try_merge(thiz, PREV_BLOCK(p));
	}
	else if(!prev_alloc && !next_alloc)
	{
		//merge with the previous and next block.
		PUT(PREV_BLOCK(p), PACK(cur_size+next_size+prev_size+OVERHEAD*2, 0));
		PUT(FOOTER(NEXT_BLOCK(p)), PACK(cur_size+next_size+prev_size+OVERHEAD*2, 0));

		_allocator_try_merge(thiz, PREV_BLOCK(p));
	}
	
	return;
}

Allocator* allocator_create(size_t size)
{
	Allocator* thiz = (Allocator* )calloc(1, sizeof(Allocator));

	return_val_if_fail(thiz!=NULL, NULL);

	//header block + footer block + initial block(size),so there are 3 overhead.
	thiz->data = calloc(1, size+OVERHEAD*3);
	if(thiz->data == NULL)
	{
		free(thiz);

		return NULL;
	}
	thiz->size = size + OVERHEAD * 3;

	//only one data block initially with header and footer block.
	void** p = thiz->data;

	PUT(p, PACK(0, 1));
	PUT(FOOTER(p), PACK(0, 1));

	p = NEXT_BLOCK(p);
	PUT(p, PACK(size, 0));
	PUT(FOOTER(p), PACK(size, 0));

	p = NEXT_BLOCK(p);
	PUT(p, PACK(0, 1));
	PUT(FOOTER(p), PACK(0, 1));

	return thiz;
}

void* allocator_alloc(Allocator* thiz, size_t size)
{
	return_val_if_fail(thiz!=NULL && size!=0, NULL);

	void** p = thiz->data;
	size_t alloc_size;
	size_t real_size;

	if(size < DWORD_SIZE) alloc_size = DWORD_SIZE;
	else if(size % DWORD_SIZE == 0) alloc_size = size; 
	else alloc_size = (size/DWORD_SIZE + 1) * DWORD_SIZE;

	//first fit.
	while(p < (char* )(thiz->data) + thiz->size)
	{
		size_t blk_data_size = GET_SIZE(p);
		size_t block_alloc = GET_ALLOC(p);

		if(blk_data_size >= alloc_size && !block_alloc)
		{
			//not enough to split new block.
			if(blk_data_size <= alloc_size+OVERHEAD)
			{
				real_size = blk_data_size;
			}
			else
			{
				real_size = alloc_size;
			}

			PUT(p, PACK(real_size, 1));
			PUT(FOOTER(p), PACK(real_size, 1));

			//split the new block.
			if(real_size < blk_data_size)
			{
				size_t new_blk_data_size = blk_data_size- real_size - OVERHEAD;

				//split the block into 2 parts.	
				void** np = NEXT_BLOCK(p);
				PUT(np, PACK(new_blk_data_size, 0));
				PUT(FOOTER(np), PACK(new_blk_data_size, 0));
			}
				
			return HDRP_TO_DP(p);
		}
		
		p = NEXT_BLOCK(p);
	}
	
	/*
		if(_allocator_extend_heap(thiz, alloc_size * 2) == NULL) return NULL;
		return allocator_alloc(thiz, alloc_size);
	*/

	return NULL;
}

void allocator_free(Allocator* thiz, void* dp)
{
	return_if_fail(dp != NULL && thiz != NULL);
	PUT(DP_TO_HDRP(dp), PACK(GET_SIZE(DP_TO_HDRP(dp)), 0));

	_allocator_try_merge(thiz, DP_TO_HDRP(dp));
}

void allocator_destroy(Allocator* thiz)
{
	return_if_fail(thiz != NULL);

	free(thiz->data);
	free(thiz);

	return;
}

void allocator_dump(Allocator* thiz, Adump_t* dump)
{
	return_if_fail(thiz!=NULL);

	void** p = thiz->data;
	size_t free_num = 0;
	size_t alloc_num = 0;

	printf("============dump start\n");
	while(p < (char* )(thiz->data) + thiz->size)
	{
		size_t blk_data_size = GET_SIZE(p);
		size_t block_alloc = GET_ALLOC(p);

		printf("find block: data size: %d, allocation: %d\n", blk_data_size, block_alloc);

		if(!block_alloc)free_num++;
		else alloc_num++;

		p = NEXT_BLOCK(p);
	}

	printf("\ntotal free_num: %d, total alloc_num:  %d\n", free_num, alloc_num);
	printf("============dump end\n");

	if(dump)
	{
		dump->free_num = free_num;
		dump->alloc_num = alloc_num;
	}
}

#define ALLOCATOR_TEST

#ifdef ALLOCATOR_TEST
void main()
{
	Allocator* a = allocator_create(1024);
	allocator_dump(a, NULL);
	int i;
	void* p[256] = {0};
	for(i=0; i<64; i++)
	{
		p[i] = allocator_alloc(a, 8);
		assert(p[i] != NULL);
	}

	assert(allocator_alloc(a, 8) == NULL);

	allocator_dump(a, NULL);

	for(i=0; i<64; i++)
	{
		allocator_free(a, p[i]);
	}
	
	allocator_dump(a, NULL);

	allocator_destroy(a);
}
#endif 

