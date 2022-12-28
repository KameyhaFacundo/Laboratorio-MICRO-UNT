#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

/* 
2) Escriba un programa para inicializar con 0x55 un vector. El tamaño de los datos del vector es
de 16 bits y la cantidad de elementos se encuentra en la dirección base (también de 16 bits).
El vector comienza en la dirección base+2.
b) Con directivas al ensamblador
*/
  
    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM


//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data //define la seccion de variables(RAM)

base:
    .hword 0 // Variable inicializada de 8 bytes (4 MEDIAS PALABRAS, 16 BITS CADA)
    .space 15,0x55


 /*     DIFERENCIAS DE PLANTEAR COMO RUTINA Y CON DIRECTIVAS AL ENSAMBLADOR
 *  

Resolver el ejercicio planteado como una rutina: El vector se llena en tiempo de ejecucion,

Resolver Con directivas al ensamblador: El vector se llena en tiempo de compilacion


MEMORIA VOLATIL: RAM, si apago la pc se me borra todo

MEMORIA NO VOLATIL: ROM o FLASH, NO se borra si apago la pc

EL CODIGO SE GUARDA EN MEMORIA FLASH
 */
 