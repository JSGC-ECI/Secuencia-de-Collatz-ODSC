.data
scan_format:    .asciz "%d"
print_format:   .asciz "Max = %d\n"
cases:          .word 0
num:            .word 0
max_value:      .word 0
i:              .word 0
return_addr:    .word 0

.text
.global main
.func main
main:
    LDR     R0, =return_addr
    STR     LR, [R0]

    LDR     R0, =scan_format
    LDR     R1, =cases
    BL      scanf

    MOV     R4, #0

loop:
    LDR     R1, =i
    STR     R4, [R1]

    LDR     R1, =cases
    LDR     R1, [R1]
    CMP     R4, R1
    BGE     end_program

    LDR     R0, =scan_format
    LDR     R1, =num
    BL      scanf

    LDR     R1, =num
    LDR     R2, [R1]
    MOV     R3, R2

collatz_loop:
    CMP     R2, #1
    BLE     done_sequence

    AND     R5, R2, #1
    CMP     R5, #0
    BEQ     is_even

    ADD     R6, R2, R2
    ADD     R6, R6, R2
    ADD     R2, R6, #1
    B       check_max

is_even:
    MOV     R2, R2, LSR #1

check_max:
    CMP     R2, R3
    BLE     collatz_loop
    MOV     R3, R2
    B       collatz_loop

done_sequence:
    LDR     R0, =print_format
    MOV     R1, R3
    BL      printf

    ADD     R4, R4, #1
    B       loop

end_program:
    LDR     R0, =return_addr
    LDR     LR, [R0]
    MOV     R0, #0
    BX      LR

.end
