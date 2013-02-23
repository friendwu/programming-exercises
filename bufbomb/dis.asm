
./a.out:     file format elf32-i386


Disassembly of section .init:

0804835c <_init>:
 804835c:	53                   	push   %ebx
 804835d:	83 ec 08             	sub    $0x8,%esp
 8048360:	e8 00 00 00 00       	call   8048365 <_init+0x9>
 8048365:	5b                   	pop    %ebx
 8048366:	81 c3 8f 1c 00 00    	add    $0x1c8f,%ebx
 804836c:	8b 83 fc ff ff ff    	mov    -0x4(%ebx),%eax
 8048372:	85 c0                	test   %eax,%eax
 8048374:	74 05                	je     804837b <_init+0x1f>
 8048376:	e8 55 00 00 00       	call   80483d0 <__gmon_start__@plt>
 804837b:	e8 10 01 00 00       	call   8048490 <frame_dummy>
 8048380:	e8 8b 03 00 00       	call   8048710 <__do_global_ctors_aux>
 8048385:	83 c4 08             	add    $0x8,%esp
 8048388:	5b                   	pop    %ebx
 8048389:	c3                   	ret    

Disassembly of section .plt:

08048390 <printf@plt-0x10>:
 8048390:	ff 35 f8 9f 04 08    	pushl  0x8049ff8
 8048396:	ff 25 fc 9f 04 08    	jmp    *0x8049ffc
 804839c:	00 00                	add    %al,(%eax)
	...

080483a0 <printf@plt>:
 80483a0:	ff 25 00 a0 04 08    	jmp    *0x804a000
 80483a6:	68 00 00 00 00       	push   $0x0
 80483ab:	e9 e0 ff ff ff       	jmp    8048390 <_init+0x34>

080483b0 <getchar@plt>:
 80483b0:	ff 25 04 a0 04 08    	jmp    *0x804a004
 80483b6:	68 08 00 00 00       	push   $0x8
 80483bb:	e9 d0 ff ff ff       	jmp    8048390 <_init+0x34>

080483c0 <__stack_chk_fail@plt>:
 80483c0:	ff 25 08 a0 04 08    	jmp    *0x804a008
 80483c6:	68 10 00 00 00       	push   $0x10
 80483cb:	e9 c0 ff ff ff       	jmp    8048390 <_init+0x34>

080483d0 <__gmon_start__@plt>:
 80483d0:	ff 25 0c a0 04 08    	jmp    *0x804a00c
 80483d6:	68 18 00 00 00       	push   $0x18
 80483db:	e9 b0 ff ff ff       	jmp    8048390 <_init+0x34>

080483e0 <__libc_start_main@plt>:
 80483e0:	ff 25 10 a0 04 08    	jmp    *0x804a010
 80483e6:	68 20 00 00 00       	push   $0x20
 80483eb:	e9 a0 ff ff ff       	jmp    8048390 <_init+0x34>

080483f0 <__ctype_b_loc@plt>:
 80483f0:	ff 25 14 a0 04 08    	jmp    *0x804a014
 80483f6:	68 28 00 00 00       	push   $0x28
 80483fb:	e9 90 ff ff ff       	jmp    8048390 <_init+0x34>

Disassembly of section .text:

08048400 <_start>:
 8048400:	31 ed                	xor    %ebp,%ebp
 8048402:	5e                   	pop    %esi
 8048403:	89 e1                	mov    %esp,%ecx
 8048405:	83 e4 f0             	and    $0xfffffff0,%esp
 8048408:	50                   	push   %eax
 8048409:	54                   	push   %esp
 804840a:	52                   	push   %edx
 804840b:	68 00 87 04 08       	push   $0x8048700
 8048410:	68 90 86 04 08       	push   $0x8048690
 8048415:	51                   	push   %ecx
 8048416:	56                   	push   %esi
 8048417:	68 1e 86 04 08       	push   $0x804861e
 804841c:	e8 bf ff ff ff       	call   80483e0 <__libc_start_main@plt>
 8048421:	f4                   	hlt    
 8048422:	90                   	nop
 8048423:	90                   	nop
 8048424:	90                   	nop
 8048425:	90                   	nop
 8048426:	90                   	nop
 8048427:	90                   	nop
 8048428:	90                   	nop
 8048429:	90                   	nop
 804842a:	90                   	nop
 804842b:	90                   	nop
 804842c:	90                   	nop
 804842d:	90                   	nop
 804842e:	90                   	nop
 804842f:	90                   	nop

