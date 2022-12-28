#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES    
//28/07/2022
#LABORATORIO N2

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data// Define la sección de variables (RAM)

h:
    .byte 0x03,0x4,0x1
x:
    .byte 0x01,0x04,0x02,0x05

destino:
    .space 8
y:
    .space 8

//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main
    
reset: 
    LDR R0,=h
    LDR R1,=x
    BL invertir

    LDR R0,=x
    LDR R1,=destino
    MOV R2,#4
    MOV R3,#2
    BL transformo

    MOV R4,#6
    LDR R0,=destino
    LDR R1,=h
    LDR R8,=y
    
lazo3:
    CMP R4,#0
    BEQ stop

    PUSH {R0,R1}
    BL calculo
    POP {R0,R1}
    STRB R3,[R8],#1

    ADD R0,R0,#1
    SUB R4,#1
    B lazo3

    .endfunc

stop: B stop
/**
* Inclusion de las funciones para configurar los teminales GPIO del procesador
*/
    .include "parcial1/parcial2021.s"
    .include "parcial1/parcial2021b.s"
