#Nhập vào một chuỗi. Tính chiều dài của chuỗi.

#do asciiz kết thúc bằng null nên có thể kiếm tra bằng vòng lặp khi gặp null thì kết thúc
.data
    string:.asciiz
    str: .asciiz" Nhap chuoi : "
    str1:.asciiz"\nChieu dai cua chuoi la : "
.text
    li $v0,4
    la $a0,str
    syscall
#nhap chuoi
    li $v0,8
    la $a0,string#input duoc ghi vao string
    li $a1,30#so ki tu toi da 
    syscall

    li $t1, 0          # khởi tạo biến đếm độ dài chuỗi
    la $a0, string   # đưa địa chỉ của chuỗi vào thanh ghi $a0
loop:
    lb $t0, ($a0)   # lấy giá trị ký tự đầu tiên của chuỗi lb la load a byte nó sẽ nạp giá trị của 1 byte từ $a0 vào $t0
    beq $t0, $zero, end   # nếu giá trị ký tự là 0 (kết thúc chuỗi) thì kết thúc vòng lặp
    addi $a0, $a0, 1      # tăng con trỏ chuỗi để truy cập đến ký tự tiếp theo
    addi $t1, $t1, 1      # tăng biến đếm độ dài chuỗi lên 1
    j loop                # quay lại vòng lặp để kiểm tra ký tự tiếp theo
end:
    li $v0,4
    la $a0,str1
    syscall
    # in ra độ dài của chuỗi
    sub $t1,$t1,1 #ở đây trừ đi bởi vì phần kiểm tra điều kiện bên trên đã làm chỉ số tăng lên 1 đơn vị
    li $v0, 1
    move $a0, $t1
    syscall

    # kết thúc chương trình
    li $v0, 10         # chọn syscall 10 để thoát chương trình
    syscall
