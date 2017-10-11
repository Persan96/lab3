
.data
tempStr:	.space 64 # Reserve 64 byte, should be smaller
			  # Max 64 bit signed int is 9,223,372,036,854,775,807. That is 19 characters
			  # Min 64 bit signed int is -9,223,372,036,854,775,808. That is 20 characters

.text
.global stackAdd
stackAdd:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	addq	%rsi, %rdi # %rdi + %rsi, result saved in %rdi

	pushq	%rdi # Push result
	pushq	%rbx # Push back callee address

	ret # Pops address to return to from stack

.global stackSub
stackSub:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	subq	%rsi, %rdi # %rdi - rsi, result saved in %rdi

	pushq	%rdi # Push result
	pushq	%rbx # Push back callee address

	ret

.global stackMul
stackMul:
	popq	%rbx # Save callee address
	popq	%rax # Param 2
	popq	%rdi # Param 1

	imulq	%rdi # %rdi * %rax, result saved in %rax

	pushq 	%rax # Push result
	pushq	%rbx # Push back callee address
	ret

.global stackDiv
stackDiv:
	popq	%rbx # Save callee address
	popq	%rdi # Divisor | Nämnare
	popq	%rax # Divident | Täljare
	movq	$0, %rdx # idivq uses both %rdx(high) and %rax(low) as divident

	idivq 	%rdi # %rax / %rdi, result saved in %rax

	pushq	%rax # Push result
	pushq	%rbx # Push back callee address
	ret

.global stackCompLT
stackCompLT:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	# Used to flag true or false
	movq	$1, %rax
	movq	$0, %rdx

	cmpq	%rsi, %rdi
	jge		compLTExit # Jump if param 1 is bigger or equal to param 2, return false

	movq	$1, %rdx # Param 1 is smaller, return true

	compLTExit:
		cmpq	%rax, %rdx # "Return value"
		pushq	%rbx # Push back callee address
		ret

.global stackCompGT
stackCompGT:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	# Used to flag true or false
	movq	$1, %rax
	movq	$0, %rdx

	cmpq	%rsi, %rdi
	jle	compGTExit # Jump if param 1 is less or equal to param 2, return false

	movq	$1, %rdx # Param 1 is bigger, return true

	compGTExit:
		cmpq	%rax, %rdx # "Return value"
		pushq	%rbx # Push back callee address
		ret

.global stackCompGE
stackCompGE:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	# Used to flag true or false
	movq	$1, %rax
	movq	$0, %rdx

	cmpq	%rsi, %rdi
	jl		compGEExit # Jump if param 1 is less than param 2, return false

	movq	$1, %rdx # Param 1 is bigger or equal, return true

	compGEExit:
		cmpq	%rax, %rdx # "Return value"
		pushq	%rbx # Push back callee address
		ret

.global stackCompLE
stackCompLE:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	# Used to flag true or false
	movq	$1, %rax
	movq	$0, %rdx

	cmpq	%rsi, %rdi
	jg		compLEExit # Jump if param 1 is greater than param 2, return false

	movq	$1, %rdx # Param 1 is less or equal, return true

	compLEExit:
		cmpq	%rax, %rdx # "Return value"
		pushq	%rbx # Push back callee address
		ret

.global stackCompNE
stackCompNE:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	# Used to flag true or false
	movq	$1, %rax
	movq	$0, %rdx

	cmpq	%rsi, %rdi
	je		compNEExit # Jump if param 1 is equal param 2, return false

	movq	$1, %rdx # Param 1 is not equal to param 2, return true

	compNEExit:
		cmpq	%rax, %rdx # "Return value"
		pushq	%rbx # Push back callee address
		ret

