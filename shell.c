#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <string.h>
#include <ctype.h>
#define IS_DELIM(delim_func, s, c) ((delim_func!=NULL && delim_func(c)) || (s!=NULL && strchr(s, c)!=NULL))

extern char** environ;
//void add_job();
//void delete_job();

typedef struct _Cmd
{
	const char* cmd_args[256];
}Cmd;

typedef int (*IS_DELIM_FUNC)(int c);

static char* get_token(char** buf, IS_DELIM_FUNC delim_func, const char* delim)
{
	if(buf==NULL || *buf ==NULL) return NULL;

	char* p = *buf;
	char* p_start;
	size_t len = 0;

	while(*p!='\0' && IS_DELIM(delim_func, delim, *p))
	{
		p++;
	}
	if(*p == '\0') return NULL;
	
	p_start = p;
	p++;

	while(*p!='\0' && !IS_DELIM(delim_func, delim, *p))
	{
		p++;
	}

	*p = '\0';
	*buf = p + 1;

	return p_start;
}

static void eval(char* buf, Cmd* cmd)
{
	char* p = buf;
	cmd->cmd_args[0] = get_token(&p, isspace, NULL);

	if(cmd->cmd_args[0] == NULL) return;
	
	int i;
	for(i=1; i<256; i++)
	{
		cmd->cmd_args[i] = get_token(&p, isspace, NULL);
		if(cmd->cmd_args[i] == NULL) return;
	}
}

static void print_prompt()
{
	write(STDOUT_FILENO, "$ ", 2);
}

int main(int argc, char** argv)
{
	char buf[512] = {0};
	FILE* in_file = fdopen(STDIN_FILENO, "r");

	for(;;)
	{
		print_prompt();

		memset(buf, 0, 512);
		fgets(buf, 512, in_file);
		Cmd cmd = {0};
		eval(buf, &cmd);

		if(cmd.cmd_args[0] == NULL)
		{
			continue;
		}

		//how to generate several process? 
		//need to add job support.
		pid_t pid = fork();
		if(pid == 0)
		{
			//child.
			if(execvp(cmd.cmd_args[0], cmd.cmd_args) < 0)
			{
				printf("command %s not found.\n", cmd.cmd_args[0]);
				exit(-1);
			}
		}
		else if(pid > 0)
		{
			//parent, just wait for its child.
			//fclose(in_file); // ??????? will cause problems?
			waitpid(-1, NULL, 0);
			continue;
		}
	}

	return 0;
}

/*
		printf("cmd_args[0]: %s\n", cmd.cmd_args[0]);
		printf("cmd_args: ");

		int i;
		for(i=0; i<256; i++)
		{
			if(cmd.cmd_args[i] != NULL)
			{
				printf("%s\n", cmd.cmd_args[i]);
			}
		}
*/
