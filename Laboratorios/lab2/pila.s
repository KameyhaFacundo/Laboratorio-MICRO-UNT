
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
    LDR R4,=base    //Apunto R0 al bloque de parametros 

    MOV R1,#57      //Cargo en R1 el primer operando
    STR R1,[R4]     //Preparo el primer parametro del bloque
    
    MOV R1,#10      //Cargo en R1 el segundo operando
    STR R1,[R4,#4]  //Preparo el segundo parametro del bloque
    
    PUSH {R4}       //Ingreso a la pila la direccion del bloque
    BL suma         //Llamo a la subrutina\
    
    POP {R4}
    LDR R7,[R4,#8]  //Cargo el resultado en R1

stop: B stop   //Lazo infinito para terminar

suma:
    LDR R0,[SP]
    //POP {R4}        // Recupero la direccion del bloque
    LDR R1,[R4]     //Cargo en R1 el primer operando
    LDR R2,[R4,#4]  //Cargo en R2 el primer operando
    ADD R1,R2       //Realizo la suma
    STR R1,[R4,#8]  //Almaceno el resultado en el bloque
    BX LR           //Retorno al programa principal
    
    .endfunc
