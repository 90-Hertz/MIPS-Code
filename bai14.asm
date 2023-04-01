.data
	chuoi1: .asciiz "Nhap so phan tu: "
	chuoi2: .asciiz "["
	chuoi3: .asciiz "]"
	max:  .asciiz  "\nSo lon nhat: "
	min:  .asciiz  "\nSo nho nhat: "
	array:  .word  0:100
.text 

# <Quy ước: $t0: lưu số lượng nhập vào
#	    $t1: lưu số thứ tự hiện tại của stack 
#	    $t2: lưu trữ số nhỏ nhất 
#	    $t3: lưu trữ số lớn nhất 
# >
 
   	 li $v0, 4 
  	  la $a0, chuoi1
  	  syscall 
    
  	  li $v0, 5 
  	  syscall 
 	   move $t0, $v0 

isExit:   
   	 blt $t0, 1, exit 

loopInput: 
	#In chuoi2
  	li $v0, 4
	la $a0, chuoi2
	syscall
	
	#in chỉ số phần tử
    	li $v0, 1
   	add $a0, $t1, 0
   	syscall 
    
  	 #In chuoi3
	li $v0, 4
	la $a0, chuoi3
	syscall
    
    #Doc so nguyen nhap vao va luu vao dia chi $a1
	addi  $v0, $zero, 5 
  	syscall 
  	
    # đây chỉ là xét max, min nên không quan trọng vị trí xuất, xét kiểu gì cũng được 
    	sw $v0, ($sp)
  	add $sp, $sp, 4 
  	add $t1, $t1, 1
    # nếu vị trí hiện tại nhỏ hơn giá trị đầu vào thì tiếp tục lặp 
	blt $t1, $t0, loopInput

#NextAndCreaate_T2_T3: 
    # vào lần cuối cùng duyệt thì mỗi chỉ số $sp bị thừa 1 lần tính 
   	 add $t1, $zero, $zero # $t1 =0 
   	 sub $sp, $sp, 4
 	 sub $t0, $t0, 1
 	 lw $t4, ($sp) 
   	 or $t2, $zero, $t4 #Khi thực hiện OR với giá trị 0, thì kết quả sẽ giống như giá trị ban đầu.
   	 or $t3, $zero, $t4#Do đó, hai dòng lệnh này thực hiện việc sao chép giá trị từ thanh ghi $t4 sang thanh ghi $t2 và $t3, giữ nguyên giá trị ban đầu của $t4. Các thanh ghi $t2 và $t3 sau đó sẽ có giá trị giống nhau và giống với giá trị ban đầu của $t4.
    
MaxMin :
    	lw $t4, ($sp) # lấy dữ liệu từ ($sp) lấy giá trị từ đỉnh ngăn xếp ($sp) và lưu vào thanh ghi $t4.
    MinNumber: 
    	blt $t2, $t4, MaxNumber #so sánh giá trị trong thanh ghi $t2 với giá trị trong $t4. Nếu $t2 nhỏ hơn $t4, thì nhảy đến nhãn MaxNumber. Đây là phần tìm giá trị lớn nhất.
    	add $t2, $t4, $0 #lưu giá trị trong $t4 vào thanh ghi $t2, nếu giá trị trong $t4 lớn hơn giá trị hiện tại trong $t2.
    MaxNumber: 
    	bgt $t3, $t4, Loop #so sánh giá trị trong thanh ghi $t3 với giá trị trong $t4. Nếu $t3 lớn hơn $t4, thì nhảy đến nhãn Loop. Đây là phần tìm giá trị nhỏ nhất.
    	add $t3, $t4, $0 #lưu giá trị trong $t4 vào thanh ghi $t3, nếu giá trị trong $t4 nhỏ hơn giá trị hiện tại trong $t3.
    Loop: 
    	# nếu vị trí hiện tại nhỏ hơn giá trị đầu vào thì tiếp tục lặp 
    	sub $sp, $sp, 4 #giảm con trỏ ngăn xếp ($sp) để trỏ tới phần tử tiếp theo trong mảng.
    	add $t1, $t1, 1#tăng giá trị trong thanh ghi $t1 lên 1, đại diện cho vị trí hiện tại trong mảng.
    	ble $t1, $t0, MaxMin#nếu vị trí hiện tại chưa vượt quá độ dài của mảng, thì nhảy đến nhãn MaxMin để tiếp tục lặp lại quá trình tìm kiếm giá trị lớn nhất và nhỏ nhất.

Print: 
# Min 
    	li $v0, 4 
    	la $a0, min
    	syscall 
    
    	li $v0, 1 
    	add $a0, $zero, $t2 
    	syscall
    
# Max 
    	li $v0, 4
    	la $a0, max
    	syscall 
    
    	li $v0, 1
    	add $a0, $zero, $t3 
    	syscall 
    

exit: 
    	li $v0, 10
    	syscall 
