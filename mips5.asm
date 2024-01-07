#Nhập vào 2 số nguyên, xuất ra số lớn hơn.

.data
    prompt1:    .asciiz "Nhập số nguyên thứ nhất: "
    prompt2:    .asciiz "Nhập số nguyên thứ hai: "
    resultMsg:  .asciiz "Số lớn hơn là: "
    
.text
    main:
        li $v0, 4
        la $a0, prompt1
        syscall
        
        li $v0, 5
        syscall
        move $s0, $v0 # Lưu giữ số thứ nhất vào $s0

        li $v0, 4
        la $a0, prompt2
        syscall

        li $v0, 5
        syscall
        move $s1, $v0 # Lưu giữ số thứ hai vào $s1

        # So sánh và lưu số lớn hơn vào $t0
        bgt $s0, $s1, setGreater
        move $t0, $s1
        j endComparison

    setGreater:
        move $t0, $s0

    endComparison:
        li $v0, 4
        la $a0, resultMsg
        syscall
        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 10
        syscall
