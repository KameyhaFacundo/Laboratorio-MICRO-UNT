#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

/* 
Se tiene un bloque de datos de 8 bits, guardados en codificación magnitud y signo. El primer
elemento está guardado en la dirección vector y el final del bloque está marcado con el valor
0x80.

a) Escriba un programa que modifique los elementos del bloque para quedar almacenados en
codificación complemento a 2. Los elementos deben quedar almacenados en las mismas
direcciones de memoria en que se encontraban originalmente.

A continuación se muestra un ejemplo de funcionamiento del programa. Tenga en cuenta
que el programa debe funcionar para diferentes valores y diferentes longitudes de bloques,
además del caso particular del ejemplo.

Dato                     Resultado
(vector) = 0x06         (vector) = 0x06
(vector + 1) = 0x85     (vector + 1) = 0xFB
(vector + 2) = 0x78     (vector + 2) = 0x78
(vector + 3) = 0xF8     (vector + 3) = 0x88
(vector + 4) = 0xE0     (vector + 4) = 0xA0
(vector + 5) = 0x80     (vector + 5) = 0x80
 */

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
/*
***************************   DEFINO VARIABLES GLOBALES  ***************************
 */
    .section .data// Define la sección de variables (RAM)

vector: 
    .byte 0x06,0x85,0x78,0xF8,0xE0,0x80// Variable inicializada de 5 bytes
    
/*
***************************  PROGRAMA PRINCIPAL  ***************************
 */
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    LDR R1,=vector  //Direccion para traer los valores
    LDR R3,=vector  //Direccion base para ir cargando los nuevos valores

lazo:
    LDRB R2,[R1],#1 //OBtengo los valores de la direccion R1
    
    CMP R2,0x80// Determina si es el fin de conversión
    BEQ stop// Terminar si es fin de conversión
    
    MOVS R4,R2,LSR #8   //Desplazo 8 bits para obtener el mas significativo
    BCS complemento2 // si el carry esta en 0 no salta es positivo, pues debo poner un 1 en el msb ya que es negativo

    STRB R2,[R3],#1    //Guardo en memoria el valor remplazado, el valor que agrego 1 al bits mas significativo
    B lazo

complemento2:
    EOR R2,0xFF //INVIERTO LOS NUMEROS 1 POR 0 y viceversa   
    ADD R2,#1 //Sumo 1 para el complemento a 2
    ADD R2,#0x80    //PONGO en 1 el bits mas significativo
    STRB R2,[R3],#1     //Guardo en memoria
    B lazo

stop: B stop
    .endfunc
