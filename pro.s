.global _start

.section .data
    prompt_cases: .asciz "Numero de casos: "
    prompt_input: .asciz "Ingrese numero: "
    output_fmt:   .asciz "Maximo valor: %d\n"

    num_cases: .word 2          @ Número de casos de prueba
    inputs:    .word 4, 7       @ Ejemplo de entrada: 4 y 7

.section .bss
    num: .skip 4
    max: .skip 4

.section .text
_start:
    ldr r4, =inputs        @ r4 apunta al arreglo de entradas
    ldr r5, =num_cases     @ r5 tiene la dirección del número de casos
    ldr r6, [r5]           @ r6 = cantidad de casos
    mov r7, #0             @ r7 = contador de casos

loop_cases:
    cmp r7, r6             @ si r7 == casos, salir
    beq end_program

    ldr r0, [r4, r7, LSL #2] @ cargar input[r7] en r0
    mov r1, r0             @ r1 = num actual
    mov r2, r0             @ r2 = max actual

collatz_loop:
    cmp r1, #1
    beq print_max          @ si num == 1, terminamos esta secuencia

    and r3, r1, #1         @ r3 = r1 % 2
    cmp r3, #0
    beq is_even            @ si es par
    b   is_odd             @ si es impar

is_even:
    mov r1, r1, LSR #1     @ dividir entre 2 usando shift
    b   update_max

is_odd:
    mov r3, r1, LSL #1     @ r3 = 2*num
    add r1, r3, r1         @ r1 = 3*num
    add r1, r1, #1         @ r1 = 3*num + 1

update_max:
    cmp r1, r2
    ble collatz_loop       @ si r1 <= max, no actualiza
    mov r2, r1             @ si r1 > max, actualiza max
    b   collatz_loop

print_max:
    ldr r0, =output_fmt
    mov r1, r2
    bl printf              @ imprime el máximo de la secuencia

    add r7, r7, #1         @ contador++
    b loop_cases

end_program:
    mov r7, #1             @ syscall exit (Linux)
    svc 0
