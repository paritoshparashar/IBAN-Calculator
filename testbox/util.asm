	.data
	.globl memcpy
	.globl int_to_buf
	.globl println
	.globl print
	.globl readbuf
	.globl end
	.globl error
	.globl println_range

newlinestr:
	.asciiz "\n"
	.text
	
# -- memcpy --
# Arguments:
# a0: target address
# a1: source address
# a2: number of bytes
# Return: none
# Semantics:
# Copies the memory area [$a1 to $a1 + $a2 - 1] to [$a0 to $a0 + $a2 - 1]
memcpy:
	move	$t0 $a0 # $t0 = current target address
	move	$t1 $a1 # $t1 = current source address
	addu	$t2 $a1 $a2 # $t2 = last source address

mc_loop:
	lbu	$t4 ($t1)
	sb	$t4 ($t0)
	addu	$t0 $t0 1
	addu	$t1 $t1 1
	bltu	$t1 $t2 mc_loop

mv_return:
	jr	$ra

# -- int_to_buf --
# Arguments:
# a0: positive integer
# a1: target address
# a2: number of digits (counted from the from right)
# Return: none
# Semantics:
# Writes the first $a2 digits of the positive integer in $a0 as a decimal string to the memory area [$a1 to $a1 + $a2 - 1]
int_to_buf:
	move	$t2 $a1       # $t2 start address
	add	$t3 $a1 $a2
	subu	$t1 $t3 1   # $t1 address of last character
	move	$t0 $a0       # $t0 remaining number

ib_loop:
# $t0 remaining number
# remove the least significant digit from $t0 and store it in $t3
# $t3 contains the least significant digit
	move	$t3 $t0
	divu	$t0 $t0 10
	mulu	$t4 $t0 10
	subu	$t3 $t3 $t4 # $t3 = $t3 - (($t3 / 10) * 10)

# Convert the digit in $t3 to an ASCII character and write it to $t1
	addu	$t3 $t3 48
	sb	$t3 ($t1)

# Move to the next digit
	subu	$t1 $t1 1
	bgeu	$t1 $t2 ib_loop

ib_return:
	jr	$ra

# a0 : String
# a1 : number of characters
println_range:
	addu	$t1 $a0 $a1
	move	$t0 $a0
	li	$v0 11
pr_loop:
	bgeu	$t0 $t1 pr_exit
	lbu	$a0 0($t0)
	syscall
	addiu	$t0 $t0 1
	b	pr_loop
	
pr_exit:
	li	$a0 10 # '\n'
	syscall
	jr	$ra

# Print the string at $a0
print:
	li	$v0 4
	syscall
	jr	$ra

# -- println --
# Arguments:
# a0: address of the string
# Return: none
# Semantics:
# Writes the string at $a0 to the console and appends a newline character
println:
	li	$v0 4
	syscall
	la	$a0 newlinestr
	syscall  
	jr	$ra
	
# -- readbuf --
# Arguments:
# a0: target address
# a1: number of characters
# Return: none
# Semantics:
# Reads a string of at most $a1 characters from the console and stores it in the memory area [$a0 to $a0 + $a1 - 1]
readbuf:
	# read the input
	addu	$a1 $a1 1
	li	$v0 8
	syscall
	# jump to new line
	la	$a0 newlinestr
	li	$v0 4
	syscall
  	jr	$ra

# -- end --
# Arguments: none
# Return: none
# Semantics: Terminates the program
end:
	li	$v0 10
	syscall

# -- error --
# Arguments:
# a0: error message (null-terminated string)
# Return: none
# Semantics: Prints the error message and terminates the program
error:
# Print the error message
	li	$v0 4
	syscall
# exit with error code 1
	li	$a0 1
	li	$v0 17
	syscall
