#include <stdio.h>

extern char** environ;
void main()
{
	int i = 0;
	for(i; environ[i] != NULL; i++)
	{
		printf("%s\n", environ[i]);
	}
}



