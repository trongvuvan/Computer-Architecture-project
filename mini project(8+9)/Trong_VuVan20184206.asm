.data
array : .space 256
char : .word
message1 :.asciiz "import the length of array "
message2 : .asciiz "array element = "
message3 :.asciiz "arraychange(input) = "
message4 : .asciiz "wrong number "
.text
#########################################################################
#################### 						IMPORT										##############################
#########################################################################
main:
	jal input											# jump and link to input
	nop
	jal array_import				# jump and link to loop
	nop
 jal output										# jump and link to output
 nop
end:
	li $v0,10											# execute
	syscall
#get length of array
input:
	li $v0,51
	la $a0,message1																	#import length of array
 	syscall
 	j check_negative_number
 
#get element of array
array_import		:
	beq $t6,$t7,handle																#if i = n , end loop and start check array change
	li $v0,51															
	la $a0,message2																			#input element of array
	syscall
	j check_array
	# Hi?u mang máng code thôi, mà thi?u n?p t? thanh ghi v? vùng array r?i 
#########################################################################
################ 				CHECK_VALID_NUMBER_AREA							######################
#########################################################################
# check_length_of_array
check_negative_number:
	blez $a0,error_length																	# if n < 0 error
	la $a1,char																											
	beq $a0,$a1,error_length														# if n is character -> error
	move $t7,$a0																										# t7 = n
	jr $ra																																# return
	nop
check_array:
	blez $a0,error_array																		# a[i] < 0 error					
	la $a2,char												
	beq $a0,$a2,error_array															#a[i] is character -> error	
	la $a1,array
	add $t8, $t6, $t6																					# t8 = 2i
	add $t8, $t8, $t8																					# t8 = 4i
	add $a1, $a1, $t8																					# a[i] address = a[i]+4i
	sw $a0, ($a1)																									# store a[i]
	addi $t6,$t6,1
	j array_import																								# jump to array import
# print_error
error_length:
	li $v0,55
	la $a0,message4																							# print error
	syscall
	j input																															#jump to input
error_array:	
	li $v0,55
	la $a0,message4																							# print error
	syscall
	j array_import																								# jump to array import
# store_element_of_array
#########################################################################
#################### 				MAIN_AREA							###############################
#########################################################################
#	for (int i = 1; i < inputArray.Length; i++){
#                if (inputArray[i] <= inputArray[i - 1]){
#                    result += inputArray[i] - inputArray[i+1] + 1;
#		     													inputArray[i+1] = inputArray[i] + 1;
#                }
#            }
handle:
		la $a0, array
		lw $t0, 0($a0) 						#load A[0]
		addi $t7, $t7, -1
for:
	
	addi $a0, $a0, 4						#load a[1+i] 
	lw $t1, ($a0)									# save a[1+i] to t1

	bgt $t1, $t0, skip				# if(Arr[i+1] > Arr[i]) skip
	sub $t2, $t0, $t1	
	addi $t2, $t2, 1						# $t2 = Arr[i] - Arr[i+1] + 1 
	add $v1, $v1, $t2					# $v1 = out = out + $t2 = out + Arr[i] - Arr[i+1] + 1
	addi $t1, $t0, 1						# A[i+1] = A[i] + 1
	
skip:
	addi $t5,$t5,1
	add $t0, $t1, $zero 		# a[i] = a[i+1] 
	bne $t5, $t7, for 				# if i != n branch to for
	jr $ra																# return main
	nop
	#*************************************************************************************************
output : 
	la $a0, message3 					# else print mesage
	add $a1, $v1, $zero  	# arrayinput = v1
	li $v0, 56												# print array(input)
	syscall
	jr $ra																#return main

