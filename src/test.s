
.data
printNumber:	.asciz "%d\n"

.text
.global main
main:
	pushq	$0
	
	# Addition test 10 + 5
	# Parameters
	pushq	$10
	pushq	$5
	
	call	addition
	
	movq	$printNumber, %rdi	
	popq	%rsi # Pop result from stack
	call	printf

	# Subtraction test 10 - 5
	# Parameters	
	pushq 	$10
	pushq	$5

	call 	subtraction

	movq	$printNumber, %rdi	
	popq	%rsi # Pop result from stack
	call	printf
	
	popq	%rax
	ret
