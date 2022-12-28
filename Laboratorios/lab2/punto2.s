
/*
2) Escriba una subrutina transparente que realice la suma de un número de 64 bits y uno de
32 bits. Esta subrutina recibe la dirección del número de 64 bits en R0 y el número de 32
bits en R1. El resultado, de 64 bits, se almacena en el mismo lugar donde se recibió el pri-
mer operando. Escriba un programa principal para probar el funcionamiento de la misma. 

Por ejemplo:
                                R0 = 0x1008.0000        R1 = 0xA056.0102
            Pre condiciones     M[R0] = 0x8100.0304     M[R0+4] = 0x0020.0605
            Resultado           M[R0] = 0x2156.0406     M[R0+4] = 0x0020.0606
 */

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************

    .section .data// Define la sección de variables (RAM)

primero:     .word 0x81000304,0x00200605
segundo:      .word 0xA0560102

//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text  // Define la sección de código (FLASH)
    .global reset   // Define el punto de entrada del código
    .func main

reset:     
    LDR R0,=primero //Obtengo la direccion de la parte alta del numero de 64bits
    LDR R1,=segundo //Obtengo la direccion del numero de 32bits
    LDR R1,[R1]     //Cargo el numero de 32 bits

    BL suma         //Llamo a la subrutina
        
    STR R1,[R0]     // guardo en memoria (base) la parte baja
    STR R3,[R0,#4]  // guardo en memoria (base+4) la parte alta

stop: B stop        // Lazo infinito para terminar la ejecucion
    .endFunc

suma: 
    LDR R2,[R0]     //Obtengo la parte baja de primero
    LDR R3,[R0,#4]  //obtengo la parte alta de primero
    ADDS R1,R2      //Guardo la parte baja del resultado en R1 y actico el flag de carry
    ADC  R3,#0x00   //R3=R3 + 0 + carry
    BX  LR          //Retorno al programa principal



