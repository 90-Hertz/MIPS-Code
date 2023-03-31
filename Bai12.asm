.data
    buffer:     .space 100      # tạo một vùng nhớ có độ dài tối đa là 100 ký tự
    msg_input:  .asciiz "Enter a string: "
    msg_output: .asciiz "The string you entered: "

.text
main:
    li $v0, 4               # in ra chuỗi "Enter a string: "
    la $a0, msg_input
    syscall

    la $a0, buffer          # đặt địa chỉ của vùng nhớ buffer vào thanh ghi $a0
    li $a1, 100             # đặt độ dài tối đa của chuỗi là 100
    jal read_string         # gọi hàm thủ tục để đọc chuỗi

    li $v0, 4               # in ra chuỗi "The string you entered: "
    la $a0, msg_output
    syscall

    la $a0, buffer          # đặt địa chỉ của vùng nhớ buffer vào thanh ghi $a0
    jal print_string        # gọi hàm thủ tục để in chuỗi

    li $v0, 10              # thoát chương trình
    syscall

read_string:
    li $v0, 8               # syscall số 8 để đọc chuỗi từ bàn phím
    syscall
    jr $ra                  # trả về địa chỉ ban đầu của hàm

print_string:
    li $v0, 4               # syscall số 4 để in chuỗi ra màn hình
    syscall
    jr $ra                  # trả về địa chỉ ban đầu của hàm