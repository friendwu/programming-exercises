#ifndef ALLOCATOR_H
#define ALLOCATOR_H

struct _Allocator;
typedef struct _Allocator Allocator;

typedef struct _Adump_t
{
	
}Adump_t;

Allocator* allocator_create(size_t init_size);
void allocator_destroy(Allocator* thiz);

void* allocator_alloc(Allocator* thiz, size_t size);
void allocator_free(Allocator* thiz, void* dp);
void allocator_dump(Allocator* thiz, Adump_t* dump);

#endif
