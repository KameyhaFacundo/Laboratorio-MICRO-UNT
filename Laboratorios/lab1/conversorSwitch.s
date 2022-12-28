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
    ADR R3,switch// Apunta R3 al bloque con la tabla

lazo:
    LDRB R2,[R0],#1     //CArga en R2 el elemento a convertir
    CMP R2,0xFF     //Determina si es el fin de la conversion
    BEQ final   //Termina el fin de la conversion

    LDR R2,[R3,R2,LSL #2]   //CArga en R2 la direccion del caso swich
    ORR R2,0x01         //Fija el MSB para indicar instrucciones Thumb
    BX R2               //Salta al caso correspondiente

    .align          //Asegura que la tabla de saltos este alineada

switch:

    .word case0,case1,case2,case3,case4,case5
    .word case6,case7,case8,case9

case0:
    MOV R2,#0xFC    //CArga en R2 con el valor correspondiente cero
    B break         //SAlta al final del bloque switch

case1:
    MOV R2,#0x60
    B break

case2:
    MOV R2,#0xDA
    B break

case3:
    MOV R2,#0xF2
    B break

case4:
    MOV R2,#0x66
    B break

case5:
    MOV R2,#0xB6
    B break

case6:
    MOV R2,#0xBE
    B break

case7:
    MOV R2,#0xE0
    B break

case8:
    MOV R2,#0xFE
    B break
    
case9:
    MOV R2,#0xF6
    B break
    
break: 
    STRB R2,[R1],#1 //Guarda el elemento convertido
    B lazo      //Repite el lazo de conversion

final:   STRB R2,[R1]    //Guarda el fin de conversion destino

stop: B stop
    