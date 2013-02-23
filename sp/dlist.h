#ifndef DLIST_H
#define DLIST_H

struct _Dlist;
typedef struct _Dlist Dlist;

Dlist* dlist_create();
Ret dlist_insert(Dlist* thiz, int index, void* data);
Ret dlist_insert_head(Dlist* thiz, void* data);
Ret dlist_insert_tail(Dlist* thiz, void* data);

Ret dlist_delete(Dlist* thiz, int index);
Ret dlist_delete_head(Dlist* thiz);
Ret dlist_delete_tail(Dlist* thiz);

Ret dlist_destroy(Dlist* thiz);




#endif
