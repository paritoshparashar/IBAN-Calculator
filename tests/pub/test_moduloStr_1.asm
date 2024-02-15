	.data
	.globl main
numberstr:
	.asciiz "65539"
	.text
main:
	la	$a0 numberstr
	li	$a1 5
	la	$a2 8
	jal	modulo_str
	move	$a0 $v0
	li	$v0 1
	syscall
	li	$v0 10
	syscall
