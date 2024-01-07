.data
    prompt1:    .asciiz "Nhập số nguyên thứ nhất: "
    prompt2:    .asciiz "Nhập số nguyên thứ hai: "
    resultSum:  .asciiz "Tổng: "
    resultDiff: .asciiz "Hiệu: "
    resultProd: .asciiz "Tích: "
    resultQuot: .asciiz "Thương: "
    errorMsg:   .asciiz "Lỗi: Chia cho 0\n"
    
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

        add $t0, $s0, $s1
        li $v0, 4
        la $a0, resultSum
        syscall
        li $v0, 1
        move $a0, $t0
        syscall

        sub $t1, $s0, $s1
        li $v0, 4
        la $a0, resultDiff
        syscall
        li $v0, 1
        move $a0, $t1
        syscall

        mul $t2, $s0, $s1
        li $v0, 4
        la $a0, resultProd
        syscall
        li $v0, 1
        move $a0, $t2
        syscall

        # Kiểm tra chia cho 0
        beqz $s1, divisionByZero

        div $s0, $s1
        mflo $t3
        li $v0, 4
        la $a0, resultQuot
        syscall
        li $v0, 1
        move $a0, $t3
        syscall

        li $v0, 10
        syscall

    divisionByZero:
        li $v0, 4
        la $a0, errorMsg
        syscall

        li $v0, 10
        syscall
