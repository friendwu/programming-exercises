#ifndef ALLOCATOR_H
#define ALLOCATOR_H

#define WORD_SIZE 4
#define DWORD_SIZE 8
//size of header + footer.
#define OVERHEAD WORD_SIZE * 2 

#define PACK(size, avail) (size & avail) 
#define PUT(p, val) (*(size_t*)(p) = val)
#define GET(p) (*(size_t*)(p))

//the last 3 bits should be 0. sizeof block payload.
#define GET_SIZE(p) (GET(p) & ~0x07) 
#define GET_ALLOC(p) (GET(p) & 0x01)

#define PREV_BLOCK(p) ((char* )p - WORD_SIZE)
#define NEXT_BLOCK(p) ((char* )p + GET_SIZE(p) + OVERHEAD) 
#define FOOTER(p) ((char* )p + GET_SIZE(p) + WORD_SIZE)

#define HDRP(bp) ((char* bp) - WORD_SIZE)
#define FTRP(bp) ((char* )bp + GET_SIZE(HDRP(bp)))


typedef struct _Allocator
{
	size_t size;
	void** data;
}Allocator;

static void* _allocator_extend_heap(allocator* thiz, size_t size)
{
	if(size < WORD_SIZE) alloc_size = DWORD_SIZE;
	else if(size % WORD_SIZE == 0) alloc_size = size; 
	else alloc_size = (size/WORD_SIZE + 1) * DWORD_SIZE;

	size_t old_size = thiz->size;

	thiz->data = realloc(thiz->data, size);
	if(thiz->data == NULL) return NULL;

	thiz->size = size;

	PUT((char* )(thiz->data) + old_size, PACK(size-old_size, 0));
	PUT((char* )(thiz->data) + size - WORD_SIZE, PACK(size-old_size, 0));

	return *((char* )(thiz->data) + old_size);
}

static void _allocator_try_merge(allocator* thiz, void* p)
{
	size_t prev_alloc;
	size_t next_alloc;

	size_t prev_size = GET_SIZE(p-1);
	size_t next_size = GET_SIZE(NEXT_BLOCK(p));
	size_t cur_size = GET_SIZE(p);


	if(prev_alloc && !next_alloc)
	{
		//merge with next block.
		PUT(p, PACK(cur_size+next_size+WORD_SIZE*2, 0));
		PUT(FOOTER(p), PACK(cur_size+next_size, 0));
	}
	else if(!prev_alloc && next_alloc)
	{
		//merge with previous block.
		PUT(PREV_BLOCK(p), PACK(cur_size+prev_size+WORD_SIZE*2, 0));
		PUT(FOOTER(p), PACK(cur_size+prev_size+WORD_SIZE*2, 0));
	}
	else
	{
		//merge with the previous and next block.	
		PUT(PREV_BLOCK(p), PACK(cur_size+next_size+prev_size+WORD_SIZE*4, 0));
		PUT(FOOTER(NEXT_BLOCK(p)), PACK(cur_size+next_size+prev_size+WORD_SIZE*4, 0));
	}
	
	return;
}

Allocator* allocator_create(size_t init_size)
{
	Allocator* thiz = calloc(1, sizeof(Allocator));

	return_val_if_fail(thiz!=NULL, NULL);

	thiz->data = calloc(1, init_size+OVERHEAD);
	if(thiz->data == NULL)
	{
		free(thiz);

		return NULL;
	}

	//there is only one block initially
	void* p = thiz->data;

	PUT(p, PACK(init_size, 0));
	PUT(FOOTER(p), PACK(init_size, 0));

	return thiz;
}

void* allocator_alloc(Allocator* thiz, size_t size)
{
	return_val_if_fail(thiz!=NULL && size!=0, NULL);

	void* p = thiz->data;
	size_t alloc_size;
	size_t real_size;

	if(size < DWORD_SIZE) alloc_size = DWORD_SIZE;
	else if(size % DWORD_SIZE == 0) alloc_size = size; 
	else alloc_size = (size/DWORD_SIZE + 1) * DWORD_SIZE;

	while(p < thiz->data + thiz->size)
	{
		size_t block_size = GET_SIZE(p);
		int block_available = GET_ALLOC(p);

		if(block_size >= alloc_size && block_available)
		{
			//not enough to split new block.
			if(block_size <= alloc_size+OVERHEAD)
			{
				real_size = block_size;
			}

			PUT(p, PACK(real_size, 0));
			PUT(GET_FOOTER(p), PACK(real_size, 0));

			//split the new block.
			if(real_size < block_size)
			{
				size_t new_block_size = block_size- real_size - OVERHEAD;

				//split the block into 2 parts.	
				void* np = NEXT_BLOCK(p);
				PUT(np, PACK(new_block_size, 0));
				PUT(GET_FOOTER(np), PACK(new_block_size, 0));
			}
				
			return p + 1;
		}
		
		p = NEXT_BLOCK(p);
	}
	
	//cannot find fit block, apply more memory.
	if(_allocator_extend_heap(thiz, alloc_size * 2) == NULL) return NULL;
	//TODO.
	return allocator_alloc(thiz, alloc_size);
}

void allocator_free(Allocator* thiz, void* p)
{
	//modify the alloc bit.
	//merge the blocks before or after.
	PUT(p-1, PACK(GET_SIZE(p-1), 0));

	_allocator_try_merge(thiz, p);
}

#endif

