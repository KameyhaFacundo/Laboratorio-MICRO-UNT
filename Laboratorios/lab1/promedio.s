/********************************************************************************
 
 CALCULA EL PROMEDIO DE DOS NUMEROS ALMACENADOS EN DIRECCIONES CONSECUTIVAS

********************************************************************************* */

    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM


//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data //define la seccion de variables(RAM)

datos:
    .word 3,2,3,4,5,6,7,8

//=================== PROGRAMA PRINCIPAL =======================================

    .section .text
    .global reset
 



reset:
    LDR R0,=datos   // R0 apunta a la primera direccion de los datos

    LDR R1,[R0]     // guardo en R1 la direccion de la primera direccion de datos
    LDR R2,[R0,#4]  // guardo en R2 la direccion de la Segunda direccion de datos

    ADD R1,R2       //Realizo la suma
    ASR R1,R1,#1    //Desplazo a la derecha un bits 
    // R1 = R1 - R1(DESPLAZO UN BITS A LA izquierda para dividir en 2)
    // EJEMPLO : R1 = 10 / 5 = 2
    
    STR R1,[R0,#8]  // Guardo en memoria

//MULTIPLICO
    LSL R1,R1,#1   //Desplazo a la derecha un bits es decir, MULTIPLICO POR 2
    LSL R1,R2,#2   //Desplazo a la derecha un bits es decir, MULTIPLICO POR 4
    LSL R1,R1,#3   //Desplazo a la derecha un bits es decir, MULTIPLICO POR 8

/*
Determina si el valor almacenado en la direciion datos en un numero par (Shift right LSR y ver carry)
*/

    LDR R3,=datos

    LDR R3,[R3]

    MOVS R4,R3,LSR #2
  // R4 = R3 - R3(DESPLAZO UN BITS A LA izquierda para dividir en 2)
    BCC par

par: