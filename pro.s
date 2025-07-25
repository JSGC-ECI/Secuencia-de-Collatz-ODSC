.global _start
.global scanf
.global printf

.section .data
    prompt_cases: .asciz "Numero de casos: "
    prompt_input: .asciz "Ingrese numero: "
    output_fmt:   .asciz "Maximo valor: %d\n"
    input_fmt:    .asciz "%d"

.section .bss
    num_cases: .skip 4
    num:       .skip 4
    max:       .skip 4

.section .text
_start:

    @ Solicitar número de casos
    ldr r0, =prompt_cases
    bl printf

    ldr r0, =input_fmt
    ldr r1, =num_cases
    bl scanf

    ldr r5, =num_cases
    ldr r6, [r5]       @ r6 = número de casos
    mov r7, #0         @ r7 = contador de casos

loop_cases:
    cmp r7, r6
    beq end_program    @ si contador == num_cases, salir

    @ Pedir número actual
    ldr r0, =prompt_input
    bl printf

    ldr r0, =input_fmt
    ldr r1, =num
    bl scanf

    ldr r0, =num
    ldr r0, [r0]       @ r0 = número actual ingresado

    mov r1, r0         @ r1 = valor actual en la secuencia
    mov r2, r0         @ r2 = valor máximo encontrado

collatz_loop:
    cmp r1, #1
    beq print_max      @ si r1 == 1, terminamos la secuencia

    and r3, r1, #1     @ r3 = r1 % 2
    cmp r3, #0
    beq is_even
    b   is_odd

is_even:
    mov r1, r1, LSR #1     @ r1 = r1 / 2
    b update_max

is_odd:
    mov r3, r1, LSL #1     @ r3 = 2*r1
    add r1, r3, r1         @ r1 = 3*r1
    add r1, r1, #1         @ r1 = 3*r1 + 1

update_max:
    cmp r1, r2
    ble collatz_loop
    mov r2, r1             @ nuevo máximo
    b collatz_loop

print_max:
    ldr r0, =output_fmt
    mov r1, r2
    bl printf

    add r7, r7, #1
    b loop_cases

end_program:
    mov r7, #1         @ syscall exit
    svc 0
