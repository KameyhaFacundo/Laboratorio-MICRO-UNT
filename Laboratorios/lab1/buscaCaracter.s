
    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM

    .section .data

cadena:
    .asciz "SISTEMAS CON MICROPROCESADORES"

caracter:
    .ascii "S"

        .section .text
        .global reset

reset:
        MOV R0,#0x00
        LDR R1,=caracter
        LDRB R1,[R1]
        LDR R2,=cadena
        
lazo:   LDRB R3,[R2],#1
        CMP R3,R1
        IT EQ       // si los registros son iguales salta
        ADDEQ R0,#1     //Entonces incrementa el resultado
        CMP R3,#0x00
        BNE lazo
        
stop:   B stop