#include "dlist.h"
typedef struct _DlistNode
{
	void* data;

	DlistNode* prev;
	DlistNode* next;
}DlistNode;

typedef struct _Dlist
{
	DlistNode* head;
	size_t count;
}Dlist;

Dlist* dlist_create()
{
	Dlist* thiz = calloc(1, sizeof(Dlist));		

	if(thiz == NULL)
	{
		return 
	}
}
Ret dlist_insert(Dlist* thiz, int index, void* data)
{

}

Ret dlist_insert_head(Dlist* thiz, void* data);
Ret dlist_insert_tail(Dlist* thiz, void* data);

Ret dlist_delete(Dlist* thiz, int index);
Ret dlist_delete_head(Dlist* thiz);
Ret dlist_delete_tail(Dlist* thiz);

Ret dlist_destroy(Dlist* thiz);



