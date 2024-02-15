	.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
	# TODO
	
	move	$t1	$a0
	
	li	$t2	68
	sb	$t2	0($a0)
	li	$t2	69
	sb	$t2	1($a0)
	li	$t2	48
	sb	$t2	2($a0)
	li	$t2	48
	sb	$t2	3($a0)
	
	li	$t7	8
	li	$t6	0		#counter for blz
	
loop1:					#load contents on a1 buffer into 24byte buffer
	beq	$t7	$t6	loop2
	lb	$t2	0($a1)		
	sb	$t2	4($t1)	
	addiu	$a1	$a1	1
	addiu	$t1	$t1	1
	addiu	$t6	$t6	1
	b 	loop1
	
	
loop2:	
	li	$t7	10
	li	$t6	0		#counter for blz
	
loop3:					#load contents on a2 buffer into 24byte buffer
	beq	$t7	$t6	loop4
	lb	$t2	0($a2)		
	sb	$t2	4($t1)
	addiu	$a2	$a2	1
	addiu	$t1	$t1	1
	addiu	$t6	$t6	1
	b 	loop3
	
loop4:
	addiu	$sp	$sp	-8	#build stack
	sw	$ra	0($sp)	
	sw	$a0	4($sp)
	jal	validate_checksum		
	lw	$ra	0($sp)	
	lw	$a0	4($sp)
	addiu	$sp	$sp	8	#destroy stack	
	
	li	$t4	98
	li	$t6	10
	subu	$t7	$t4	$v0
	div	$t5	$t7	$t6	#divide 98 by 10
	addiu	$t5	$t5	48	#convert 9 into string
	sb	$t5	2($a0)
	rem	$t5	$t7	$t6
	addiu	$t5	$t5	48	#convert 8 into string
	sb	$t5	3($a0)
	jr	$ra
