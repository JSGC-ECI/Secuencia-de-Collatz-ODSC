.global main
.global printf
.global scanf

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
main:
    @ printf("Numero de casos: ");
    ldr r0, =prompt_cases
    bl printf

    @ scanf("%d", &num_cases);
    ldr r0, =input_fmt
    ldr r1, =num_cases
    bl scanf

    @ r6 = num_cases
    ldr r5, =num_cases
    ldr r6, [r5]
    mov r7, #0          @ r7 = contador

loop_cases:
    cmp r7, r6
    beq end_program

    @ printf("Ingrese numero: ");
    ldr r0, =prompt_input
    bl printf

    @ scanf("%d", &num);
    ldr r0, =input_fmt
    ldr r1, =num
    bl scanf

    @ r0 = num ingresado
    ldr r0, =num
    ldr r0, [r0]

    mov r1, r0          @ r1 = valor actual en la secuencia
    mov r2, r0          @ r2 = max

collatz_loop:
    cmp r1, #1
    beq print_max

    and r3, r1, #1      @ r3 = r1 % 2
    cmp r3, #0
    beq is_even
    b is_odd

is_even:
    mov r1, r1, LSR #1  @ r1 = r1 / 2
    b update_max

is_odd:
    mov r3, r1, LSL #1  @ r3 = 2*r1
    add r1, r3, r1      @ r1 = 3*r1
    add r1, r1, #1      @ r1 = 3*r1 + 1

update_max:
    cmp r1, r2
    ble collatz_loop
    mov r2, r1
    b collatz_loop

print_max:
    ldr r0, =output_fmt
    mov r1, r2
    bl printf

    add r7, r7, #1
    b loop_cases

end_program:
    mov r0, #0
    bx lr               @ return 0
