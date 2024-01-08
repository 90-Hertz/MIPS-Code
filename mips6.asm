.data
    prompt:         .asciiz "Nhap mot ky tu: "
    newline:        .asciiz "\n"
    digit_msg:      .asciiz "So"
    lowercase_msg:  .asciiz "Chu thuong"
    uppercase_msg:  .asciiz "Chu hoa"
    invalid: 	     .asciiz"Invalid"

.text
    main:
        li $v0, 4
        la $a0, prompt
        syscall

        li $v0, 12
        syscall
        move $t0, $v0  
        
        li $t1, 48      # ASCII của '0'
        li $t2, 57      # ASCII của '9'
        blt $t0, $t1, print_invalid
        ble $t0, $t2, print_digit

	li $t1, 65      # ASCII của 'A'
        li $t2, 90      # ASCII của 'Z'
        blt $t0, $t1, print_invalid
        ble $t0, $t2, print_uppercase

        li $t1, 97      # ASCII của 'a'
        li $t2, 122     # ASCII của 'z'
        blt $t0, $t1, print_invalid
        ble $t0, $t2, print_lowercase
	
	j print_invalid

    print_digit:
        li $v0, 4
        la $a0, digit_msg
        syscall
        j exit_program

    print_lowercase:
        li $v0, 4
        la $a0, lowercase_msg
        syscall
        j exit_program

    print_uppercase:
        li $v0, 4
        la $a0, uppercase_msg
        syscall
        j exit_program
    print_invalid:
        li $v0, 4
        la $a0, invalid
        syscall

    exit_program:
        li $v0, 10
        syscall
