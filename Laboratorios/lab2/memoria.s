
#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

/** PASO DE PARAMETROS EN MEMORIA */

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
    LDR R0,=base    //Apunto R0 al bloque de parametros 
    MOV R1,#57      //Cargo en R1 el primer operando
    STR R1,[R0],#4  //Preparo el primer parametro del bloque
    MOV R1,#10      //CArgo el segundo operando
    STR R1,[R0],#4  //Preparo el segundo parametro del bloque
    BL suma         //Llamo a la subrutina

stop: B stop

suma:
    LDR R0,=base    // Apunto R0 al bloque de parametros
    LDR R1,[R0],#4  //Cargo en R1 el primer operando
    LDR R2,[R0],#4  //Crago en R2 el primer operando
    ADD R1,R2   //Realizo la suma
    STR R1,[R0] //Almaceno el resultado en el bloque
    BX LR       //Retorno al programa principal
    
    .endfunc
