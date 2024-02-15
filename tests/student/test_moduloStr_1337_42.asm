	.data
	.globl main
numberstr:
	.asciiz "1337"
numberstr_end:
	.text
main:
	# a0: start
	la	$a0 numberstr
	# a1: num of bytes
	la	$a1 numberstr_end
	sub	$a1 $a1 $a0
	sub	$a1 $a1 1
	# a2: divisor
	la	$a2 42
	jal	modulo_str
	# a0 mod a2 (1337 mod 42 = 35)
	move	$a0 $v0
	# print result
	li	$v0 1
	syscall
	# exit
	li	$v0 10
	syscall
