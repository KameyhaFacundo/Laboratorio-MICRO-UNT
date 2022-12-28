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

numero:
    .byte 0xD7

//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main
    
reset: 
    LDR R0,=numero
    LDR R1,=tabla       //Apunta R3 al bloque con la tabla

    BL conversion

    .endfunc

stop: B stop

/*
 Escriba una subrutina transparente que reciba la dirección del numero de 1 byte en R0.
El mapa de bits de 7 segmentos de centena, decena y unidad del número convertido deberán 
almacenarse en las direcciones de memoria consecutivas a R0, respectivamente.

En el siguiente ejemplo convertirmos el número 215 en su mapa de bits de 7 segmentos:

Pre condiciones M[R0]= 0xD7 (215 10)

Resultado       M[R0+1]=0x5B (2 10) M[R0+2]=0x06 (1 10) M[R0+3]=0x6D (5 10)

 */

    .func convierte
convierte:
    LDRB R3,[R1,R3] // r2 = M( r3 + r2) // Cargar en R2 el elemento convertido
    STRB R3,[R0]
   
    BX LR //Retorna al menu principal

    .endfunc


    .func conversion
conversion:
    PUSH {LR}
    PUSH {R0,R1,R2}

    MOV R1,#100
    LDRB R3,[R0],#1    //Cargo en R3, el valor que esta en la direcc R0

    UDIV R2,R3,R1
    STRB R2,[R0],#1 //Guardo y desplazo a la siguiente direccion
    
    MOV R1,#10
    UDIV R2,R3,R1
    AND R2,R2,#0xF0 //Obtengo la parte mas significativa
    LSR R2,R2,#4    //Desplazo a la derecha para que se posicione en la parte menos significativa
    STRB R2,[R0],#1 //Guardo y desplazo a la siguiente direccion

    UDIV R2,R3,R1
    AND R2,R2,#0x0F //Obtengo la parte menos significativa
    STRB R2,[R0],#1 //Guardo y desplazo a la siguiente direccion

    POP {R0,R1,R2}

lazo:
    CMP R2,#3
    BEQ final
    LDRB R3,[R0,#1]!
  
    BL convierte

    ADD R2,#1

    B lazo

final:
    POP {PC}   //Retorno 
    .endfunc

    .pool // Almacena las constantes de codigo

tabla:  
    .byte 0x3F,0x06,0x5B,0x4F,0x66
    .byte 0x6D,0x7D,0x07,0x7F,0x67
