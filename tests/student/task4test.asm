.globl	main
.data
a0:	.space	22
a1:	.ascii "59050101"
a2:	.ascii "0012345678"
.text
main:
	la	$a0	a0
	la	$a1	a1
	la	$a2	a2
	
	jal	knr2iban
	
	li	$v0	4
	syscall
	
	li	$v0	10
	syscall