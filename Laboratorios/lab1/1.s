#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************

    .section .data// Define la sección de variables (RAM)

vector: 
    .byte 0x01,0x02,0x07// Variable inicializada de 6 bytes

//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    MOV R0,#3
    LDR R1,=vector    //Obtengo la direccion base
    LDR R6,=vector+4   //Para no perder la referencia de base
    LDRB 
lazo:
    LDRB R2,[R1],#1  //Cargo los elementos de memoria y desplazo al siguiente

    CMP R0,#1 //Comparo con la  marca final
    BEQ final   //Si es verdaderolo anterior salta a final


    MOVS R3,R2,LSR #1   //Desplazo un bit a la derecha para saber si es par
    BCC lazo //Si es par salta
    
    ADD R5,#1 //CONTADOR DE NUMEROS IMPARES
    SUB R0,#1
    
    B lazo

final: 
    STRB R5,[R6],#1 //Guardo la cantidad de numeros impares en memoria en base+4

stop: B stop
    .pool
    .endfunc
