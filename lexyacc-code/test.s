
.data

	a:	.quad 0
	b:	.quad 0

	
.text
.global main
main:
	pushq	$0

	movabsq	$732, %rax
	pushq	%rax
	popq	a
	movabsq	$2684, %rax
	pushq	%rax
	popq	b
L000:
	pushq	a
	pushq	b
	call	stackCompNE
	je	L001
	pushq	a
	pushq	b
	call	stackCompGT
	je	L002
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
	pushq	a
	pushq	b
	call	stackAdd
	call	stackPrint

	popq	%rax
	ret
