#Kameyha Facundo Adrian
#Ingenieria en Computacion


 .cpu cortex-m4          // Indica el procesador de destino
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"

/****************************************************************************/
/* Definiciones de macros                                                   */
/****************************************************************************/

// Recursos utilizados por el boton 1
    .equ BOTON1_PORT,   4
    .equ BOTON1_PIN,    8
    .equ BOTON1_BIT,    12
    .equ BOTON1_MASK,   (1 << BOTON1_BIT)

    .equ BOTON2_PORT,   4
    .equ BOTON2_PIN,    9
    .equ BOTON2_BIT,    13
    .equ BOTON2_MASK,   (1 << BOTON2_BIT)

    .equ BOTON3_PORT,   4
    .equ BOTON3_PIN,    10
    .equ BOTON3_BIT,    14
    .equ BOTON3_MASK,   (1 << BOTON3_BIT)

    .equ BOTON4_PORT,   6
    .equ BOTON4_PIN,    7
    .equ BOTON4_BIT,    15
    .equ BOTON4_MASK,   (1 << BOTON4_BIT)

    // Recursos utilizados por el BOTON ACEPTAR
    .equ BOTON_ACEPTAR_PORT,   3
    .equ BOTON_ACEPTAR_PIN,    2
    .equ BOTON_ACEPTAR_BIT,    9
    .equ BOTON_ACEPTAR_MASK,   (1 << BOTON_ACEPTAR_BIT)

    // Recursos utilizados por el BOTON CANCELAR
    .equ BOTON_CANC_PORT,   3
    .equ BOTON_CANC_PIN,    1
    .equ BOTON_CANC_BIT,    8
    .equ BOTON_CANC_MASK,   (1 << BOTON_CANC_BIT)


// Recursos utilizados por los botones
    .equ BOTON_GPIO,      5
    .equ BOTON_MASK,      ( BOTON1_MASK | BOTON2_MASK | BOTON3_MASK | BOTON4_MASK | BOTON_ACEPTAR_MASK | BOTON_CANC_MASK)

// Recursos utilizados por los digitos
    .equ DIGITO1_PORT,    0
    .equ DIGITO1_PIN,     0
    .equ DIGITO1_BIT,     0
    .equ DIGITO1_MASK,    (1 << DIGITO1_BIT)

    .equ DIGITO2_PORT,    0
    .equ DIGITO2_PIN,     1
    .equ DIGITO2_BIT,     1
    .equ DIGITO2_MASK,    (1 << DIGITO2_BIT)

    .equ DIGITO3_PORT,    1
    .equ DIGITO3_PIN,     15
    .equ DIGITO3_BIT,     2
    .equ DIGITO3_MASK,    (1 << DIGITO3_BIT)

    .equ DIGITO4_PORT,    1
    .equ DIGITO4_PIN,     17
    .equ DIGITO4_BIT,     3
    .equ DIGITO4_MASK,    (1 << DIGITO4_BIT)

// Recursos utilizados por los digitos
    .equ DIGITO_GPIO,      0
    .equ DIGITO_MASK,      ( DIGITO1_MASK | DIGITO2_MASK | DIGITO3_MASK | DIGITO4_MASK )

// Recursos utilizados por los segmentos
    .equ SEGA_PORT,    4
    .equ SEGA_PIN,     0
    .equ SEGA_BIT,     0
    .equ SEGA_MASK,    (1 << SEGA_BIT)

    .equ SEGB_PORT,    4
    .equ SEGB_PIN,     1
    .equ SEGB_BIT,     1
    .equ SEGB_MASK,    (1 << SEGB_BIT)

    .equ SEGC_PORT,    4
    .equ SEGC_PIN,     2
    .equ SEGC_BIT,     2
    .equ SEGC_MASK,    (1 << SEGC_BIT)

    .equ SEGD_PORT,    4
    .equ SEGD_PIN,     3
    .equ SEGD_BIT,     3
    .equ SEGD_MASK,    (1 << SEGD_BIT)

    .equ SEGE_PORT,    4
    .equ SEGE_PIN,     4
    .equ SEGE_BIT,     4
    .equ SEGE_MASK,    (1 << SEGE_BIT)

    .equ SEGF_PORT,    4
    .equ SEGF_PIN,     5
    .equ SEGF_BIT,     5
    .equ SEGF_MASK,    (1 << SEGF_BIT)

    .equ SEGG_PORT,    4
    .equ SEGG_PIN,     6
    .equ SEGG_BIT,     6
    .equ SEGG_MASK,    (1 << SEGG_BIT)

