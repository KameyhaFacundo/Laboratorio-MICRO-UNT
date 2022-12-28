#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES


/*
3) [Recomendado] Escriba un programa que agregue un bit de paridad a una cadena de carac-
teres ASCII. La finalización de la cadena esta marcada con el valor 0x00 y el bloque comienza
en la dirección base. Se debe poner en 1 el bit más significativo de cada caracter si y sólo si
esto hace que el número total de unos en ese byte sea par. Por ejemplo:

                        Dato                    Resultado
                    (base) = 0x06           (base) = 0x06
                    (base + 1) = 0x7A       (base + 1) = 0xFA
                    (base + 2) = 0x7B       (base + 2) = 0x7B
                    (base + 3) = 0x7C       (base + 3) = 0xFC
                    (base + 4) = 0x00       (base + 4) = 0x00



 */
    .cpu cortex-m4              // Indica el procesador de destino  
    .syntax unified             // Habilita las instrucciones Thumb-2
    .thumb                      // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"


//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data 
base:
    .byte 0x06,0x7A,0x7B,0x7C,0x00
    .space 12,0x00

/*
*   =================== PROGRAMA PRINCIPAL =======================================
 */
    .section .text              // Define la seccion de codigo (FLASH)
    .global reset               // Define el punto de entrada del codigo
    .func main

reset:
    LDR R8,=base //Obtengo la direccion de dir
    LDR R6,=base //Obtengo la direccion de dir


cargar:
    MOV R3,#8   //Para saber si ya se desplazo 8 bits
    MOV R4,#0   //Cuenta el total de unos del numero hexa
    LDRB R6,[R8]
    LDRB R1,[R8]
    CMP R1,0x00
    BEQ stop    // Mando a terminar

lazo:
    CMP R3,#0   //Comparo hasta que se desplaze 8 bits(BYTE)
    BEQ par

    MOVS R0,R1,LSR #1   //Desplazo un bit a la derecha y guardo en R0
    MOV R1,R0 //Reescribo con el nuevo valor
    BCS contador //Salta si el carry esta en 1
    SUB R3,#1    // Resto la cantidad de bits que voy desplazando
    B lazo

contador:
    ADD R4,#1   //Cuenta los unos 
    SUB R3,#1   // Resto la cantidad de bits que voy desplazando
    B lazo

par:    
    MOVS R4,R4,LSR #1 //Salto a ponerBits, si tengo numero impares de 1
    BCS ponerBits
    B guardar   // Salto si tiene numeros pares de unos

ponerBits:
    MOVS R5,R6,LSR #8   //Desplazo 8 bits para obtener el mas significativo
    BCS guardar // si el carry esta en 0 no salta, pues debo poner un 1 en el msb

    //Cambio el msb por 1
    ORR R6,R6,0x80      //sumo 0x80=1000 0000 para obtener el 1 en msb
    STRB R6,[R8],#1     //Guardo en memoria el valor remplazado, el valor que agrego 1 al bits mas significativo
    B cargar

guardar:
    STRB R6,[R8],#1     //Guardo en memoria el numero que tiene numeros pares
    B cargar

stop: B stop    //BUCLE INFINITO
    .pool
    .endfunc
