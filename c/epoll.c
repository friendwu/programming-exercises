#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/epoll.h>

#define MAX_EVENTS 10
/* Set up listening socket, 'listen_sock' (socket(),
   bind(), listen()) */

//if (epoll_ctl(epollfd, EPOLL_CTL_ADD, listen_sock, &ev) == -1) {
//	perror("epoll_ctl: listen_sock");
//	exit(EXIT_FAILURE);
//}
//
//for (;;) {
//	nfds = epoll_wait(epollfd, events, MAX_EVENTS, -1);
//	if (nfds == -1) {
//		perror("epoll_pwait");
//		exit(EXIT_FAILURE);
//	}
//
//	for (n = 0; n < nfds; ++n) {
//		if (events[n].data.fd == listen_sock) {
//			conn_sock = accept(listen_sock,
//					(struct sockaddr *) &local, &addrlen);
//			if (conn_sock == -1) {
//				perror("accept");
//				exit(EXIT_FAILURE);
//			}
//			setnonblocking(conn_sock);
//			ev.events = EPOLLIN | EPOLLET;
//			ev.data.fd = conn_sock;
//			if (epoll_ctl(epollfd, EPOLL_CTL_ADD, conn_sock,
//						&ev) == -1) {
//				perror("epoll_ctl: conn_sock");
//				exit(EXIT_FAILURE);
//			}
//		} else {
//			do_use_fd(events[n].data.fd);
//		}
//	}
//}

void main()
{
	int epollfd = epoll_create(10);
	if (epollfd == -1) {
		perror("epoll_create");
		exit(EXIT_FAILURE);
	}

	struct epoll_event ev, events[MAX_EVENTS];

	int  x = 0x8048;
	ev.events = EPOLLIN;
	//ev.data.fd = STDIN_FILENO;
	ev.data.ptr = (void* )x;

	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, STDIN_FILENO,
				&ev) == -1) {
		perror("epoll_ctl: stdin");
		exit(EXIT_FAILURE);
	}

	int i;
	for (i=0; i<3; i++) {
	//for (;;) {
		int nfds = epoll_wait(epollfd, events, MAX_EVENTS, -1);
		if (nfds == -1) {
			perror("epoll_pwait");
			exit(EXIT_FAILURE);
		}

		printf("nfds %d\n", nfds);

		int n;
		for (n = 0; n < nfds; ++n) {
			char buffer[256] = {0};

			//read(events[n].data.fd, buffer, 256);
			printf("input from stdin: %s, 0X%x\n", buffer, (int )(events[n].data.ptr));
		}
	}

	if (epoll_ctl(epollfd, EPOLL_CTL_DEL, STDIN_FILENO, NULL) != 0)
	{
		printf("oops!!!!\n");
	}
}
