#include "buddy.h"
#include "../typedef.h"

typedef int (*FOREACH_CALLBACK)(void* ctx, Node* node);

typedef struct _Node
{
	size_t offset;
	size_t size;

	_Node* left;
	_Node* right;
}Node;

typedef struct _Buddy
{
	size_t size;
	void* buffer;
	char tree[1];
}Buddy;

static Node* node_new(size_t size, size_t offset)
{
	Node* node = calloc(1, sizeof(Node));
	assert(node != NULL);

	node->size = size;
	node->offset = offset;

	return node;
}

Buddy* buddy_new(void* buffer, size_t size)
{
	Buddy* thiz = calloc(1, sizeof(Buddy) + sizeof(Node*) * size * 2);

	return_val_if_fail(thiz!=NULL, NULL);

	thiz->buffer = buffer;
	thiz->free_list = (char* )thiz + sizeof(Buddy);
	thiz->alloc_list = (char* )thiz->free_list + size * sizeof(Node* );
	

	Node* n = node_new(size, 0);
	thiz->free_list[size - 1] = n;
	
	return thiz;
}

Ret buddy_alloc(Buddy* thiz, size_t size, size_t* offset)
{
	return_val_if_fail(thiz!=NULL && size>0 && size<=thiz->size && offset!=NULL, RET_FAIL);

	Node* iter = NULL;

	size_t i;
	for(i=size; i<=thiz->size; i++)
	{
		if(thiz->free_list[i] != NULL)
		{
			iter = thiz->free_list[i];	
			break;
		}
	}

	if(iter == NULL)
	{
		return RET_FAIL;
	}

	size_t found_size = i+1;

	if(found_size > size)
	{
		//split.
		for(;;)
		{
			size_t new_size = size - 1;

			//buddy.
			Node* n = node_new(new_size, iter->offset + 1<<new_size);
			insert_head(&(thiz->free_list[new_size-1]), n);

			if(new_size == size)
			{
				Node* nn = node_new(new_size, iter->offset);
				insert_head(&(thiz->alloc_list[new_size-1]), nn);
				break;
			}
		}
	}
	else
	{
		Node* nnn = node_new(iter->size, iter->offset);
		insert_head(&(thiz->alloc_list[size-1]), nnn);
	}

	*offset = iter->offset;
	return RET_OK;
}

Ret buddy_free(Buddy* thiz, size_t offset)
{
	return_val_if_fail(thiz!=NULL && (offset%2)==0, RET_FAIL);
	
	int i;
	for(i=0; i<thiz->size; i++)
	{
		Node* iter = foreach_list(thiz->alloc_list[i], (void* )offset, match_block_callback);
		if(iter == NULL) continue;

		delete_from_list(&(thiz->alloc_list[i]), iter);
		free(iter); iter = NULL;

		Node* buddy_iter = foreach_list(thiz->free_list[i], (void* )offset, match_block_callback);
		if(buddy_iter == NULL)
		{
			return RET_OK;
		}

		delete_from_list(&(thiz->free_list[i]), buddy_iter);
		buddy_iter->size = buddy_iter->size + 1;
		insert_head(&(thiz->free_list[buddy_iter->size - 1]), buddy_iter);
		//TODO merge should be recurive.
	}
	
	return RET_FAIL;
}

Ret buddy_destroy(Buddy* thiz)
{
	return_val_if_fail(thiz!=NULL, RET_FAIL);

	size_t i;
	for(i=0; i<size; i++)
	{
		foreach_list(thiz->free_list[i], NULL, destroy_list_callback);
		foreach_list(thiz->alloc_list[i], NULL, destroy_list_callback);
	}
	
	free(thiz);

	return RET_OK;
}