08048430 <__do_global_dtors_aux>:
 8048430:	55                   	push   %ebp
 8048431:	89 e5                	mov    %esp,%ebp
 8048433:	53                   	push   %ebx
 8048434:	83 ec 04             	sub    $0x4,%esp
 8048437:	80 3d 20 a0 04 08 00 	cmpb   $0x0,0x804a020
 804843e:	75 3f                	jne    804847f <__do_global_dtors_aux+0x4f>
 8048440:	a1 24 a0 04 08       	mov    0x804a024,%eax
 8048445:	bb 20 9f 04 08       	mov    $0x8049f20,%ebx
 804844a:	81 eb 1c 9f 04 08    	sub    $0x8049f1c,%ebx
 8048450:	c1 fb 02             	sar    $0x2,%ebx
 8048453:	83 eb 01             	sub    $0x1,%ebx
 8048456:	39 d8                	cmp    %ebx,%eax
 8048458:	73 1e                	jae    8048478 <__do_global_dtors_aux+0x48>
 804845a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8048460:	83 c0 01             	add    $0x1,%eax
 8048463:	a3 24 a0 04 08       	mov    %eax,0x804a024
 8048468:	ff 14 85 1c 9f 04 08 	call   *0x8049f1c(,%eax,4)
 804846f:	a1 24 a0 04 08       	mov    0x804a024,%eax
 8048474:	39 d8                	cmp    %ebx,%eax
 8048476:	72 e8                	jb     8048460 <__do_global_dtors_aux+0x30>
 8048478:	c6 05 20 a0 04 08 01 	movb   $0x1,0x804a020
 804847f:	83 c4 04             	add    $0x4,%esp
 8048482:	5b                   	pop    %ebx
 8048483:	5d                   	pop    %ebp
 8048484:	c3                   	ret    
 8048485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8048489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

08048490 <frame_dummy>:
 8048490:	55                   	push   %ebp
 8048491:	89 e5                	mov    %esp,%ebp
 8048493:	83 ec 18             	sub    $0x18,%esp
 8048496:	a1 24 9f 04 08       	mov    0x8049f24,%eax
 804849b:	85 c0                	test   %eax,%eax
 804849d:	74 12                	je     80484b1 <frame_dummy+0x21>
 804849f:	b8 00 00 00 00       	mov    $0x0,%eax
 80484a4:	85 c0                	test   %eax,%eax
 80484a6:	74 09                	je     80484b1 <frame_dummy+0x21>
 80484a8:	c7 04 24 24 9f 04 08 	movl   $0x8049f24,(%esp)
 80484af:	ff d0                	call   *%eax
 80484b1:	c9                   	leave  
 80484b2:	c3                   	ret    
 80484b3:	90                   	nop

080484b4 <getxs>:
#include <ctype.h>

/* Like gets, except that characters are typed as pairs of hex digits.
   Nondigit characters are ignored.  Stops when encounters newline */
