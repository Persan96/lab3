
.data
printTestFalse:	.asciz "%d false\n"
printTestTrue:	.asciz "%d true\n"
printNumber:	.asciz "%d\n"
a:	.quad 0
b:	.quad 0
c:	.quad 0
d:	.quad 0


.text
.global main
main:
	pushq	$0
	
	# Addition test 10 + 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax

	call	stackAdd
	call	stackPrint

	# Subtraction test 10 - 5
	# Parameters	
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
	
	call 	stackSub
	call 	stackPrint
	
	# Multiplication test 10 * 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
	
	call	stackMul
	call	stackPrint
	
	# Division test 10 / 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
	
	call	stackDiv
	call	stackPrint	

	# compareLT test 10 < 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
		
	call 	stackCompLT
	je	LTTestTrue	

	movq	$printTestFalse, %rdi
	movq	$0, %rsi
	call	printf
	jmp	LTTestEnd
	
	LTTestTrue:
		movq	$printTestTrue, %rdi
		movq	$0, %rsi
		call	printf

	LTTestEnd:
		

	popq	%rax
	ret
