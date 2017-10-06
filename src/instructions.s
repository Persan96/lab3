
.data
tempStr:	.space 64 # Reserve 64 byte, should be smaller 
			  # Max 64 bit signed int is 9,223,372,036,854,775,807. That is 19 characters 
			  # Min 64 bit signed int is -9,223,372,036,854,775,808. That is 20 characters
testStr:	.asciz "%d\n"

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
	
	imulq	%rdi

	pushq 	%rax # Push result
	pushq	%rbx # Push back callee address
	ret

.global stackDiv
stackDiv:
	popq	%rbx # Save callee address
	popq	%rdi # Divisor | Nämnare
	popq	%rax # Divident | Täljare
	movq	$0, %rdx # idivq uses both %rdx(high) and %rax(low) as divident
		
	idivq 	%rdi
	
	pushq	%rax # Push result
	pushq	%rbx # Push back callee address
	ret

.global stackCompLT
stackCompLT:

	ret

.global stackCompGT
stackCompGT:

	ret

.global stackCompGE
stackCompGE:

	ret

.global stackCompLE
stackCompLE:

	ret

.global stackCompNE
stackCompNE:

	ret

.global stackCompEQ
stackCompEQ:

	ret

.global stackGCD
stackGCD:

	ret

.global stackFact
stackFact:

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