char *getxs(char *dest)
{
 80484b4:	55                   	push   %ebp
 80484b5:	89 e5                	mov    %esp,%ebp
 80484b7:	83 ec 28             	sub    $0x28,%esp
	int c;
	int even = 1; /* Have read even number of digits */
 80484ba:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
	int otherd = 0; /* Other hex digit of pair */
 80484c1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	char *sp = dest;
 80484c8:	8b 45 08             	mov    0x8(%ebp),%eax
 80484cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
	while ((c = getchar()) != EOF && c != '\n') {
 80484ce:	e9 88 00 00 00       	jmp    804855b <getxs+0xa7>
		if (isxdigit(c)) {
 80484d3:	e8 18 ff ff ff       	call   80483f0 <__ctype_b_loc@plt>
 80484d8:	8b 00                	mov    (%eax),%eax
 80484da:	8b 55 f4             	mov    -0xc(%ebp),%edx
 80484dd:	01 d2                	add    %edx,%edx
 80484df:	01 d0                	add    %edx,%eax
 80484e1:	0f b7 00             	movzwl (%eax),%eax
 80484e4:	0f b7 c0             	movzwl %ax,%eax
 80484e7:	25 00 10 00 00       	and    $0x1000,%eax
 80484ec:	85 c0                	test   %eax,%eax
 80484ee:	74 6b                	je     804855b <getxs+0xa7>
			int val;
			if ('0' <= c && c <= '9')
 80484f0:	83 7d f4 2f          	cmpl   $0x2f,-0xc(%ebp)
 80484f4:	7e 11                	jle    8048507 <getxs+0x53>
 80484f6:	83 7d f4 39          	cmpl   $0x39,-0xc(%ebp)
 80484fa:	7f 0b                	jg     8048507 <getxs+0x53>
				val = c - '0';
 80484fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80484ff:	83 e8 30             	sub    $0x30,%eax
 8048502:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8048505:	eb 20                	jmp    8048527 <getxs+0x73>
			else if ('A' <= c && c <= 'F')
 8048507:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
 804850b:	7e 11                	jle    804851e <getxs+0x6a>
 804850d:	83 7d f4 46          	cmpl   $0x46,-0xc(%ebp)
 8048511:	7f 0b                	jg     804851e <getxs+0x6a>
				val = c - 'A' + 10;
 8048513:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8048516:	83 e8 37             	sub    $0x37,%eax
 8048519:	89 45 f0             	mov    %eax,-0x10(%ebp)
 804851c:	eb 09                	jmp    8048527 <getxs+0x73>
			else
				val = c - 'a' + 10;
 804851e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8048521:	83 e8 57             	sub    $0x57,%eax
 8048524:	89 45 f0             	mov    %eax,-0x10(%ebp)
			if (even) {
 8048527:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 804852b:	74 0f                	je     804853c <getxs+0x88>
				otherd = val;
 804852d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8048530:	89 45 e8             	mov    %eax,-0x18(%ebp)
				even = 0;
 8048533:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 804853a:	eb 1f                	jmp    804855b <getxs+0xa7>
			} else {
				*sp++ = otherd * 16 + val;
 804853c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 804853f:	89 c2                	mov    %eax,%edx
 8048541:	c1 e2 04             	shl    $0x4,%edx
 8048544:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8048547:	01 d0                	add    %edx,%eax
 8048549:	89 c2                	mov    %eax,%edx
 804854b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 804854e:	88 10                	mov    %dl,(%eax)
 8048550:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
				even = 1;
 8048554:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
{
	int c;
	int even = 1; /* Have read even number of digits */
	int otherd = 0; /* Other hex digit of pair */
	char *sp = dest;
	while ((c = getchar()) != EOF && c != '\n') {
 804855b:	e8 50 fe ff ff       	call   80483b0 <getchar@plt>
 8048560:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8048563:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8048567:	74 0a                	je     8048573 <getxs+0xbf>
 8048569:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
 804856d:	0f 85 60 ff ff ff    	jne    80484d3 <getxs+0x1f>
				*sp++ = otherd * 16 + val;
				even = 1;
			}
		}
	}
	*sp++ = '\0';
 8048573:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8048576:	c6 00 00             	movb   $0x0,(%eax)
 8048579:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
	return dest;
 804857d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 8048580:	c9                   	leave  
 8048581:	c3                   	ret    

08048582 <getbuf>:

/* $begin getbuf-c */
int getbuf()
{
 8048582:	55                   	push   %ebp
 8048583:	89 e5                	mov    %esp,%ebp
 8048585:	83 ec 28             	sub    $0x28,%esp
 8048588:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
 804858e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8048591:	31 c0                	xor    %eax,%eax
	char buf[12] = {1,2,3,4,5,6,7,8,9,10,11,12};
 8048593:	c6 45 e8 01          	movb   $0x1,-0x18(%ebp)
 8048597:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
 804859b:	c6 45 ea 03          	movb   $0x3,-0x16(%ebp)
 804859f:	c6 45 eb 04          	movb   $0x4,-0x15(%ebp)
 80485a3:	c6 45 ec 05          	movb   $0x5,-0x14(%ebp)
 80485a7:	c6 45 ed 06          	movb   $0x6,-0x13(%ebp)
 80485ab:	c6 45 ee 07          	movb   $0x7,-0x12(%ebp)
 80485af:	c6 45 ef 08          	movb   $0x8,-0x11(%ebp)
 80485b3:	c6 45 f0 09          	movb   $0x9,-0x10(%ebp)
 80485b7:	c6 45 f1 0a          	movb   $0xa,-0xf(%ebp)
 80485bb:	c6 45 f2 0b          	movb   $0xb,-0xe(%ebp)
 80485bf:	c6 45 f3 0c          	movb   $0xc,-0xd(%ebp)
	getxs(buf);
 80485c3:	8d 45 e8             	lea    -0x18(%ebp),%eax
 80485c6:	89 04 24             	mov    %eax,(%esp)
 80485c9:	e8 e6 fe ff ff       	call   80484b4 <getxs>
	return 1;
 80485ce:	b8 01 00 00 00       	mov    $0x1,%eax
}
 80485d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 80485d6:	65 33 15 14 00 00 00 	xor    %gs:0x14,%edx
 80485dd:	74 05                	je     80485e4 <getbuf+0x62>
 80485df:	e8 dc fd ff ff       	call   80483c0 <__stack_chk_fail@plt>
 80485e4:	c9                   	leave  
 80485e5:	c3                   	ret    

080485e6 <test>:

void test()
{
 80485e6:	55                   	push   %ebp
 80485e7:	89 e5                	mov    %esp,%ebp
 80485e9:	83 ec 28             	sub    $0x28,%esp
	//int val;
	//wupeng modfied.
	int val = 0xeeee;
 80485ec:	c7 45 f4 ee ee 00 00 	movl   $0xeeee,-0xc(%ebp)
	printf("Type Hex string:");
 80485f3:	b8 60 87 04 08       	mov    $0x8048760,%eax
 80485f8:	89 04 24             	mov    %eax,(%esp)
 80485fb:	e8 a0 fd ff ff       	call   80483a0 <printf@plt>
	val = getbuf();
 8048600:	e8 7d ff ff ff       	call   8048582 <getbuf>
 8048605:	89 45 f4             	mov    %eax,-0xc(%ebp)
	printf("getbuf returned 0x%x\n", val);
 8048608:	b8 71 87 04 08       	mov    $0x8048771,%eax
 804860d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8048610:	89 54 24 04          	mov    %edx,0x4(%esp)
 8048614:	89 04 24             	mov    %eax,(%esp)
 8048617:	e8 84 fd ff ff       	call   80483a0 <printf@plt>
}
 804861c:	c9                   	leave  
 804861d:	c3                   	ret    

0804861e <main>:
/* $end getbuf-c */

int main()
{
 804861e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 8048622:	83 e4 f0             	and    $0xfffffff0,%esp
 8048625:	ff 71 fc             	pushl  -0x4(%ecx)
 8048628:	55                   	push   %ebp
 8048629:	89 e5                	mov    %esp,%ebp
 804862b:	51                   	push   %ecx
 804862c:	83 ec 64             	sub    $0x64,%esp

	int buf[16];
	/* This little hack is an attempt to get the stack to be in a
	   stable position
	 */
	int offset = (((int) buf) & 0xFFF);
 804862f:	8d 45 b0             	lea    -0x50(%ebp),%eax
 8048632:	25 ff 0f 00 00       	and    $0xfff,%eax
 8048637:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int *space = (int *) alloca(offset);
 804863a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 804863d:	8d 50 0f             	lea    0xf(%eax),%edx
 8048640:	b8 10 00 00 00       	mov    $0x10,%eax
 8048645:	83 e8 01             	sub    $0x1,%eax
 8048648:	01 d0                	add    %edx,%eax
 804864a:	c7 45 a4 10 00 00 00 	movl   $0x10,-0x5c(%ebp)
 8048651:	ba 00 00 00 00       	mov    $0x0,%edx
 8048656:	f7 75 a4             	divl   -0x5c(%ebp)
 8048659:	6b c0 10             	imul   $0x10,%eax,%eax
 804865c:	29 c4                	sub    %eax,%esp
 804865e:	89 e0                	mov    %esp,%eax
 8048660:	83 c0 0f             	add    $0xf,%eax
 8048663:	c1 e8 04             	shr    $0x4,%eax
 8048666:	c1 e0 04             	shl    $0x4,%eax
 8048669:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*space = 0; /* So that don't get complaint of unused variable */
 804866c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 804866f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	test();
 8048675:	e8 6c ff ff ff       	call   80485e6 <test>
	return 0;
 804867a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 804867f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
 8048682:	c9                   	leave  
 8048683:	8d 61 fc             	lea    -0x4(%ecx),%esp
 8048686:	c3                   	ret    
 8048687:	90                   	nop
 8048688:	90                   	nop
 8048689:	90                   	nop
 804868a:	90                   	nop
 804868b:	90                   	nop
 804868c:	90                   	nop
 804868d:	90                   	nop
 804868e:	90                   	nop
 804868f:	90                   	nop

08048690 <__libc_csu_init>:
 8048690:	55                   	push   %ebp
 8048691:	57                   	push   %edi
 8048692:	56                   	push   %esi
 8048693:	53                   	push   %ebx
 8048694:	e8 69 00 00 00       	call   8048702 <__i686.get_pc_thunk.bx>
 8048699:	81 c3 5b 19 00 00    	add    $0x195b,%ebx
 804869f:	83 ec 1c             	sub    $0x1c,%esp
 80486a2:	8b 6c 24 30          	mov    0x30(%esp),%ebp
 80486a6:	8d bb 20 ff ff ff    	lea    -0xe0(%ebx),%edi
 80486ac:	e8 ab fc ff ff       	call   804835c <_init>
 80486b1:	8d 83 20 ff ff ff    	lea    -0xe0(%ebx),%eax
 80486b7:	29 c7                	sub    %eax,%edi
 80486b9:	c1 ff 02             	sar    $0x2,%edi
 80486bc:	85 ff                	test   %edi,%edi
 80486be:	74 29                	je     80486e9 <__libc_csu_init+0x59>
 80486c0:	31 f6                	xor    %esi,%esi
 80486c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 80486c8:	8b 44 24 38          	mov    0x38(%esp),%eax
 80486cc:	89 2c 24             	mov    %ebp,(%esp)
 80486cf:	89 44 24 08          	mov    %eax,0x8(%esp)
 80486d3:	8b 44 24 34          	mov    0x34(%esp),%eax
 80486d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 80486db:	ff 94 b3 20 ff ff ff 	call   *-0xe0(%ebx,%esi,4)
 80486e2:	83 c6 01             	add    $0x1,%esi
 80486e5:	39 fe                	cmp    %edi,%esi
 80486e7:	75 df                	jne    80486c8 <__libc_csu_init+0x38>
 80486e9:	83 c4 1c             	add    $0x1c,%esp
 80486ec:	5b                   	pop    %ebx
 80486ed:	5e                   	pop    %esi
 80486ee:	5f                   	pop    %edi
 80486ef:	5d                   	pop    %ebp
 80486f0:	c3                   	ret    
 80486f1:	eb 0d                	jmp    8048700 <__libc_csu_fini>
 80486f3:	90                   	nop
 80486f4:	90                   	nop
 80486f5:	90                   	nop
 80486f6:	90                   	nop
 80486f7:	90                   	nop
 80486f8:	90                   	nop
 80486f9:	90                   	nop
 80486fa:	90                   	nop
 80486fb:	90                   	nop
 80486fc:	90                   	nop
 80486fd:	90                   	nop
 80486fe:	90                   	nop
 80486ff:	90                   	nop

08048700 <__libc_csu_fini>:
 8048700:	f3 c3                	repz ret 

08048702 <__i686.get_pc_thunk.bx>:
 8048702:	8b 1c 24             	mov    (%esp),%ebx
 8048705:	c3                   	ret    
 8048706:	90                   	nop
 8048707:	90                   	nop
 8048708:	90                   	nop
 8048709:	90                   	nop
 804870a:	90                   	nop
 804870b:	90                   	nop
 804870c:	90                   	nop
 804870d:	90                   	nop
 804870e:	90                   	nop
 804870f:	90                   	nop

08048710 <__do_global_ctors_aux>:
 8048710:	55                   	push   %ebp
 8048711:	89 e5                	mov    %esp,%ebp
 8048713:	53                   	push   %ebx
 8048714:	83 ec 04             	sub    $0x4,%esp
 8048717:	a1 14 9f 04 08       	mov    0x8049f14,%eax
 804871c:	83 f8 ff             	cmp    $0xffffffff,%eax
 804871f:	74 13                	je     8048734 <__do_global_ctors_aux+0x24>
 8048721:	bb 14 9f 04 08       	mov    $0x8049f14,%ebx
 8048726:	66 90                	xchg   %ax,%ax
 8048728:	83 eb 04             	sub    $0x4,%ebx
 804872b:	ff d0                	call   *%eax
 804872d:	8b 03                	mov    (%ebx),%eax
 804872f:	83 f8 ff             	cmp    $0xffffffff,%eax
 8048732:	75 f4                	jne    8048728 <__do_global_ctors_aux+0x18>
 8048734:	83 c4 04             	add    $0x4,%esp
 8048737:	5b                   	pop    %ebx
 8048738:	5d                   	pop    %ebp
 8048739:	c3                   	ret    
 804873a:	90                   	nop
 804873b:	90                   	nop

Disassembly of section .fini:

0804873c <_fini>:
 804873c:	53                   	push   %ebx
 804873d:	83 ec 08             	sub    $0x8,%esp
 8048740:	e8 00 00 00 00       	call   8048745 <_fini+0x9>
 8048745:	5b                   	pop    %ebx
 8048746:	81 c3 af 18 00 00    	add    $0x18af,%ebx
 804874c:	e8 df fc ff ff       	call   8048430 <__do_global_dtors_aux>
 8048751:	83 c4 08             	add    $0x8,%esp
 8048754:	5b                   	pop    %ebx
 8048755:	c3                   	ret    
