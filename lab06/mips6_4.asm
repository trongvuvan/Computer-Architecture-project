.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,5, 6,6,5,4
Aend: .word 
.text
main: la $a0,A #$a0 = Address(A[0])
	  la $a2,A #$a2 = Address(A[i])
	  addi $a2, $a2, 4 # i = 1 
	  la $a1,Aend
	  addi $a1,$a1,-4 #$a1 = Address(A[n-1])
	  addi $s1, $0, 1 # i=1
	  j sort #sort
	  after_sort: li $v0, 10 #exit
	  syscall
end_main:

sort: bgt $a2, $a1, after_sort # for (i = 1; i < n; i++)

	lw $t2, 0($a2) 				  # $t2 = arr[i] = key
	addi $a3, $a2, -4			  # j = i--

	while: blt $a3, $a0, skip_while 
		   lw $t3, 0($a3) 
		   ble $t3, $t2, skip_while	  # while (j >= 0 && arr[j] > key)
		   
		addi $t7, $a3, 4				  # $t7 = j + 1
		sw $t3, 0($t7)				  # arr[j+1] = arr[j] 
		addi, $a3, $a3, -4			  # j--
		j while
		
	skip_while:

	addi $a3, $a3, 4				  # j++
	sw, $t2, 0($a3)				  # arr[j] = key

addi $a2, $a2, 4				  
j sort
