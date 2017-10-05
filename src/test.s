
.data
printNumber:	.asciz "test\n"

.text
.global main
main:
	pushq	$0
	
	# Addition test 10 + 5
	# Parameters
	pushq	$10
	pushq	$5
	
	call	stackAdd
	call	stackPrint

	# Subtraction test 10 - 5
	# Parameters	
	pushq 	$10
	pushq	$5

	call 	stackSub
	call 	stackPrint
	
	popq	%rax
	ret
