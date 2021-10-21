#Laboratory Exercise 5, Home Assignment 3
.data
string: .space 50
Message1:    .asciiz "what's your name : "
Message2:    .asciiz "Your name length : "
.text
main:
get_string:   
	li $v0 ,54 # assign 54 to $v0
	la $a0 , Message1 #load address of Message 1 to $a0
	la $a1 , string #load address of Message 2 to $a1
	la $a2 , 50	#load address of 50 to $a2
syscall #display Message 1
get_length:   
	la $a0 , string #load address of string to $a0
	add $t1,$a0,$t0 #t1 = a0 + t0
check_char:  
	add $t1,$a0,$t0 # t1 = a0 + t0
	lb $t2,0($t1)#load byte t1 and save to t2 
	beq $t2,$zero,end_of_str #if t2 = zero branch to end_of_str
	addi $t0,$t0,1 #t0=t0+1
	j check_char #loop
end_of_str:                             
end_of_get_length:
print_length:
	li $v0 ,56 #assign 56 to v0
	la $a0,Message2 #load address Message 2 to a0
	add $a1,$t0,-1 #a1 = t0 -1
syscall #display Message 2
