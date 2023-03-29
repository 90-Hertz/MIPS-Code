.data
array: .space 100    # khai báo mảng với 25 phần tử, mỗi phần tử có kích thước 4 byte
str1: .asciiz "Nhap so luong phan tu mang: "
str2:.asciiz"["
str3:.asciiz"] = "
str4: .asciiz "\nPhan tu lon nhat trong mang: "
str5: .asciiz"\nPhan tu nho nhat trong mang: "
max:.word 
min:.word 

.text
    # in thông báo nhập mảng
    li $v0, 4           # hàm in chuỗi
    la $a0, str1        # địa chỉ của chuỗi cần in
    syscall
    # nhập số lượng phần tử mảng 
    li $v0,5
    syscall
    #gán giá trị vừa nhập vào $t2
    move $t2,$v0 
    # nhập giá trị từ bàn phím và lưu vào mảng
    li $t0, 0           # khởi tạo biến đếm i = 0
    la $s1, array       # địa chỉ của mảng
input_loop:
    beq $t0, $t2, findmax   # nếu i = $t2, kết thúc vòng lặp
    
    li $v0, 4           
    la $a0,str2
    syscall
    
    li $v0, 1          
    move $a0,$t0
    syscall
    
    li $v0, 4           
    la $a0,str3
    syscall
    
    li $v0, 5           # hàm đọc giá trị nguyên từ bàn phím
    syscall
    sw $v0, 0($s1)      # lưu giá trị vừa nhập vào mảng
    addi $t0, $t0, 1    # tăng biến đếm i lên 1
    addi $s1, $s1, 4    # tăng địa chỉ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    j input_loop

findmax:
    la $t1,array
    li $t0,0
    lw $t4, 0($t1)        # lưu giá trị đầu tiên vào $t1
    addi $t1, $t1, 4      # tăng con trỏ mảng lên 4 byte để trỏ tới phần tử tiếp theo

loop:
    beq $t0,$t2,findmin
    lw $t3, 0($t1)        # lấy giá trị từ mảng
    bge $t4, $t3, else    # so sánh giá trị hiện tại với giá trị lớn nhất hiện tại
    move $t4, $t3         # nếu giá trị hiện tại lớn hơn giá trị lớn nhất hiện tại, lưu giá trị đó vào $t4
    addi $t1, $t1, 4      # tăng con trỏ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    addi $t0, $t0,1   
    j loop
else:
    addi $t1, $t1, 4      # tăng con trỏ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    addi $t0, $t0,1  
    j loop
    
findmin:
    la $t6,array
    li $t0,0
    lw $t5, 0($t6)        # lưu giá trị đầu tiên vào $t1
    addi $t6, $t6, 4      # tăng con trỏ mảng lên 4 byte để trỏ tới phần tử tiếp theo

loop1:
    beq $t0,$t2,print
    lw $t3, 0($t6)        # lấy giá trị từ mảng
    ble $t5, $t3, else1   # so sánh giá trị hiện tại với giá trị lớn nhất hiện tại
    move $t5, $t3         # nếu giá trị hiện tại lớn hơn giá trị lớn nhất hiện tại, lưu giá trị đó vào $t4
    addi $t1, $t1, 4      # tăng con trỏ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    addi $t0, $t0,1   
    j loop1
else1:
    addi $t1, $t1, 4      # tăng con trỏ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    addi $t0, $t0,1  
    j loop1
    
print:
    li $v0, 4           
    la $a0,str4
    syscall
    li $v0,1
    move $a0,$t4
    syscall
    li $v0, 4           
    la $a0,str5
    syscall
    li $v0,1
    move $a0,$t5
    syscall
    


