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

numero:
    .byte 0xD7

//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main
    
reset:
    LDR R0,=numero
    LDR R11, =numero         //apunto al primer numero
lazo:    
   
    LDRB R0, [R11,#1]        //cargo la centena en r0
    MOV R1, 0x4             //quiero prender el digito de la centena
    BL mostrar              //muestra un en el digito de las centenas
    BL demora               //demora

    LDRB R0, [R11,#2]
    MOV R1, 0x2
    BL mostrar
    BL demora
   
    LDRB R0, [R11,#3]
    MOV R1, 0x1
    BL mostrar
    BL demora

   
    B lazo


    .endfunc

stop: B stop

/**
* Inclusion de las funciones para configurar los teminales GPIO del procesador
*/
    .include "lab2/funciones.s"
