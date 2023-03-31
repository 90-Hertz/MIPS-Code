
.data#định nghĩa phần dữ liệu trong chương trình
str:    .space 100# Đặt kích thước của bộ nhớ cho chuỗi là 100 ký tự
msg:    .asciiz "Nhap chuoi: "# đặt giá trị chuỗi thông báo cho người dùng nhập vào và đặt tên biến là msg

.text #định nghĩa phần lệnh trong chương trình
#.globl main #xác định hàm main sẽ được sử dụng bởi hàm khác
#main:
    # in ra thông báo để yêu cầu nhập chuỗi
    li $v0, 4
    la $a0, msg
    syscall

    # nhập chuỗi vào bộ nhớ
    li $v0, 8
    la $a0, str
    li $a1, 100
    syscall

    # in ra chuỗi ngược lại
    la $a0, str #lấy địa chỉ của chuỗi và lưu vào thanh ghi $a0
    jal reverse_string #gọi hàm reverse_string để đảo ngược chuỗi và in ra kết quả

    # kết thúc chương trình
    li $v0, 10
    syscall

reverse_string:
    # lưu trữ trạng thái thanh ghi
    addi $sp, $sp, -8 #Cấp phát thêm 8 byte trên stack để lưu giữ giá trị của $ra và $s0
    sw $ra, 4($sp)## Lưu giá trị của $ra vào stack
    sw $s0, 0($sp)## Lưu giá trị của $s0 vào stack

    # tìm độ dài của chuỗi
    move $s0, $a0## Sao chép địa chỉ bắt đầu của chuỗi vào $s0
    li $t0, 0
    loop:
        lb $t1, ($s0)## Đọc giá trị ký tự tại địa chỉ $s0 và lưu vào $t1
        beq $t1, 0, reverse_done
        addi $t0, $t0, 1
        addi $s0, $s0, 1
        j loop
    reverse_done:
 	sb $t1, ($s0)#store lưu một byte vào bộ nhớ ở đây 0$s0=$t1

    # in ra chuỗi theo thứ tự ngược lại
    reverse_loop:
        addi $s0, $s0, -1# giảm giá trị địa chỉ con trỏ chuỗi xuống 1 đơn vị
        beq $s0, $a0, reverse_done2# nếu đã duyệt qua hết chuỗi thì chuyển đến nhãn reverse_done2
        lb $a0, ($s0)# load byte từ địa chỉ của con trỏ và lưu vào $a0
        li $v0, 11   # Cấu hình v0 để sử dụng lệnh in ra kết quả
        syscall      # In ra kết quả
        j reverse_loop
   reverse_done2:

    # phục hồi trạng thái thanh ghi
    lw $ra, 4($sp)# Lấy giá trị của trạng thái thanh ghi từ ngăn xếp 
    lw $s0, 0($sp)# Lấy giá trị của thanh ghi từ ngăn xếp 
    addi $sp, $sp, 8# Thay đổi địa chỉ ngăn xếp bằng cách tăng con trỏ ngăn xếp


    jr $ra# Nhảy đến địa chỉ lưu trữ trong thanh ghi trả về