// Recursos utilizados por los segmentos
    .equ SEG_GPIO,      2
    .equ SEG_MASK,      ( SEGA_MASK |  SEGB_MASK | SEGC_MASK | SEGD_MASK | SEGE_MASK | SEGF_MASK | SEGG_MASK )


/****************************************************************************/
/* Vector de interrupciones                                                 */
/****************************************************************************/

    .section .isr           // Define una seccion especial para el vector
    .word   stack           //  0: Initial stack pointer value
    .word   reset+1         //  1: Initial program counter value
    .word   handler+1       //  2: Non mascarable interrupt service routine
    .word   handler+1       //  3: Hard fault system trap service routine
    .word   handler+1       //  4: Memory manager system trap service routine
    .word   handler+1       //  5: Bus fault system trap service routine
    .word   handler+1       //  6: Usage fault system tram service routine
    .word   0               //  7: Reserved entry
    .word   0               //  8: Reserved entry
    .word   0               //  9: Reserved entry
    .word   0               // 10: Reserved entry
    .word   handler+1       // 11: System service call trap service routine
    .word   0               // 12: Reserved entry
    .word   0               // 13: Reserved entry
    .word   handler+1       // 14: Pending service system trap service routine
    .word   systick_isr+1   // 15: System tick service routine
    .word   handler+1       // 16: Interrupt IRQ service routine

/****************************************************************************/
/* Definicion de variables globales                                         */
/****************************************************************************/

    .section .data          // Define la sección de variables (RAM)
espera:      .zero 1        // Variable el tiempo de espera
contador:    .hword 0x36 //54          
tabla:       .byte 0x03F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F   //devuelve los segmentos a prender
digito:      .byte 0x01  //Representa que digito esta encendido
bandera:     .byte 0x00  // indica si se presiono o no la tecla detener

/****************************************************************************/
/* Programa principal                                                       */
/****************************************************************************/

    .global reset           // Define el punto de entrada del código
    .section .text          // Define la sección de código (FLASH)
    .func main              // Inidica al depurador el inicio de una funcion
