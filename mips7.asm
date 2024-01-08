#Nhập một mảng các số nguyên n phần tử, xuất mảng đó ra màn hình.

.data
array: .space 100    # khai báo mảng với 25 phần tử, mỗi phần tử có kích thước 4 byte
str1: .asciiz "Nhap so luong phan tu mang: "
str2: .asciiz "\nMang vua nhap: "
space: .asciiz" "
str3: .asciiz"["
str4: .asciiz"] = "

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
    la $t1, array       # địa chỉ của mảng
loop:
    beq $t0, $t2, print_array     # nếu i = $t2, kết thúc vòng lặp
    
    li $v0, 4           
    la $a0,str3
    syscall
    
    li $v0, 1          
    la $a0,($t0)
    syscall
    
    li $v0, 4           
    la $a0,str4
    syscall
    
    li $v0, 5           # hàm đọc giá trị nguyên từ bàn phím
    syscall
    sw $v0, 0($t1)      # lưu giá trị vừa nhập vào mảng
    addi $t0, $t0, 1    # tăng biến đếm i lên 1
    addi $t1, $t1, 4    # tăng địa chỉ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    j loop

print_array:
    # in thông báo mảng sau khi nhập
    li $v0, 4           
    la $a0, str2        
    syscall

    # in giá trị từ mảng ra màn hình
    li $t0, 0           # khởi tạo biến đếm i = 0
    la $t1, array       # địa chỉ của mảng
print_loop:
    beq $t0, $t2, exit  # nếu i = $t2, kết thúc chương trình
    
    lw $a0, 0($t1)      # lấy giá trị từ mảng
    li $v0, 1           # hàm in giá trị nguyên ra màn hình
    syscall
    
    li $v0, 4           # in khoảng trắng
    la $a0,space
    syscall
    
    addi $t0, $t0, 1    # tăng biến đếm i lên 1
    addi $t1, $t1, 4    # tăng địa chỉ mảng lên 4 byte để trỏ tới phần tử tiếp theo
    j print_loop

exit:
    li $v0, 10          # hàm thoát chương trình
    syscall
