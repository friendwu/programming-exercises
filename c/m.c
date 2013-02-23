#include <assert.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <stdio.h>
#include <string.h>

extern char** environ;
void xx(char x[], size_t n)
{
	if(x == NULL) assert(0);
	printf("%x\n", x);
}

void main()
{
	struct sockaddr_in peer_addr;


	xx(NULL, 0);

	//printf("%d", strlen("\0"));
}



