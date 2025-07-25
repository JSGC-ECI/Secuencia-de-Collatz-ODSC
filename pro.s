.data
  .balign 4                          // Alinear los datos a 4 bytes

scan_format:     .asciz "%d"         // Cadena de formato para scanf (leer enteros)
print_format:    .asciz "%d\n"       // Cadena de formato para printf (imprimir enteros con salto de línea)

.balign 4
cases:  .word 0                      // Número total de casos a procesar
i:  .word 0                          // Contador de casos procesados
num:  .word 0                        // Número actual (inicio de la secuencia de Collatz)
max_value:  .word 0                 // Máximo valor alcanzado en la secuencia de Collatz
remainder:  .word 0                 // [No se usa en este código, reservado]
one:  .word 1                        // Constante 1 (no utilizada directamente)
two:  .word 2                        // Constante 2 (no utilizada directamente)
three:  .word 3                      // Constante 3 (no utilizada directamente)

return_addr:  .word 0               // Dirección de retorno para restaurar LR (enlace de retorno)

.text
.global scanf                        // Declaración global: función externa scanf
.global printf                       // Declaración global: función externa printf
.global main                         // Declaración del punto de entrada del programa
.func main                           // Inicio de la función main
main:
  LDR  R0, =return_addr             // R0 = dirección de return_addr
  STR  LR, [R0]                     // Guardar el valor del enlace de retorno (LR) en memoria

  LDR  R0, =scan_format             // R0 = dirección de la cadena "%d"
  LDR  R1, =cases                  // R1 = dirección de la variable cases
  BL  scanf                        // Llamar a scanf("%d", &cases) → Leer número de casos

  LDR  R1, =cases                  // R1 = dirección de cases
  LDR  R2, [R1]                    // R2 = valor de cases
  SUB  R2, R2, #1                  // R2 = cases - 1 (para usar BGT luego con comparación)
  STR  R2, [R1]                    // Guardar el nuevo valor de cases

  MOV  R0, #0                       // R0 = 0 (inicialización de i)
  LDR  R1, =i                       // R1 = dirección de i
  STR  R0, [R1]                     // Guardar 0 en i

loop:                                // Inicio del bucle principal
  LDR  R1, =i                       // R1 = dirección de i
  LDR  R2, [R1]                     // R2 = valor de i
  LDR  R3, =cases                  // R3 = dirección de cases
  LDR  R3, [R3]                    // R3 = valor de cases
  CMP  R2, R3                      // Comparar i > cases
  BGT  end                         // Si i > cases, salta a fin del programa

  LDR  R0, =scan_format             // R0 = dirección de "%d"
  LDR  R1, =num                    // R1 = dirección de num
  BL  scanf                        // scanf("%d", &num) → leer número actual

  LDR  R1, =num                    // R1 = dirección de num
  LDR  R2, [R1]                    // R2 = valor de num
  LDR  R3, =max_value             // R3 = dirección de max_value
  STR  R2, [R3]                    // max_value = num

collatz_loop:                        // Bucle de la secuencia de Collatz
  LDR  R1, =num                    // R1 = dirección de num
  LDR  R2, [R1]                    // R2 = valor de num
  CMP  R2, #1                      // ¿num == 1?
  BEQ  print_max                  // Si sí, saltar a imprimir el máximo

  ANDS  R3, R2, #1                 // Verifica si num es par o impar (num & 1)
  BEQ  even_case                  // Si Z=1 (es par), saltar a caso par

  // Caso impar: num = 3*num + 1
  MOV  R3, R2                      // R3 = num
  ADD  R3, R3, R2                  // R3 += num → 2*num
  ADD  R3, R3, R2                  // R3 += num → 3*num
  ADD  R3, R3, #1                  // R3 += 1 → 3*num + 1
  B  check_max                    // Ir a verificar si es nuevo máximo

even_case:                           // Caso par: num = num / 2
  MOV  R3, R2                      // R3 = num
  LSR  R3, R3, #1                  // R3 = num >> 1 → división por 2

check_max:
  LDR  R1, =num                    // R1 = dirección de num
  STR  R3, [R1]                    // num = nuevo valor calculado

  LDR  R1, =max_value             // R1 = dirección de max_value
  LDR  R4, [R1]                    // R4 = max_value actual
  CMP  R3, R4                      // Comparar nuevo valor con max_value
  BLE  collatz_loop               // Si num ≤ max_value, seguir en bucle

  STR  R3, [R1]                    // Si nuevo valor > max_value, actualizarlo
  B  collatz_loop                 // Continuar la secuencia

print_max:                           // Imprimir max_value al final de la secuencia
  LDR  R0, =print_format          // R0 = dirección de "%d\n"
  LDR  R1, =max_value             // R1 = dirección de max_value
  LDR  R1, [R1]                   // R1 = valor de max_value
  BL  printf                      // printf("%d\n", max_value)

  LDR  R1, =i                      // R1 = dirección de i
  LDR  R2, [R1]                    // R2 = valor de i
  ADD  R2, R2, #1                  // i++
  STR  R2, [R1]                    // Guardar nuevo valor de i
  B  loop                         // Volver al inicio del bucle principal

end:                                 // Fin del programa
  LDR  LR, =return_addr            // LR = dirección de retorno guardada
  LDR  LR, [LR]                    // LR = valor original del LR
  MOV  R0, #0                      // Valor de retorno = 0
  BX  LR                           // Volver al sistema operativo o a quien llamó
.end                                // Fin de la función main
