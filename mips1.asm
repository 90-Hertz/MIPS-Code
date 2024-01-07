#Nhập vào 1 chuỗi, xuất lại chuỗi đó ra màn hình.

.data
str: .asciiz""
str1: .asciiz"Nhap mot chuoi "
str2: .asciiz"Chuoi da nhap " 

.text
li $v0, 4
la $a0, str1
syscall

li $v0, 8
la $a0, str
li $a1, 100
syscall

li $v0, 4
la $a0, str2
syscall

li $v0, 4
la $a0, str
syscall
