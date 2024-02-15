	.data
	.globl main
ibanstr:
	.asciiz "DE00111111112222222222"
knrbuf:
	.space 10
	.asciiz ""
blzbuf:
	.space 8
	.asciiz ""
	.text
main:
	la	$a0 ibanstr
	la	$a1 blzbuf
	la	$a2 knrbuf
	jal	iban2knr
	la	$a0 blzbuf
	li	$a1 8
	jal	println_range
	la	$a0 knrbuf
	li	$a1 10
	jal	println_range
	li	$v0 10
	syscall
