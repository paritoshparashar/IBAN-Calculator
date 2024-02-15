	.data
	.globl main
# constants
greeterstr:
	.asciiz "IBAN <-> KNR+BLZ Conversion\n1.) IBAN to KNR+BLZ\n2.) KNR+BLZ to IBAN\nInput:"
destr:
	.asciiz "DE"
invalidstr:
	.asciiz "Invalid input!\n"
ibanstr:
	.asciiz "IBAN:"
knrstr:
	.asciiz "KNR:"
blzstr:
	.asciiz "BLZ:"
newlinestr:
	.asciiz "\n"
zzstr:
	.asciiz "00"
emptystr:
	.asciiz ""
# Meldungen
checksumok_msg:
        .asciiz "Valid checksum!"
checksum_errmsg:
        .asciiz "Invalid checksum!"
deprefix_errmsg:
        .asciiz "No german IBAN prefix!"
  
# local character buffers
# we allocate one additional byte for the null terminator
knrbuf:
	.space 11
blzbuf:
	.space 9
ibanbuf:
	.space 23
    
	.text
main:
	# print greeting
	la	$a0 greeterstr
	jal	print

# wait for input
menu:
	li	$v0 5
	syscall
	beq	$v0 1 menu_iban_to_knr
	beq	$v0 2 menu_knr_to_iban
  
	la	$a0 invalidstr
	jal	print
	j	end



menu_iban_to_knr:
# read IBAN 
	la	$a0 ibanstr
	jal	print
	la	$a0 ibanbuf
	li	$a1 22
	jal	readbuf
# check IBAN 
	la	$a0 ibanbuf
	# jal verify_iban
	# la	$a0 deprefix_errmsg
	# beq	$v0 1 error
	# la	$a0 checksum_errmsg
	# beq	$v0 2 error
	# la	$a0 checksumok_msg
	# jal	println

# call iban_to_knr
	la	$a0 ibanbuf
	la	$a1 blzbuf
	la	$a2 knrbuf
	jal	iban2knr
  
# print KNR
	la	$a0 knrstr
	jal	print
	la	$a0 knrbuf
	jal	println
  
# print BLZ
	la	$a0 blzstr
	jal	print
	la	$a0 blzbuf
	jal	println
  
# exit
	j	end


menu_knr_to_iban:
# read KNR 
	la	$a0 knrstr
	jal	print
	la	$a0 knrbuf
	li	$a1 10
	jal	readbuf
  
# read BLZ 
	la	$a0 blzstr
	jal	print
	la	$a0 blzbuf
	li	$a1 8
	jal	readbuf

	la	$a0 ibanbuf
	la	$a1 blzbuf
	la	$a2 knrbuf
	jal	knr2iban
  
# print IBAN 
	la	$a0 ibanstr
	jal	print
	la	$a0 ibanbuf
	jal	println
	j	end
