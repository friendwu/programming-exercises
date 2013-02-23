#ifndef TYPEDEF_H
#define TYPEDEF_H

#define return_val_if_fail(p, v) \
	if(!p) {printf("%s failed.\n", "#p"); return v;}

#define return_if_fail(p) \
	if(!p) {printf("%s failed.\n", "#p");}

typedef enum _Ret
{
	RET_OK,
	RET_FAIL,
}Ret;

#endif

