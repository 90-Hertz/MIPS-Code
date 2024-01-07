Nhập vào một ký tự, xuất ra ký tự liền trước và liền sau.

.data
str: .asciiz""
str1: .asciiz"Nhap mot ki tu "
str2: .asciiz"\nKi tu lien truoc " 
str3: .asciiz"\nKi tu lien sau "

.text
li $v0, 4
la $a0, str1
syscall

li $v0, 12
syscall
move $t0, $v0



add $t1, $t0, 1
sub $t2, $t0, 1

li $v0, 4
la $a0, str2
syscall

li $v0, 11
la $a0, ($t2)
syscall

li $v0, 4
la $a0, str3
syscall

li $v0, 11
la $a0, ($t1)
syscall
