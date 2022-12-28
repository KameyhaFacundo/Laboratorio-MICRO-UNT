
#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

/** PASO DE PARAMETROS EN LA PILA */

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************

    .section .data// Define la sección de variables (RAM)

base:
    .space 12

//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    MOV R0,#57      //Cargo en R1 el primer operando
    MOV R1,#10      //Cargo en R1 el primer operando
    
    PUSH {R0,R1}       //Ingreso a la pila la direccion del bloque
    BL suma         //Llamo a la subrutina\
    
    POP {R0,R1}
stop: B stop   //Lazo infinito para terminar

suma:
    PUSH {LR}
    LDR R0,[SP,#4]     //Cargo en R1 el primer operando
    LDR R1,[SP,#8]  //Cargo en R2 el primer operando
    ADD R0,R1       //Realizo la suma
    STR R0,[SP,#4]  //Almaceno el resultado en el bloque
    POP {PC}           //Retorno al programa principal
    
    .endfunc