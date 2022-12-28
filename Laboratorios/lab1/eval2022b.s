#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//=================== DEFINO VARIABLES GLOBALES =================================/

    .section .data// Define la sección de variables (RAM)

origen: 
    .byte 0x00// Variable inicializada de 5 bytes
    .space 15,0xFF// Completo los 20 lugares de origen con 0xFF
        
destino:
    .space 20,0x00// Variable de 20 bytes en blanco

base:
    .byte 0x06,0x0F,0x1A,0x3C

//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    
reset:
    LDR R0,=origen// Apunta R0 al bloque de origen
    LDR R1,=destino// Apunta R1 al bloque de destino
    LDR R3,=tabla// Apunta R3 al bloque con la tabla
   
    MOV R6,#4   //Contador
    LDR R4,=base  //Apunta R4 al bloque de tabla 
    LDR R8,=base+4  //Direccion 


valor: 
    CMP R6,#0
    BEQ lazo    //SALTO PARA HACER LA CONVERSION 

    LDRB R5,[R4],#1

    AND R5,0x0F

    STRB R5,[R0] //Guardo el valor para hacer la conversion

    SUB R6,#1
    
    B valor

lazo:
    LDRB R2,[R0],#1// Carga en R2 el elemento a convertir, inc 

    CMP R2,0xFF// Determina si es el fin de conversión
    BEQ final// Terminar si es fin de conversión

    LDRB R2,[R3,R2] // r2 = M( r3 + r2) // Cargar en R2 el elemento convertido
 
    STRB R2,[R1],#1// Guardar el elemento convertido 
    
    B lazo// Repetir el lazo de conversión

final: 
    STRB R2,[R1]  // Guardar el fin de conversión en destino

stop: 
    B stop// Lazo infinito para terminar la ejecución


tabla:
    .byte 0x3F,0x06,0x5B,0x4F,0x66
    .byte 0x6D,0x7D,0x07,0x7F,0x67
