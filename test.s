.data
	a:	.quad 0
	b:	.quad 0
	c:	.quad 0
	d:	.quad 0
	e:	.quad 0
	f:	.quad 0
	g:	.quad 0
	h:	.quad 0
	i:	.quad 0
	j:	.quad 0
	k:	.quad 0
	l:	.quad 0
	m:	.quad 0
	n:	.quad 0
	o:	.quad 0
	p:	.quad 0
	q:	.quad 0
	r:	.quad 0
	s:	.quad 0
	t:	.quad 0
	u:	.quad 0
	v:	.quad 0
	w:	.quad 0
	x:	.quad 0
	y:	.quad 0
	z:	.quad 0

.text
.global main
main:
	pushq	$0
	movabsq	$-1156841474, %rax
	pushq	%rax
	popq	a
	movabsq	$2684, %rax
	pushq	%rax
	popq	b
	pushq	a
	call	stackPrint
	pushq	b
	call	stackPrint
L000:
	pushq	a
	pushq	b
	call	stackCompNE
	jne	L001
	pushq	a
	pushq	b
	call	stackCompGT
	jne	L002
	pushq	a
	pushq	b
	call	stackSub
	popq	a
	jmp	L003
L002:
	pushq	b
	pushq	a
	call	stackSub
	popq	b
L003:
	jmp	L000
L001:
	pushq	a
	call	stackPrint
	pushq	b
	call	stackPrint
	popq	%rax
	ret

