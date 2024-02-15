	.data
	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
	
	
	#TODO
		
	
	lb	$t1	4($a0)
	sb	$t1	0($a1)
	lb	$t1	5($a0)
	sb	$t1	1($a1)
	lb	$t1	6($a0)
	sb	$t1	2($a1)
	lb	$t1	7($a0)
	sb	$t1	3($a1)
	lb	$t1	8($a0)
	sb	$t1	4($a1)
	lb	$t1	9($a0)
	sb	$t1	5($a1)
	lb	$t1	10($a0)
	sb	$t1	6($a1)
	lb	$t1	11($a0)
	sb	$t1	7($a1)
	
	
	
	
	
	
	
	lb	$t1	12($a0)
	sb	$t1	0($a2)
	
	lb	$t1	13($a0)
	sb	$t1	1($a2)

	lb	$t1	14($a0)
	sb	$t1	2($a2)
	
	lb	$t1	15($a0)
	sb	$t1	3($a2)
	
	lb	$t1	16($a0)
	sb	$t1	4($a2)
	
	lb	$t1	17($a0)
	sb	$t1	5($a2)
	
	lb	$t1	18($a0)
	sb	$t1	6($a2)
	
	lb	$t1	19($a0)
	sb	$t1	7($a2)
	
	lb	$t1	20($a0)
	sb	$t1	8($a2)
	
	lb	$t1	21($a0)
	sb	$t1	9($a2)
	
	jr	$ra