
    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM

    .section .data

base:
    .word 0x01,0x01,0x04,0x06,0x01,0xFF

        .section .text
        .global reset

reset:
        MOV R0,#0x00    // Cuenta las veces que hay 0x01
        MOV R1,#0x01    // Valor a buscar
        LDR R2,=base    //Guardo la direccion de base
        
lazo:   LDR R3,[R2],#4  //Guardo la direccion de base en R3 y R2=R2+4 
        
        CMP R3,R1   //compara los numeros
        IT EQ       // si los registros son iguales salta
        ADDEQ R0,#1     //Entonces incrementa el resultado
        
        CMP R3,#0x00    //Si r3 no es cero
        BNE lazo    // entonces repite el lazo
        
stop:   B stop

