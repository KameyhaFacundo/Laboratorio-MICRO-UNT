#KAMEYHA FACUNDO ADRIAN
#INGENIERIA EN COMPUTACION
#SISTEMAS CON MICROPROCESADORES Y MICROCONTROLADORES

//2) Escriba un programa para inicializar con 0x55 un vector. El tamaño de los datos del vector es
//de 16 bits y la cantidad de elementos se encuentra en la dirección base (también de 16 bits).
//El vector comienza en la dirección base+2.
//a) Resolver el ejercicio planteado como una rutina.
  
    .cpu cortex-m4  //Indica el procesador de destino
    .syntax unified //habilita la instrucciones thumb
    .thumb  //usar instrucciones thumb y no ARM


//=================== DEFINO VARIABLES GLOBALES =================================


    .section .data //define la seccion de variables(RAM)

base:
    .hword 0 // Guardo el numero 15 en 16bits (MEDIA PALABRA)
    .space 15,0x00 // 15 bytes de espacio

    //Otra forma cargo todos con cero
    //.space 4, 0x00 

//=================== PROGRAMA PRINCIPAL =======================================

    .section .text
    .global reset
    .func main
 
reset:
    MOV R0,#0x55    //Constante para cargar en memoria
    MOV R4,#10      //Las veces que cargare un dato a memoria
    
    LDR R2,=base+2  //Empiezo en 0x10080002 
    LDRH R1,[R2] //Guardo la direccion de base+2 en R1 

//Otra forma seria
//    LDR R2,=base
//    LDRH R1,[R2,#2]!  //Preincrementado R2=R2+2 y despues R1=M[R2+2]

lazo:
    STRH R1,[R2] //guardo la direccion en memoria M[R2]= R1 Y R2=R2+1
 
    SUB R4,#1    //resto R4=R4-1 hasta llegar a R4 = 0

    CMP R4,#0x00    //compara si R4=0, entonces pega el salto
    
    BEQ final

    STRH R0,[R2],#2 //Guardo en memoria M[R2]=R0=55 Y r2=r1+1

    B lazo


final: STRH R0,[R2],#2 //Guardo en memoria M[R2]=R0=55 Y r2=r1+1

stop: B stop
    .endfunc