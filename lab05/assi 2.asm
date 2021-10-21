#Laboratory Exercise 5, Assignment 2
.data
Message1: .asciiz "The sum of "
Message2: .asciiz " and "
Message3: .asciiz " is "
.text
	li $v0, 4 # service 4 is print string
	la $a0, Message1 # the string to be printed is Message1: "The sum of "
	syscall	# execute
	la $s0, 1 # $s0 = 1
	la $s1, 2 # $s1 = 2
	add $t0,$s0,$s1	 # $t0 = $s0 + $s1
	li $v0, 1 # service 1 is print integer
	la $a0, 0($s0) # the interger to be printed is 0($s0)
	syscall	# execute
	li $v0, 4 # service 4 is print string
	la $a0, Message2 # the string to be printed is Message2: " and "
	syscall	# execute
	li $v0, 1 # service 1 is print integer
	la $a0, 0($s1) # the interger to be printed is 0($s1)
	syscall	# execute	
	li $v0, 4 # service 4 is print string
	la $a0, Message3 # the string to be printed is Message3: " is "
	syscall	# execute	
	li $v0, 1 # service 1 is print integer
	la $a0, 0($t0) # the interger to be printed is 0($t0)
	syscall # execute
