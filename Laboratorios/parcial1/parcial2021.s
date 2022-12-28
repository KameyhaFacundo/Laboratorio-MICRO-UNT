#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES    
//28/07/2022
#LABORATORIO N2

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data// Define la sección de variables (RAM)
/* 
h:
    .byte 0x03,0x4,0x1
 */
//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    //.func main
/*    
reset: 
    LDR R0,=h

    BL invertir

    .endfunc

stop: B stop
*/

    .func invertir
invertir:
  //  PUSH {LR}
  //  PUSH {R4,R5}
    
    //LDR R0,=h   //primer valor
    ADD R6,R0,#2
    MOV R1,R6 //Ultimo valor
    MOV R5,#0

lazo:
    PUSH {R0,R1}
    LDRB R3,[R0],#1 
    LDRB R4,[R1],#-1     

    CMP R5,#2
    BEQ final

    POP {R0,R1}
    STRB R4,[R0],#1
    STRB R3,[R1],#-1

    ADD R5,#1
    B lazo

final:
    BX LR
   // PUSH {r4,r5}
   // POP {PC}

    .endfunc











