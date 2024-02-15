	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
	# TODO
	
	li	$t1	0		#initialize byte counter to zero
	li	$t3	0		#calculate the mod in t3
	move	$a3	$a0
loop:
	beq	$a1	$t1 	end	#compare number of bytes in buffer with counter, end if equal
	lb	$t2	0($a3)	#take one number at a time with the counter
	addiu	$t2	$t2	-48	#convert string to digit
	mul	$t3	$t3	10	#mul by 10	
	rem	$t3	$t3	$a2	#calculate the mod
	addu	$t3	$t3	$t2	#add number to the calculated mod
	rem	$t3	$t3	$a2	#calculate mod again
	
	addiu	$a3	$a3	1	
	
	addiu	$t1	$t1	1
	b 	loop
end:
	move	$v0	$t3				#move the modulous to $v0 and exit
	jr	$ra
