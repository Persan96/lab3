
.data

.text
.global addition
addition:
	popq	%rbx # Callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	addq	%rsi, %rdi # %rdi + %rsi, result saved in %rdi

	pushq	%rdi # Push result
	pushq	%rbx # Push back callee address

	ret # Pops address to return to from stack

.global subtraction
subtraction:
	popq	%rbx # Callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	subq	%rsi, %rdi # %rdi - rsi, result saved in %rdi

	pushq	%rdi # Push result
	pushq	%rbx # Push back callee address

	ret 
