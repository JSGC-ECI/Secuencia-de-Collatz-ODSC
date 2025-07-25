.data
    .balign 4
scan_format:     .asciz "%d"
print_format:    .asciz "Max = %d\n"

    .balign 4
cases:           .word 0
i:               .word 0
num:             .word 0
max_value:       .word 0
remainder:       .word 0
one:             .word 1
two:             .word 2
three:           .word 3

return_addr:     .word 0

.text
.global scanf
.global printf
.global main
.func main
main:
    LDR     R0, =return_addr
    STR     LR, [R0]

    // Leer número de casos
    LDR     R0, =scan_format
    LDR     R1, =cases
    BL      scanf

    // cases = cases - 1 (ajuste MARIE)
    LDR     R1, =cases
    LDR     R2, [R1]
    SUB     R2, R2, #1
    STR     R2, [R1]

    // i = 0
    MOV     R0, #0
    LDR     R1, =i
    STR     R0, [R1]

loop:
    // if i > cases -> fin
    LDR     R1, =i
    LDR     R2, [R1]
    LDR     R3, =cases
    LDR     R3, [R3]
    CMP     R2, R3
    BGT     end

    // Leer número y guardarlo en num y max_value
    LDR     R0, =scan_format
    LDR     R1, =num
    BL      scanf

    LDR     R1, =num
    LDR     R2, [R1]
    LDR     R3, =max_value
    STR     R2, [R3]

collatz_loop:
    // if num == 1 -> fin de esta secuencia
    LDR     R1, =num
    LDR     R2, [R1]
    CMP     R2, #1
    BEQ     print_max

    // num % 2 == 0?
    ANDS    R3, R2, #1
    BEQ     even_case

    // Odd case: num = num * 3 + 1
    MOV     R3, R2
    ADD     R3, R3, R2
    ADD     R3, R3, R2    // R3 = num * 3
    ADD     R3, R3, #1
    B       check_max

even_case:
    // Even case: num = num / 2
    MOV     R3, R2
    LSR     R3, R3, #1     // Divide by 2 (logical shift right)

check_max:
    // Guardar nuevo num
    LDR     R1, =num
    STR     R3, [R1]

    // Comparar con max_value
    LDR     R1, =max_value
    LDR     R4, [R1]
    CMP     R3, R4
    BLE     collatz_loop

    // Nuevo máximo
    STR     R3, [R1]
    B       collatz_loop

print_max:
    // Imprimir max_value
    LDR     R0, =print_format
    LDR     R1, =max_value
    LDR     R1, [R1]
    BL      printf

    // i++
    LDR     R1, =i
    LDR     R2, [R1]
    ADD     R2, R2, #1
    STR     R2, [R1]
    B       loop

end:
    // Restaurar LR y salir
    LDR     LR, =return_addr
    LDR     LR, [LR]
    MOV     R0, #0
    BX      LR
.end
