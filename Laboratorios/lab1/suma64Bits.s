#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

/****************************************************************************************

    SUMA DOS NUMEROS DE 64 bits con CARRY y luego lo guardo en memoria

 ******************************************************************************************/
  
    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM


//=================== DEFINO VARIABLES GLOBALES =================================


    .section .data //define la seccion de variables(RAM)

datos:
    .word 0x32480000 // Variable inicializada de 8 bytes (4 MEDIAS PALABRAS, 16 BITS CADA)
    .word 0xE2480000
    .word 0x10100000
    .word 0x20C20000

//=================== PROGRAMA PRINCIPAL =======================================

    .section .text
    .global reset

reset:    
    LDR R0,=datos   //Direccion del primer dato

    LDR R1,[R0],#4  //R1 palabra menos significativa del primer numero
    LDR R2,[R0],#4  // R2 palabra mas significativa del primer numero
    
    LDR R3,[R0],#4  //R3 palabra menos significativa del segundo numero
    LDR R4,[R0],#4  //R4 palabra mas significativa del segundo numero
   
    ADDS R5,R2,R4  // sumo y toco el flags - carry
    
    STR R5,[R0],#4  //guardo el resultado menos significativo
    
    ADC R6,R1,R3   //Sumo con el carry anterior

    STR R6,[R0]  // GUardo el resultado mas significativo






