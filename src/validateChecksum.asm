	.data
ibanBuffer:	.space	24
a1:	.space 8
a2:	.space 10
stack:		.space 4
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments: 
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	# TODO 
	la	$a1	a1
	la	$a2	a2
	addiu	$sp	$sp	-4	#build stack
	sw	$ra	0($sp)	
	jal	iban2knr		#get blz and knr in a1 and a2 buffer respectively
	lw	$ra	0($sp)	
	addiu	$sp	$sp	4	#destroy stack
	#________________________________________________
	
	la	$s0	ibanBuffer	#load address of 24 byte space into s0
	move	$s5	$s0
	#________________________________________________
	
	li	$s7	8
	li	$s6	0		#counter for blz
	
loop1:					#load contents on a1 buffer into 24byte buffer
	beq	$s7	$s6	loop2
	lb	$s1	0($a1)		
	sb	$s1	0($s5)	
	addiu	$a1	$a1	1
	addiu	$s5	$s5	1
	addiu	$s6	$s6	1
	b 	loop1
	
	
loop2:	
	li	$s7	10
	li	$s6	0		#counter for blz
	
loop3:					#load contents on a2 buffer into 24byte buffer
	beq	$s7	$s6	countrycode
	lb	$s1	0($a2)		
	sb	$s1	0($s5)
	addiu	$a2	$a2	1
	addiu	$s5	$s5	1
	addiu	$s6	$s6	1
	b 	loop3

countrycode:
	li	$s4	0x00000031
	sb	$s4	0($s5)			#load 1
	addiu	$s5	$s5	1
	
	li	$s4	0x00000033
	sb	$s4	0($s5)			#load 3
	addiu	$s5	$s5	1
	
	li	$s4	0x00000031
	sb	$s4	0($s5)			#load 1
	addiu	$s5	$s5	1
	
	li	$s4	0x00000034
	sb	$s4	0($s5)			#load 4
	addiu	$s5	$s5	1
	
loop4:
	lb	$s1	2($a0)		#load 9
	sb	$s1	0($s5)		#continue storing in s5
	addiu	$s5	$s5	1
	
	lb	$s1	3($a0)		#load 8
	sb	$s1	0($s5)		#continue storing in s5
	
	#________________________________________________
	
	move	$a0	$s0
	li	$a1	24
	li	$a2	97
	
	addiu	$sp	$sp	-4	#build stack
	sw	$ra	0($sp)
	jal	modulo_str
	lw	$ra	0($sp)	
	addiu	$sp	$sp	4	#destroy stack		
	jr	$ra
