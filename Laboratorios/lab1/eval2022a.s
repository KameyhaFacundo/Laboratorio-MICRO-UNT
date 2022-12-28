#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************

    .section .data// Define la sección de variables (RAM)

vector: 
    .byte 0x01,0x02,0x07,0x03// Variable inicializada
base: .word vector
//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    MOV R0,#4
    LDR R1,=base-4   //Obtengo la direccion base
    LDR R6,=base+4   //Para no perder la referencia de base

lazo:
    LDRB R2,[R1],#1  //Cargo los elementos de memoria y desplazo al siguiente

    CMP R0,#0 //Comparo con la  marca final
    BEQ final   //Si es verdaderolo anterior salta a final


    MOVS R3,R2,LSR #1   //Desplazo un bit a la derecha para saber si es par
    BCC par //Si es par salta
    
    ADD R5,#1 //CONTADOR DE NUMEROS IMPARES
    SUB R0,#1
    
    B lazo
par:
    SUB R0,#1
    B lazo

final: 
    STRB R5,[R6]//Guardo la cantidad de numeros impares en memoria en base+4

stop: B stop

    .endfunc

