//#!/usr/bin/tcc
#include <stdlib.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>

void printdir(const char* dir_name, int depth, const char* repeat)
{
	DIR* dir = opendir(dir_name);
	if(dir == NULL)
	{
		perror("foreach error");
		
		return;
	}

	struct dirent* d = NULL;
	struct stat buf = {0};

	chdir(dir_name);

	while((d=readdir(dir)) != NULL)
	{
		if(strcmp(d->d_name, ".") == 0 || strcmp(d->d_name, "..") == 0)
		{
			continue;	
		}

		lstat(d->d_name, &buf);

		if(S_ISDIR(buf.st_mode))
		{
			printf("%*s[%s]\n", depth, repeat, d->d_name);
			printdir(d->d_name, depth + 4, repeat);	
		}
		else
		{
			printf("%*s%s\n", depth, repeat, d->d_name);
		}
	}

	closedir(dir);
	chdir("..");
}

int main(int argc, char** argv)
{
	char buf[512] = {0};

	if(argc > 1)
	{
		printdir(argv[1], 0, " ");
	}
	else
	{
		printdir(getcwd(buf, 512), 0, " ");
	}

	return 0;
}
