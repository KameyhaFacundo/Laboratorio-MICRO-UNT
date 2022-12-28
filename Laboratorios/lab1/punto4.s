

    .cpu cortex-m4              // Indica el procesador de destino  
    .syntax unified             // Habilita las instrucciones Thumb-2
    .thumb                      // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"

/**
* Programa principal, siempre debe ir al principio del archivo
*/
    .section .data //Abajo de esto pongo todo lo que guardo en memoria no volatil
tabla: 
    .byte 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0xFF, 0x67 //Armo la tabla BCD a 7segm
//          0    1     2     3     4    5     6     7     8     9     
  
    .section .text              // Define la seccion de codigo (FLASH)
base: 
    .word 0x08,  0x04, 0x09, 0x00, 0x00 //3 direcciones de memoria consecutivos
    //     seg[0] seg[1] min[0] min[1] hora[0]   
    //     base  base+4  base+8 base+12 base+14

    .global reset               // Define el punto de entrada del codigo
    .func mainS

reset:
    BL configurar
    
    LDR R1, =base //Guardo direccion del LSB de segundos
    MOV R7, #0 //Divisor = 0
    MOV R8, #100 //Limite divisor = 1000

inicio:
    LDR R1, =base //Guardo direccion del LSB de segundos
    ADD R7, #1 //Incremento divisor en 1
    CMP R7,R8 //Comparo divisor con 1000
    BNE seguimos //Si es falso, no hago nada. Sino...
    MOV R7, #0 //Pongo divisor en 0
    LDR R2, [R1] //Voy a seg[0] y lo traigo
    ADD R2, #1 //Incremento en 1
    STR R2, [R1] //Guardo el valor incrementado

seguimos:
    LDR R1, =base //Guardo direccion del LSB de segundos
    MOV R0, #1 //Guardo 1 en R0
    BL actualizar // Llamo a la subrutina para actualizar segundos y desborde minutos
    
    ADD R1, #8 //Guardo direccion del LSB de minutos
    MOV R0, #1 //Guardo 1 en R0
    BL actualizar // Llamo a la subrutina para actualizar minutos y desborde hora

