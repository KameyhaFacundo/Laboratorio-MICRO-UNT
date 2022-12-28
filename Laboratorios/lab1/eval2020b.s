/**
1) 90 Minutos - 100 Puntos (60, 40)

Escriba un programa en lenguaje ensamblador para el ARM Cortex-M4 que procesa un vec-
tor de bytes ubicado a partir de la dirección base, lee todos los elementos del vector hasta
encontrar el valor cero y en ese momento finalice devolviendo el resultado.

a) El programa debe almacenar en la dirección resultado la cantidad de números pares y en
la dirección resultado+1 la cantidad de números impares que contiene el vector.

b) Modifique el programa anterior para que además almacene en la dirección resultado+2
la cantidad de números positivos y en la dirección resultado+3 la cantidad de números
negativos que contiene el vector.

 */

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************

    .section .data// Define la sección de variables (RAM)

resultado: 
    .byte 0x01,0xF3,0x04,0xF2,0x0B,0x00// Variable inicializada de 6 bytes

//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    LDR R1,=resultado    //Obtengo la direccion base
    LDR R6,=resultado   //Para no perder la referencia de base

lazo:
    LDRB R2,[R1],#1  //Cargo los elementos de memoria y desplazo al siguiente

    CMP R2,0x00 //Comparo con la  marca final
    BEQ final   //Si es verdaderolo anterior salta a final

    //LE AGREGO ESTA PARTE PARA CONTAR NUMEROS NEGATIVOS Y POSITIVOS

    MOVS R3,R2,LSR #8   //Desplazo 8 bits para obtener el mas significativo
    ITE CS  // si el carry esta en 0 no salta es positivo, pues debo poner un 1 en el msb ya que es negativo
    ADDCS R7,#1 //SUMA la cantidad de numeros negativos
    ADDCC R8,#1   //SUMA la cantidad de numeros positivos
    
    //////////////////////////////

    MOVS R3,R2,LSR #1   //Desplazo un bit a la derecha para saber si es par
    BCC par //Si es par salta
    
    ADD R5,#1 //CONTADOR DE NUMEROS IMPARES

    B lazo

par:
    ADD R4,#1 //CONTADOR DE NUMEROS PARES 
    B lazo

final: 
    STRB R4,[R6],#1 //Guardo la cantidad de numeros pares en memoria en base
    STRB R5,[R6],#1    //Guardo la cantidad de numeros impares en memoria en base+1

    STRB R8,[R6],#1 //Guardo la cantidad de numeros POSITIVOS en memoria en base+2
    STRB R7,[R6]    //Guardo la cantidad de numeros NEGATIVOS en memoria en base+3    


stop: B stop

    .endfunc
