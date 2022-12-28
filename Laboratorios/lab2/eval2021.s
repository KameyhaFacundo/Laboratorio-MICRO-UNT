#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//=================== DEFINO VARIABLES GLOBALES =================================

    .section .data// Define la sección de variables (RAM)
    
//numero: .byte 0x29

fechaActual:
    .byte 0x29,0x09
    //DIA=29 / MES=09

destino:
    .space 15,0x00// Completo los 20

//=================== PROGRAMA PRINCIPAL =======================================
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main
    
reset:

 //PRUEBA FECHA
    LDR R0,=fechaActual //Obtengo la direccion de fechaActual
    LDR R1,=destino     //Obtengo la direccion de destino 
    MOV R2,#0           //Lo utilizare como contador
    LDR R3,=tabla       //Apunta R3 al bloque con la tabla

    BL fecha

stop: B stop// Lazo infinito para terminar la ejecución
    
    .endfunc

/*subrutina deberá recibir en R0 el valor BCD a convertir y devuelve en el mismo registro
su correspondiente conversion */

    .func convierte
convierte:
    LDRB R0,[R3,R0] // r2 = M( r3 + r2) // Cargar en R2 el elemento convertido
   
    BX LR //Retorna al menu principal

    .endfunc

/* Recibe en R0 la dirección de memoria donde está almacenado un número binario de un byte menor o igual que 99. 
La subrutina guarda, como bytes, el valor de las decenas en la dirección de memoria almacenada 
en R1 y el valor de las unidades en la dirección siguiente.

    Dato                Resultado
(numero) = 29           (destino) = 2
                        (destino + 1) = 9
 */

    .func conversion
conversion:
    LDRB R3,[R0]    //Cargo en R3, el valor que esta en la direcc R0

    AND R2,R3,#0xF0 //Obtengo la parte mas significativa
    LSR R2,R2,#4    //Desplazo a la derecha para que se posicione en la parte menos significativa
    STRB R2,[R1],#1 //Guardo y desplazo a la siguiente direccion

    AND R2,R3,#0x0F //Obtengo la parte menos significativa
    STRB R2,[R1],#1 //Guardo y desplazo a la siguiente direccion

    

    BX LR   //Retorno 
    .endfunc


/*
Escriba una subrutina transparente fecha que reciba en el registro R0 la dirección de memoria 
donde se encuentra almacenada la fecha actual. Esta fecha se almacena como el día
en un byte y el mes en el byte siguiente. Esta subrutina debe almacenar la correspondiente
representación en siete segmentos de los cuatro dígitos a partir de la dirección de memoria 
apuntada por R1, según el siguiente ejemplo. 

Esta subrutina debe obligatoriamente utilizar las dos subrutinas previamente desarrolladas

Fecha               Resultado
(dia) = 29      (destino) = 0x5B (Segmentos correspondientes al 2)
(mes) = 9       (destino + 1) = 0x67 (Segmentos correspondientes al 9)
                (destino + 2) = 0x3F (Segmentos correspondientes al 0)
                (destino + 3) = 0x67 (Segmentos correspondientes al 9)
 */
    .func fecha
fecha:
    MOV R4,#2

    PUSH {LR}   //Para poder saltar al final con POP {PC} al menu principal

    PUSH {R0,R1,R2,R3} //Como llamare a una funcion guardo el valor del LR en la pila
 
lazo:
    LDRB R3,[R0]    //Cargo los valores en el registro R3

    CMP R4,#0   //Comparo dos veces
    BEQ resetea //salto para recuperar las direcciones anteriores

    BL conversion   //Separo los numeros
    
    LDRB R3,[R0],#1 //Cargo el siguiente Numero

    SUB R4,#1   //Decremento R4-1 
    
    B lazo

resetea:
    POP {R0,R1,R2,R3}   //Recupero los valores iniciales

final:
    LDRB R0,[R1]    //Cargo los valores a convertir

    CMP R2,#4
    BEQ finConversion

    BL convierte    //Convierte para prender el display
 
    STRB R0,[R1],#1 //Guardo los valores convertidos en memoria
    
    ADD R2,#1   //Sumo R2 + 1 

    B final

finConversion:
    POP {PC}    //Retorno al menu principal
    
    .endfunc

tabla:  
    .byte 0x3F,0x06,0x5B,0x4F,0x66
    .byte 0x6D,0x7D,0x07,0x7F,0x67
