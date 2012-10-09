#include <stdio.h>
#include <assert.h>
#include "fifo_ring.h"

#define return_val_if_fail(p, v) \
	if(!p) {printf("%s failed.\n", "#p"); return v;}

typedef struct _FifoRing
{
	void** data;
	size_t r_cursor;
	size_t w_cursor;
	size_t size;
}FifoRing;

FifoRing* fifo_ring_create(size_t size)
{
	FifoRing* thiz = calloc(1, sizeof(FifoRing));

	return_val_if_fail(thiz!=NULL, NULL);

	thiz->data = calloc(1, size * sizeof(void*));
	if(thiz->data == NULL)
	{
		free(thiz);

		return NULL;
	}

	thiz->r_cursor = 0;
	thiz->w_cursor = 0;
	thiz->size = size + 1;

	return thiz;
}
/*
	r_cursor == w_cursor, empty.
	(w_cursor + 1) % size == r_cursor, full.
*/
Ret fifo_ring_push(FifoRing* thiz, void* data)
{
	return_val_if_fail(thiz!=NULL, RET_INVALID_PARAMS);
	
	size_t cursor_to_move = (thiz->w_cursor + 1) % thiz->size;
	if(cursor_to_move == thiz->r_cursor)
	{
		return RET_FULL;
	}

	thiz->data[thiz->w_cursor] = data;
	thiz->w_cursor = cursor_to_move;

	printf("push data %d\n", data);

	return RET_OK;
}

Ret fifo_ring_pop(FifoRing* thiz, void** data)
{
	return_val_if_fail(thiz!=NULL && data!=NULL, RET_INVALID_PARAMS);

	if(thiz->r_cursor == thiz->w_cursor)
	{
		return RET_EMPTY;
	}

	*data = thiz->data[thiz->r_cursor];
	thiz->r_cursor = (thiz->r_cursor + 1) % thiz->size;

	printf("pop data %d\n", *data);
	
	return RET_OK;
}

Ret fifo_ring_destroy(FifoRing* thiz)
{
	return_val_if_fail(thiz!=NULL, RET_INVALID_PARAMS);

	free(thiz->data);
	free(thiz);

	return RET_OK;
}

#ifdef FIFO_RING_TEST

int main(int argc, char** argv)
{
	FifoRing* thiz = fifo_ring_create(100);

	assert(thiz != NULL);

	int i = 0;
	for(i; i<100; i++)
	{
		assert(fifo_ring_push(thiz, (void* )i) == RET_OK);
	}
	
	int k = 0;
	for(k; k<10; k++)
	{
		assert(fifo_ring_push(thiz, (void* )k) == RET_FULL);
	}
	
	int m = 0;
	int r = 0;
	for(m; m<50; m++)
	{
		assert(fifo_ring_pop(thiz, (void** )&r) == RET_OK);
		assert(r == m);
	}
	
	int x = 0;
	for(x; x<50; x++)
	{
		assert(fifo_ring_push(thiz, (void* )x) == RET_OK);
	}

	int y = 0;
	for(y; y<10; y++)
	{
		assert(fifo_ring_push(thiz, (void* )y) == RET_FULL);
	}

	m = 0;
	r = 0;
	for(m; m<100; m++)
	{
		assert(fifo_ring_pop(thiz, (void** )&r) == RET_OK);
		assert(r == (m+50)%100);
	}

	m = 0;
	r = 0;
	for(m; m<10; m++)
	{
		assert(fifo_ring_pop(thiz, (void** )&r) == RET_EMPTY);
	}

	assert(fifo_ring_destroy(thiz) == RET_OK);

	return 0;
}

#endif

