/*
b) Guarde en el registro R1 el mapa de bits correspondiente para mostrar la cantidad de ele-
mentos negativos del vector del ejercicio anterior. Para ello, considere la siguiente conexión
del display 7 segmentos.

                b7 b6 b5 b4 b3 b2 b1 b0
                    g  f  e d  c  b  a

Lo que entiendo es que tengo que prender la cantidad total de numeros negativos que tiene un vector

*/


    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//=================== DEFINO VARIABLES GLOBALES =================================/

    .section .data// Define la sección de variables (RAM)

origen: 
    .byte 0x00// Variable inicializada de 5 bytes
    .space 15,0xFF// Completo los 20 lugares de origen con 0xFF
        
destino:
    .space 20,0x00// Variable de 20 bytes en blanco

vector:
    .byte 0x06,0x85,0x78,0xF8,0xE0,0x80

//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    
reset:
    LDR R0,=origen// Apunta R0 al bloque de origen
    LDR R1,=destino// Apunta R1 al bloque de destino
    LDR R3,=tabla// Apunta R3 al bloque con la tabla
   
    LDR R4,=vector  //Apunta R4 al bloque de tabla 

contador:  
    LDRB R5,[R4],#1
    CMP R5,0x80
    BEQ guardar

    MOVS R7,R5,LSR #8
  
    IT CS // si el carry esta en 0 no salta, pues debo poner un 1 en el msb
    ADDCS R6,#1

    B contador

guardar:    STRB R6,[R0]


lazo:
    LDRB R2,[R0],#1// Carga en R2 el elemento a convertir, inc 

    CMP R2,0xFF// Determina si es el fin de conversión
    BEQ final// Terminar si es fin de conversión

    LDRB R2,[R3,R2] // r2 = M( r3 + r2) // Cargar en R2 el elemento convertido
 
    STRB R2,[R1],#1// Guardar el elemento convertido 
    
    B lazo// Repetir el lazo de conversión

final: 
    STRB R2,[R1]  // Guardar el fin de conversión en destino

stop: 
    B stop// Lazo infinito para terminar la ejecución


tabla:
    .byte 0x3F,0x06,0x5B,0x4F,0x66
    .byte 0x6D,0x7D,0x07,0x7F,0x67
