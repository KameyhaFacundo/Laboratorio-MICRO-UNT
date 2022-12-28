/**
6) [Profundización] Escriba la subrutina que ejecute el gestor de eventos correspondiente a las
teclas del reloj. Ésta debe identificar la subrutina correspondiente a la tecla presionada (gestor
del evento) y saltar a la misma. Para ello emplea el código de la tecla presionada almacenado
en el registro R0 como un índice en una tabla de saltos que comienza en el lugar base. Cada
entrada en la tabla de saltos contiene la dirección de la primera instrucción de la subrutina
correspondiente (punto de entrada). El programa debe transferir control a la dirección que
corresponde al índice. Por ejemplo, si el índice fuera 2, el programa saltaría a la dirección que
está almacenada en la entrada 2 de la tabla. Como es lógico cada entrada tiene 4 bytes. Por
ejemplo:
R0=2
                Datos                   Resultado
    (base) = 0x1A00.1D05                                
    (base + 4) = 0x1A00.2321          (PC) = 0x1A00.5FC4
    (base + 8) = 0x01A0.5FC4
    (base + 12) = 0x01A0.7C3A

 */
    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************

    .section .data// Define la sección de variables (RAM)

base:
    .byte 0x1A00.1D05,0x1A00.2321,0x01A0.5FC4,0x01A0.7C3A

//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    MOV R0,#2
    LDR R1,=base
    BL controlSalto

stop: B stop

controlSalto:
    LDR R1,[R0]





