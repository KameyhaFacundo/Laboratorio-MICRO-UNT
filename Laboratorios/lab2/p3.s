    .cpu cortex-m4              // Indica el procesador de destino  
    .syntax unified             // Habilita las instrucciones Thumb-2
    .thumb                      // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"


    .section .data //Abajo de esto pongo todo lo que guardo en memoria no volatil

tabla: 
    .byte 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0xFF, 0x67 //Armo la tabla BCD a 7segm
//          0    1     2     3     4    5     6     7     8     9     
  
/**
*******************   Programa principal   *********
*/
    .section .text              // Define la seccion de codigo (FLASH)

base: 
    .word 0x00,  0x00, 0x00 //3 direcciones de memoria consecutivos
    //     seg[0] seg[1] min[0] 

    .global reset               // Define el punto de entrada del codigo
    .func main

reset:
    BL configurar

       // Prendido de todos bits gpio de los digitos
    LDR R3,=GPIO_PIN0
    LDR R4,=0x02
    STR R4,[R3]



stop: B stop              // Lazo infinito para terminar la ejecucion

    .align
    .pool
    .endfunc

/**
* Inclusion de las funciones para configurar los teminales GPIO del procesador
*/
    .include "ejemplos/digitos.s"
