
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES


/*
6) El método más simple para detectar alteraciones en un bloque de memoria consiste en agre-
gar al mismo la suma byte a byte (sin considerar el carry) de todo el contenido del bloque. Este
byte agregado se conoce como checksum o suma de comprobación. Escriba un programa que
calcule el checksum de un bloque de datos cuya cantidad de elementos está almacenada en
el registro R0 y cuyo puntero al inicio del bloque se encuentra almacenado en las direcciones
base. Se pide almacenar el resultado obtenido en la dirección base+4.

 */

    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM


//=================== DEFINO VARIABLES GLOBALES ================================

    .section .data //define la seccion de variables(RAM)

base:
    .byte 0xAA,0xFF,0xBB,0xCC // Variable inicializada de a 4 bytes ( 8 BITS CADA UNA)
    .space 3, 0x00                            

//=================== PROGRAMA PRINCIPAL =======================================

    .section .text
    .global reset
 
 reset:
    MOV R0,#4   //Contador para recorrer el lazo
    LDR R5,=base
    LDR R3,=base+4 // para almacenar la suma total
  //  MOV R4,#0x00

lazo:
    CMP R0,0x00
    BEQ final   //Termina si es fin del tamano del bloque
    
    LDRB R2,[R5],#1 //Guardo la direccion de base

    UADD8 R4,R4,R2   //Sumo y guardo el valor en R4

    SUB R0,#1   // R5 = R5-1
    BNE lazo    // Si NO son distintos, entonces SALTA

final: STR R4,[R3]    

stop: B stop
