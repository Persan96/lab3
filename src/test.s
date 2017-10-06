
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
		
	# compareLT test 10 > 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
		
	call 	stackCompGT
	je	GTTestTrue	

	movq	$printTestFalse, %rdi
	movq	$1, %rsi
	call	printf
	jmp	GTTestEnd
	
	GTTestTrue:
		movq	$printTestTrue, %rdi
		movq	$1, %rsi
		call	printf

	GTTestEnd:

	# compareLT test 10 >= 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
		
	call 	stackCompGE
	je	GETestTrue	

	movq	$printTestFalse, %rdi
	movq	$2, %rsi
	call	printf
	jmp	GETestEnd
	
	GETestTrue:
		movq	$printTestTrue, %rdi
		movq	$2, %rsi
		call	printf

	GETestEnd:

	# compareLT test 10 <= 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
		
	call 	stackCompLE
	je	LETestTrue	

	movq	$printTestFalse, %rdi
	movq	$3, %rsi
	call	printf
	jmp	LETestEnd
	
	LETestTrue:
		movq	$printTestTrue, %rdi
		movq	$3, %rsi
		call	printf

	LETestEnd:

	# compareNE test 10 != 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
		
	call 	stackCompNE
	je	NETestTrue	

	movq	$printTestFalse, %rdi
	movq	$4, %rsi
	call	printf
	jmp	NETestEnd
	
	NETestTrue:
		movq	$printTestTrue, %rdi
		movq	$4, %rsi
		call	printf

	NETestEnd:

	# compareEQ test 10 == 5
	# Parameters
	movabsq	$10, %rax
	pushq	%rax
	movabsq	$5, %rax
	pushq	%rax
		
	call 	stackCompEQ
	je	EQTestTrue	

	movq	$printTestFalse, %rdi
	movq	$5, %rsi
	call	printf
	jmp	EQTestEnd
	
	EQTestTrue:
		movq	$printTestTrue, %rdi
		movq	$5, %rsi
		call	printf

	EQTestEnd:

	popq	%rax
	ret
