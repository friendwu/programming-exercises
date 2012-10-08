#ifndef FIFO_RING_H_
#define FIFO_RING_H_

struct _FifoRing;
typedef struct _FifoRing FifoRing;

typedef enum _Ret
{
	RET_OK = 0,
	RET_FULL = 1,
	RET_EMPTY = 2,
	RET_INVALID_PARAMS = 3
}Ret;

FifoRing* fifo_ring_create(size_t size);
Ret fifo_ring_push(FifoRing* thiz, void* data);
Ret fifo_ring_pop(FifoRing* thiz, void** data);
Ret fifo_ring_destroy(FifoRing* thiz);

#endif