primero:
    LDR R1, =base //Guardo direccion del LSB de segundos
    LDR R10, [R1,#12] //En r10 guardo min1
    LDR R11, [R1,#8] //En r11 guardo min0
    LDR R0, [R1,#4] //EN R0 GUARDO SEG1         
    LDR R1, [R1] //EN R1 GUARDO SEG0
    ADD R6, R0, #0 //Para adaptarme al ejercicio 1, guardo R0 en R6
    
    // Prendido de todos los bits gpio de los segmentos
    LDR R0,=GPIO_PIN2
    LDR R2, =tabla //Cargo en R2 la direccion tabla, sino no se puede hacer [tabla]
    
    //Guardar en la direccion de R1 el numero a mostrar
    LDRB R3, [R2,R1] //Cargo en R3, la tabla + el valor que muevo (es decir el numero a mostrar)
    STR R3,[R0] //Guardo el valor de R3 en la direccion de GPIO pin2

    // Prendido de todos bits gpio de los digitos
    LDR R2,=GPIO_PIN0
    LDR R0,=#1 //Elijo que segmento enciendo (el primero)
    STR R0,[R2] 
    
    BL lazo

segundo:
    // Prendido de todos los bits gpio de los segmentos
    LDR R0,=GPIO_PIN2
    ADD R1, R6, #0 //Para adaptarme al ejercicio 1, traigo de vuelta a R1 el valor de R6
    LDR R2, =tabla //Cargo en R2 la direccion tabla, sino no se puede hacer [tabla]
    
    //Guardar en la direccion de R1 el numero a mostrar
    LDRB R3, [R2,R1] //Cargo en R3, la tabla + el valor que muevo (es decir el numero a mostrar)
    STR R3,[R0] //Guardo el valor de R3 en la direccion de GPIO pin2

    // Prendido de todos bits gpio de los digitos
    LDR R2,=GPIO_PIN0
    LDR R0,=#2 //Elijo que segmento enciendo
    STR R0,[R2]

    BL lazo

tercero:
    // Prendido de todos los bits gpio de los segmentos
    LDR R0,=GPIO_PIN2
    ADD R1, R11, #0 //Para adaptarme al ejercicio 1, traigo de vuelta a R1 el valor de R6
    LDR R2, =tabla //Cargo en R2 la direccion tabla, sino no se puede hacer [tabla]
    
    //Guardar en la direccion de R1 el numero a mostrar
    LDRB R3, [R2,R1] //Cargo en R3, la tabla + el valor que muevo (es decir el numero a mostrar)
    STR R3,[R0] //Guardo el valor de R3 en la direccion de GPIO pin2

    // Prendido de todos bits gpio de los digitos
    LDR R2,=GPIO_PIN0
    LDR R0,=#4 //Elijo que segmento enciendo
    STR R0,[R2]

    BL lazo

cuarto:
    // Prendido de todos los bits gpio de los segmentos
    LDR R0,=GPIO_PIN2
    MOV R1, R10 //Para adaptarme al ejercicio 1, traigo de vuelta a R1 el valor de R6
    LDR R2, =tabla //Cargo en R2 la direccion tabla, sino no se puede hacer [tabla]
    
    //Guardar en la direccion de R1 el numero a mostrar
    LDRB R3, [R2,R1] //Cargo en R3, la tabla + el valor que muevo (es decir el numero a mostrar)
    STR R3,[R0] //Guardo el valor de R3 en la direccion de GPIO pin2

    // Prendido de todos bits gpio de los digitos
    LDR R2,=GPIO_PIN0
    LDR R0,=#8 //Elijo que segmento enciendo
    STR R0,[R2]

    BL lazo

    B inicio


stop:
    B stop              // Lazo infinito para terminar la ejecucion

    @ ------- SUBRUTINAS -----------

//Subrutina lazo, demora 50 000 iteraciones:
lazo:
    LDR R4, =0x00//Para inicializar el lazo en 0
    LDR R5, =#50000 //Condicion de parada

repetir:
    ADD R4, R4, #1 //Incremente contador en 1
    CMP R4, R5 //Comparo si el contador es igual a 10 000
    BEQ salir
    B repetir //Sino, repito delay

salir:
    BX LR
//Fin subrutina lazo

//Subrutina conversion de BCD a 7 segmentos
conversion:
    LDR R2, =tabla //Cargo en R2 la direccion tabla
    LDRB R0, [R2,R0] //Cargo en R0, la tabla + el valor que muevo (es decir el numero a mostrar)
    BX LR
//Fin subrutina conversion

//Subrutina actualizar, Ejercico 3 del TP2
actualizar:
condUno:
    MOV R9, #10 //Guardamos constante de condicion en un registro
    LDR R2, [R1]
    CMP R2, R9
    BMI condDos //Si seg[0]<10, no hago nada y salto
    MOV R2,#0 // Sino, guardo constante 0...
    STR R2, [R1] //...para poner seg[0] en 0 
    LDR R2, [R1,#4] //Voy a seg[1] y lo traigo
    ADD R2, #0x1  //Incremento en 1
    STR R2, [R1,#4] //Guardo el valor incrementado
    
condDos:
    MOV R9, #6 //Guardamos constante de condicion en un registro
    LDR R2, [R1,#4] //Traigo seg1 a registro
    CMP R2, R9
    BMI salgo //Si <6, salgo de subrutina
    MOV R2, #0 // Sino, guardo constante 0...
    STR R2, [R1,#4] //...para poner seg[1] en 0 
    LDR R2, [R1,#8] //Voy a min0 y lo traigo
    ADD R2, #1  //Incremento en 1
    STR R2, [R1,#8] //Guardo el valor incrementado
    
salgo:
    BX LR
//Fin subrutina actualizar

     .align
    .pool
    .endfunc

/**
* Inclusion de las funciones para configurar los teminales GPIO del procesador
*/
    .include "ejemplos/digitos.s"


