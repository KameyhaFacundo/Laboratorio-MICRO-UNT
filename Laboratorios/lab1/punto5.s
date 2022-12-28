#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES


/*
5) Escriba un programa para encontrar el mayor elemento en un bloque de datos. El tamaño de
dato es de 8 bits. El resultado debe guardarse en la dirección base, la longitud del bloque está
en la dirección base+1 y el bloque comienza a partir de la dirección base+2. Por ejemplo:
    Datos               Resultado
(base + 1) = 0x03   (base) = 0xF2
(base + 2) = 0x3A
(base + 3) = 0xAA
(base + 4) = 0xF2
 */

    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM


//=================== DEFINO VARIABLES GLOBALES ================================

    .section .data //define la seccion de variables(RAM)

base:
    .byte 0x00,0x03,0x3A,0xF2,0xAA // Variable inicializada( 8 BITS CADA UNA)

//=================== PROGRAMA PRINCIPAL =======================================

    .section .text
    .global reset
 
 reset:
    LDR R1,=base    //Direccion para guardar el resultado final
    
    LDR R2,=base+1  //Direccion donde esta la cantidad del bloque
    LDRB R2,[R2]
    
    LDR R3,=base+2  //Direccion de donde comienza el bloque de datos
  //  LDRB R3,[R3]  //Valor en la direccion de base+2
    LDRB R5,[R3]

lazo:
    CMP R2,#1   //ES COMO EL FOR 
    BEQ final

    LDRB R4,[R3,#1]!  //Guardo la direccion de base+2
    
    CMP R4,R5   //Comparo los registros para saber si r4 > r3
    IT HI   //si r4 > r3 salta a MOVHI
    MOVHI R5,R4     //GUARDO EL MAYOR EN R2

    SUB R2,#1       //R5 = R5-1
    BNE lazo

final:  STRB R5,[R1] //Guardo en base

stop: B stop     





