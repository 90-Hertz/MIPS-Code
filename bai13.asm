.data
 input1: .asciiz  "Nhap so nguyen thu 1: "
 input2: .asciiz "\nNhap so nguyen thu 2: " 
 tong: .asciiz "\nTong: "
 hieu: .asciiz "\nHieu: "
 tich: .asciiz "\nTich: "
 thuong: .asciiz "\nThuong: "
 du: .asciiz " Du "
 
.text
.globl main
main:
#-------------------------------------------------NHAP DOI SO----------------------------------------------------------------------#
 li $v0, 4
 la $a0, input1
 syscall
 
 li $v0, 5
 syscall
 move $s0, $v0
 
 li $v0, 4
 la $a0, input2
 syscall
 
 li $v0, 5
 syscall
 move $s1, $v0

 addi $sp, $sp, -20
 
 #-----------------------------------------------GOI CAC THU TUC------------------------------------------------------------------#
 #Dòng lệnh này có tác dụng gán giá trị 31 vào thanh ghi $ra (register $ra là thanh ghi lưu trữ địa chỉ trả về khi hàm kết thúc).

#sử dụng thanh ghi $ra để lưu địa chỉ trở về sau khi hàm thực thi xong. Vì vậy, dòng lệnh này có thể được sử dụng để đặt giá trị trả về của một hàm là 31 (hoặc bất kỳ giá trị nguyên nào khác) trước khi thoát khỏi hàm.
 addi $ra, $zero, 1
 jal Tong
 addi $ra, $zero, 2
 jal Hieu
 addi $ra, $zero, 3
 jal Tich 
 addi $ra, $zero, 4
 jal Thuong
 j In

#-----------------------------------------------CAC HAM THU TUC-------------------------------------------------------------------# 
Tong:
  add $t0, $s0, $s1  
  sw $t0, 0($sp)
  jr $ra
  
Hieu:
 sub $t0, $s0, $s1 
 sw $t0, 4($sp)
 jr $ra

Tich:
 mult $s0, $s1 
 mflo $t0
 sw $t0, 8($sp)
 jr $ra
 
Thuong:
 div $s0, $s1
 mflo $t0
 mfhi $t1
 sw $t0, 12($sp)
 sw $t1, 16($sp)
 jr $ra

#---------------------------------------------------------------KET THUC CHUONG TRINH-----------------------------------------------#
In:
 li $v0, 4
 la $a0, tong
 syscall
  
 li $v0,1 
 lw $a0, 0($sp)
 syscall
  
 li $v0, 4
 la $a0, hieu
 syscall
 
 li $v0,1 
 lw $a0, 4($sp)
 syscall
 
 li $v0, 4
 la $a0, tich
 syscall
 
 li $v0, 1
 lw $a0, 8($sp)
 syscall
 
 li $v0, 4
 la $a0, thuong
 syscall
 
 li $v0,1
 lw $a0, 12($sp)
 syscall
 
 li $v0, 4
 la $a0, du
 syscall
 
 li $v0, 1
 lw $a0, 16($sp)
 syscall 
 
 addi $sp, $sp, 20
Exit:
 li $v0, 10
 syscall
