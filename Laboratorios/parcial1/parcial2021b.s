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
x:
    .byte 0x00,0x00,0x01,0x04,0x2,0x5

h: 
    .byte 0x01,0x04,0x3 

destino:
    .space 8
*/
//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
  //  .func main
 /*    
reset: 
    LDR R0,=x
    LDR R1,=destino
    MOV R2,#4
    MOV R3,#2

   // BL transformo

    LDR R0,=x
    LDR R1,=h
    MOV R2,#3

    BL calculo

    .endfunc

stop: B stop
*/
    .func transformo
transformo:
    PUSH {LR}
    PUSH {R4,R5}
    MOV R4,#0 //PARA PONER CEROS
    PUSH {R3,R4}

    MOV R5,#8 //TOTAL DESTINO

ponerCero:
    CMP R5,#0
    BEQ final2

    CMP R3,#0
    BEQ lazo2

    STRB R4,[R1],#1
    SUB R3,#1
    SUB R5,#1

    B ponerCero

lazo2:
    CMP R2,#0
    BEQ reseteo

    LDRB R4,[R0],#1
    STRB R4,[R1],#1

    SUB R2,#1
    SUB R5,#1

    B lazo2

reseteo:
    POP {R3,R4}
    B ponerCero

final2:
    POP {R4,R5}
    POP {PC}

    .endfunc


    .func calculo
calculo:
    MOV R5,#0 //SUMADOR
    MOV R2,#3
 //   PUSH {LR}
    PUSH {R4,R5,R6}

lazo1:
    CMP R2,#0
    BEQ finalCalculo

    LDRB R3,[R0],#1
    LDRB R4,[R1],#1

    MUL R6,R3,R4
    ADD R5,R6

    SUB R2,#1

    B lazo1
finalCalculo:
    MOV R3,R5
    
//    POP {LR}
    POP {R4,R5,R6}
    BX LR
    .endfunc