.global stackCompEQ
stackCompEQ:
	popq	%rbx # Save callee address
	popq	%rsi # Param 2
	popq	%rdi # Param 1

	# Used to flag true or false
	movq	$1, %rax
	movq	$0, %rdx

	cmpq	%rsi, %rdi
	jne		compEQExit # Jump if param 1 is not equal param 2, return false

	movq	$1, %rdx # Param 1 is equal to param 2, return true

	compEQExit:
		cmpq	%rax, %rdx # "Return value"
		pushq	%rbx # Push back callee address
		ret

.global stackNeg
stackNeg:
	popq 	%rbx # Save callee address
	popq 	%rdi # Param 1

	negq	%rdi # Switch sign

	pushq	%rdi # Push back result
	pushq	%rbx # Push back callee address
	ret

.global stackGCD
stackGCD:

	ret

.global stackFact
stackFact:
	popq 	%rbx # Save callee address
	popq 	%rdi # Param 1

	cmpq 	$0, %rdi # check if input is less than 0
	jle 	compLess

	cmpq 	$1, %rdi # check if input is zero or one
	jle 	comZerOrOne

	pushq	%rbx # Push callee address
	pushq %rdi # If input is not zero or one push value to collect later
	decq	%rdi # prepare param
	pushq %rdi # push param
	call 	stackFact # call itself
	popq 	%rdi # pop result
	popq 	%rax # collect what was sent in before
	popq	%rbx # Pop Callee addres

	imulq %rdi # multiply values and result goes into rax
	jmp 	factExit # jump to exit

	comZerOrOne:
		movq	$1, %rax # move 1 to %rax
		jmp 	factExit

	compLess:
		movq 	$0, %rax # move 0 to %rax

	factExit:
		pushq %rax # push result to stack
		pushq %rbx # push callee address to stack
		ret

.global stackLntwo
stackLntwo:

	ret

.global stackPrint
stackPrint:

	popq	%rbx # Callee address
	popq	%rsi # Param

	# Save registers
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	pushq	%r12

	# Set registers to 0
	xorq	%r8, %r8 # Length of string
	xorq	%r9, %r9 # Temp storage
	xorq	%r10, %r10 # Store address to tempStr
	xorq	%r11, %r11 # Counter for number of digits
	xorq	%r12, %r12 # Sign flag

	movq	%rsi, %rax # Prepare for division

	# Check if the int is negative
	cmpq	$0, %rsi
	jge	convertIntToAscii # Not a negative number

	negq	%rsi # Make it positive
	incq	%r12 # Set the sign flag to true for later use
	movq	%rsi, %rax # Prepare for division

	# Take the modulus from the int/10 to get one digit at a time
	# Then add ascii 0 to that digit to convert it to the ascii representation
	# Push this converted part to the stack
	convertIntToAscii:
		# Divide int with 10
		movq	$0, %rdx
		movq	$10, %r10
		idivq	%r10

		addq 	$'0', %rdx # Convert mod to ascii
		pushq	%rdx # Push to stack
		incq	%r11 # Increase counter

		# Check if we are done, result from div should be 0 if we are done
		cmpq	$0, %rax
		jne	convertIntToAscii

	# Load address of tempStr
	leaq	tempStr, %r10
	cmpq	$0, %r12
	je	addToStr

	# Add minus sign to tempStr
	movb	$'-', (%r10) # Add minus sign
	incq	%r10 # Move pointer
	incq	%r8

	# Add all the numbers on the stack in to tempStr
	addToStr:
		popq	%r9
		movb	%r9b, (%r10)

		incq	%r10 # Move pointer forward in tempStr
		incq	%r8 # Increase number of characters in tempStr
		decq	%r11 #

		# Check if we have added all the digits
		cmpq	$0, %r11
		jg	addToStr

	# Add new line
	movb	$'\n', (%r10)
	incq	%r8

	# Print result
	movq	$1, %rax # Syscall for write
	movq	$1, %rdi # Write to stdout
	movq	$tempStr, %rsi # String to use
	movq	%r8, %rdx # How many characters
	syscall

	# Restore registers
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	popq	%r12

	# Push back the return address to the stack and return
	pushq	%rbx
	ret
