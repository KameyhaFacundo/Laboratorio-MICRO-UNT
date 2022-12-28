#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data// Define la sección de variables (RAM)

origen: 
    .byte 6,2,8,5,7// Variable inicializada de 5 bytes
    .space 15,0xFF// Completo los 20 lugares de origen con 0xFF
        
destino:
    .space 20,0x00// Variable de 20 bytes en blanco


//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    
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

    .pool

tabla:
    .byte 0xFC,0x60,0xDA,0xF2,0x66
    .byte 0xB6,0xBE,0xE0,0xFE,0xF6