reset:
    // Mueve el vector de interrupciones al principio de la segunda RAM
    LDR R1,=VTOR
    LDR R0,=#0x10080000
    STR R0,[R1]



    // Llama a una subrutina para configurar el systick
    BL systick_init

  // Configura los pines de los display como gpio sin pull-up
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(DIGITO1_PORT << 7 | DIGITO1_PIN << 2)]
    STR R0,[R1,#(DIGITO2_PORT << 7 | DIGITO2_PIN << 2)]
    STR R0,[R1,#(DIGITO3_PORT << 7 | DIGITO3_PIN << 2)]
    STR R0,[R1,#(DIGITO4_PORT << 7 | DIGITO4_PIN << 2)]

    // Configura los pines de los segmentos como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(SEGA_PORT << 7 | SEGA_PIN << 2)]
    STR R0,[R1,#(SEGB_PORT << 7 | SEGB_PIN << 2)]
    STR R0,[R1,#(SEGC_PORT << 7 | SEGC_PIN << 2)]
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(SEGD_PORT << 7 | SEGD_PIN << 2)]
    STR R0,[R1,#(SEGE_PORT << 7 | SEGE_PIN << 2)]
    STR R0,[R1,#(SEGF_PORT << 7 | SEGF_PIN << 2)]
    STR R0,[R1,#(SEGG_PORT << 7 | SEGG_PIN << 2)]

    // Configura los pines de los botones como gpio con pull-up
    MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(BOTON1_PORT << 7 | BOTON1_PIN << 2)]
    STR R0,[R1,#(BOTON2_PORT << 7 | BOTON2_PIN << 2)]
    STR R0,[R1,#(BOTON3_PORT << 7 | BOTON3_PIN << 2)]
    STR R0,[R1,#(BOTON4_PORT << 7 | BOTON4_PIN << 2)]
    STR R0,[R1,#(BOTON_ACEPTAR_PORT << 7 | BOTON_ACEPTAR_PIN << 2)]
    STR R0,[R1,#(BOTON_CANC_PORT << 7 | BOTON_CANC_PIN << 2)]

    // Apaga todos los bits gpio de los digitos
    LDR R1,=GPIO_CLR0
    LDR R0,=DIGITO_MASK
    STR R0,[R1,#(DIGITO_GPIO << 2)]

    // Configura los bits gpio de los digitos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#(DIGITO_GPIO << 2)]
    ORR R0,#DIGITO_MASK
    STR R0,[R1,#(DIGITO_GPIO << 2)]

    // Apaga todos los bits gpio de los segmentos
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#(SEG_GPIO << 2)]

    // Configura los bits gpio de los segmentos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#(SEG_GPIO << 2)]
    ORR R0,#SEG_MASK
    STR R0,[R1,#(SEG_GPIO << 2)]

    // Configura los bits gpio de los botones como entradas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#(BOTON_GPIO << 2)]
    AND R0,#~BOTON_MASK
    STR R0,[R1,#(BOTON_GPIO << 2)]


    // Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0

    // Registros usados como  antirebote
    MOV R5,#0
    MOV R6,#0
    MOV R7,#0


 refrescar:

    // Carga el estado actual de las teclas
    LDR   R0,[R4,#(BOTON_GPIO << 2)]

    ANDS  R1,R0,#(1 << BOTON_ACEPTAR_BIT)  // Si la tecla esta apretada 
    MVN R7,R7
    ANDS R7,R1
    IT    NE
    BLNE  comenzar      //comienza o reinicia la cuenta
    MOV R7,R1

    ANDS  R1,R0,#(1 << BOTON_CANC_BIT)//   Si la tecla esta apretada
    MVN R5,R5
    ANDS R5,R1
    IT    NE
    BLNE  resetear          //vuelve a 0 la cuenta
    MOV R5,R1

    // Repite el lazo de refresco indefinidamente
    B     refrescar

stop:
    B stop

    .pool                   // Almacenar las constantes de código

    .endfunc

/****************************************************************************/
/* Rutina de inicialización del SysTick                                     */
/****************************************************************************/
    .func systick_init
systick_init:
    CPSID I                 // Deshabilita interrupciones

    // Configurar prioridad de la interrupcion
    LDR R1,=SHPR3           // Apunta al registro de prioridades
    LDR R0,[R1]             // Carga las prioridades actuales
    MOV R2,#2               // Fija la prioridad en 2
    BFI R0,R2,#29,#3        // Inserta el valor en el campo
    STR R0,[R1]             // Actualiza las prioridades

    // Habilitar el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x00
    STR R0,[R1]             // Quita ENABLE

    // Configurar el desborde para un periodo de 100 ms               
    LDR R1,=SYST_RVR
   
    LDR R0,=#(60000 - 1)//4800                                   
    STR R0,[R1]             // Especifica valor RELOAD

    // Inicializar el valor actual del contador
    // Escribir cualquier valor limpia el contador
    LDR R1,=SYST_CVR
    MOV R0,#0
    STR R0,[R1]             // Limpia COUNTER y flag COUNT

    // Habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x07
    STR R0,[R1]             // Fija TICKINT y CLOCK_SRC

    CPSIE I                 // Rehabilita interrupciones
    BX  LR                  // Retorna al programa principal
    .pool                   // Almacena las constantes de código
    .endfunc

/****************************************************************************/
/* Rutina de servicio para la interrupcion del SysTick                      */
/****************************************************************************/
    .func systick_isr
systick_isr:

    LDR  R0,=espera         // Apunta R0 a espera
    LDRB R1,[R0]            // Carga el valor de espera
    SUBS R1,#1              // Decrementa el valor de espera
    BHI  systick_exit       // Espera > 0, No pasaron 10 veces
    PUSH {R0,LR}            // Conserva los registros que uso
    LDR  R2,=bandera        //Obtengo el valor de bandera
    LDRB R2,[R2]
    CMP R2,#1               // si bandera=1 indica que no se presiono la tecla detener
    IT EQ
    BLEQ   segundos         // Llama a la subrutina para incrementar 1 segundo
    POP  {R0,LR}            // Recupera los registros conservados
    MOV  R1,#207             // Vuelvo a carga  la cantidad  de  iterciones necesarias para contar 1 seg
systick_exit:
    STRB R1,[R0]            // Actualiza la variable espera
    PUSH {R0,R1,LR}
    BL   multiplexar
    POP   {R0,R1,LR}
    BX    LR

    .pool                   // Almacena las constantes de código
    .endfunc

multiplexar:
    LDR  R0,=digito         // Apunta R0 a digito
    LDRB R1,[R0]            // Carga el valor de digito
    CMP R1,#8               // comparo si llego al 4 cuarto digito  
    ITE EQ
      MOVEQ R1,#1       //si llego lo pongo en el primer digito
      LSLNE R1,#1       //sino desplazo uno hasta llegar al 4 digito
    STRB R1,[R0]

    //APAGO TODO
    LDR R2,=GPIO_CLR0       //apago los segmentos
    LDR R0,=SEG_MASK
    STR R0,[R2,#(SEG_GPIO << 2)]

    LDR R2,=GPIO_CLR0   //apago los digitos
    LDR R0,=DIGITO_MASK
    STR R0,[R2,#(DIGITO_GPIO << 2)]


    LDR R0,=contador
    LDRH R2,[R0] //traigo el valor de contador y lo guardo en r2

 //Primer digito

    CMP R1,#1 
    MOV R3,#10 //menor < 10
    ITTT EQ
    UDIVEQ R0,R2,R3
    MULEQ R0,R3
    SUBEQ R2,R0 

    PUSH {R4}

 //Segundo digito
    CMP R1,#2      
    MOV R3,#100
    MOV R4,#10
    ITTTT EQ
    UDIVEQ R0,R2,R3
    MULEQ R0,R3
    SUBEQ R2,R0
    UDIVEQ R2,R4

 //Tercer digito
    CMP R1,#4        
    MOV R3,#1000
    MOV R4,#100
    ITTTT EQ
    UDIVEQ R0,R2,R3
    MULEQ R0,R3
    SUBEQ R2,R0
    UDIVEQ R2,R4

 //Cuarto digito
    CMP R1,#8        
    MOV R3,#1000
    MOV R4,#1000
    ITTTT EQ
    UDIVEQ R0,R2,R3
    MULEQ R0,R3
    SUBEQ R2,R0
    UDIVEQ R2,R4
    
    //obtengo en R2 el valor en decimal a mostar en el display

    LDR R0,=GPIO_SET0
    STR R1,[R0]    //Prendo los digitos

    LDR R0,=GPIO_SET2
    ldr R1,=tabla
    LDR R2,[R1,R2]  
    STR R2,[R0]     //Prendo los segmentos


    POP {R4}


    BX   LR                 // Retorna al programa principal


/****************************************************************************/
/* Rutina de servicio generica para excepciones                             */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa.  */
/* Se declara como una medida de seguridad para evitar que el procesador    */
/* se pierda cuando hay una excepcion no prevista por el programador        */
/****************************************************************************/
    .func handler
handler:
    LDR R0,=set_led_1       // Apuntar al incio de una subrutina lejana
    BLX R0                  // Llamar a la rutina para encender el led rojo
    B handler               // Lazo infinito para detener la ejecucion
    .pool                   // Almacenar las constantes de codigo
    .endfunc
/****************************************************************************/
/* Rutina detener                                                           */
/* Esta rutina  pone un cero en la bandera para indicar que se detenga      */
/****************************************************************************/
detener:
    PUSH  {R0,R1}
    LDR  R0,=bandera
    MOV R1,#0                             
    STRB R1,[R0]                          
    POP   {R0,R1}
    BX    LR
 /*****************************************************************************/
 /* Rutina comenzar                                                           */
 /*****************************************************************************/
comenzar:
    PUSH  {R0,R1}
    LDR  R0,=bandera
    MOV R1,#1
    STRB R1,[R0]
    LDR   R0,=SYST_CVR
    MOV   R1,#7
    STR   R1,[R0]   //Habilito el contador

    POP   {R0,R1}
    BX    LR
/*****************************************************************************/
/* Rutina resetear                                                           */
/*****************************************************************************/
resetear:
    PUSH  {R0,R1}
    LDR   R1,=SYST_CVR
    MOV   R0,#1
    STR   R0,[R1]   // Limpia COUNTER y flag COUNT

    LDR R0,=contador
    MOV R1,#54        // coloco el 54, valor inicial
    STRH R1,[R0]
    POP   {R0,R1}
    BX    LR
/*****************************************************************************/
/* Rutina segundos                                                           */                      
/*****************************************************************************/
segundos:
    PUSH  {R0,R1,R2}
    LDR   R0,=contador   //comienza con 54
    LDRH  R1,[R0]
    LDRH  R2,=#0                       
    CMP   R1,R2
    ITE   EQ
    MOVEQ R1,#0       //La cuenta debe detener en cero               
    SUBNE R1,#1       // va restando hasta llegar a 0
    STRH  R1,[R0]
    POP  {R0,R1,R2}
    BX    LR

