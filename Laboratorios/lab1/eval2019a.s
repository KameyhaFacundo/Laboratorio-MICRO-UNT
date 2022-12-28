/**
1) 30 Minutos - 40 Puntos

Modifique el ejercicio visto en la clase de laboratorio para prender los segmentos correspondientes 
a un dígito determinado. El valor a mostrar será hexadecimal por lo que estará comprendido entre 0 y F
y se encuentra almacenado en el registro R1. 

Para la solución deberá utilizar una tabla de conversión la cual estará almacenada en memoria no 
volátil. La asignación de los bits correspondientes a cada segmento del dígito se muestra en la 
figura que acompaña al enunciado

                b7 b6 b5 b4 b3 b2 b1 b0
                    g  f  e d  c  b  a

*/

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
    //**************** DEFINO VARIABLES GLOBALES *********************************

    .section .data// Define la sección de variables (RAM)

origen: 
    .byte 6,2,8,5,7// Variable inicializada de 5 bytes
    .space 15,0xFF// Completo los 20 lugares de origen con 0xFF
        
destino:
    .space 20,0x00// Variable de 20 bytes en blanco

    //****************** PROGRAMA PRINCIPAL **************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main
    
reset:
    LDR R0,=origen// Apunta R0 al bloque de origen
    LDR R1,=destino// Apunta R1 al bloque de destino
    LDR R3,=tabla// Apunta R3 al bloque con la tabla

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
    .endfunc

/************ memoria no volátil ************************/
tabla:
    .byte 0x3F,0x06,0x5B,0x4F,0x66
    .byte 0x6D,0x7D,0x07,0x7F,0x67