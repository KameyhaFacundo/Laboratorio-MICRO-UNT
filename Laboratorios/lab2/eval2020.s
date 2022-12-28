#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

    .cpu cortex-m4// Indica el procesador de destino
    .syntax unified// Habilita las instrucciones Thumb-2
    .thumb// Usar instrucciones Thumb y no ARM
   
//******************** DEFINO VARIABLES GLOBALES ******************************
    .section .data
    
divisoresEncontrados:
    .space 10
numero:
    .space 1
maximo:
    .space 1

//******************** PROGRAMA PRINCIPAL *************************************
    
    .section .text// Define la sección de código (FLASH)
    .global reset// Define el punto de entrada del código
    .func main

reset:
    MOV R0,#6 
    LDR R1,=divisoresEncontrados
    LDR R2,=numero
    LDR R3,=maximo

    BL encuentre

stop: B stop


    .endfunc
/* 
Escriba una subrutina en lenguaje ensamblador del Cortex-M4 que calcule la operación modulo, 
que cumpla el estándar EABI y que responda al siguiente prototipo:
    
    uint16_t modulo(uint16_t dividendo, uint16_t divisor);

 */
    .func mod
mod: 
    //mod recibe los valores en R0 y R1
  
    Lazo:
        CMP R0,R1  // Efectua una resta R0-R1
        BLT finLazo  // Si es negativo salta
    
        SUB R0,R0,R1
        B Lazo
    
    finLazo: BX LR
    .endfunc

/*Escriba una subrutina transparente divisores que calcule todos los divisores de un número
entero positivo menor o igual a 255. La misma debe recibir en el registro R0 el número y en el
registro R1 la dirección de inicio del vector donde se almacenarán los divisores encontrado. La
subrutina deberá devolver en R0 la cantidad de divisores encontrados para el número.
*/

  .func divisores 

divisores: 
    MOV R4,R0 //Numero que se le busca divisores
    MOV R5,R1 //R5 direccion

    MOV R1,#1 //Numero por el que empieza dividiendo
    MOV R6,#0 //Contador de divisores

    PUSH {LR}
    PUSH {R4,R5,R6} //Como llamare a una funcion guardo el valor del LR en la pila


LazoDiv:    
    CMP R1,R4   //Si R1>R4 salta
    BHI finLazoDiv

    MOV R0,R4 //Cargo el numero en R0 para la funcion R1 
                  
    BL mod //llamada a la funcion mod

    //Condicion para ver si R0 es 0 ES divisor
    CMP R0,#0
    ITT EQ
    ADDEQ R6,#1   //sumo 1 a R6 sumo la cantidad de divisores que tiene a 1
    STRBEQ R1,[R5],#1 //Guardo el divisor y muevo una direccion

    ADD R1,#1 //sumo 1 a R1 para que pruebe si el siguiente numero es divisor

    B LazoDiv //SAlto para volver al while

finLazoDiv:
    LDRB R4,[R5] //se carga al numero porque todos los numeros son divisibles por si mismo
    MOV R0,R6 //Devuelvo la cantidad de divisores en R0

    POP {R4,R5,R6} //Con el fin de hacer transparente la rutina ya que uso los registros
    POP {PC} //Vuelvo al main

    .endfunc

/* 

Escriba un programa que, usando las subrutinas anteriores, encuentre el número N, 
positivo menor que 255, con la mayor cantidad de divisores.
El programa deberá almacenar el resultado encontrado en la variable global numero 
y la cantidad de divisores correspondientes en la variable global maximo.

*/
    .func encuentre
encuentre:
    PUSH {LR}
    STRB R0,[R2]

    BL divisores

    STRB R0,[R3]

    POP {PC}

    .endfunc
    
    .align
    .pool
