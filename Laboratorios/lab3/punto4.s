    .cpu cortex-m4          // Indica el procesador de destino
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"

/****************************************************************************/
/* Definiciones de macros                                                   */
/****************************************************************************/

// Recursos utilizados por el canal Rojo del led RGB
    .equ LED_R_PORT,    2
    .equ LED_R_PIN,     0
    .equ LED_R_BIT,     0
    .equ LED_R_MASK,    (1 << LED_R_BIT)

// Recursos utilizados por el canal Verde del led RGB
    .equ LED_G_PORT,    2
    .equ LED_G_PIN,     1
    .equ LED_G_BIT,     1
    .equ LED_G_MASK,    (1 << LED_G_BIT)

// Recursos utilizados por el canal Azul del led RGB
    .equ LED_B_PORT,    2
    .equ LED_B_PIN,     2
    .equ LED_B_BIT,     2
    .equ LED_B_MASK,    (1 << LED_B_BIT)

// Recursos utilizados por el led RGB
    .equ LED_GPIO,      5
    .equ LED_MASK,      ( LED_R_MASK | LED_G_MASK | LED_B_MASK )

/****************************************************************************/

// Recursos utilizados por la primera tecla
    .equ TEC_1_PORT,    4
    .equ TEC_1_PIN,     8
    .equ TEC_1_BIT,     12
    .equ TEC_1_MASK,    (1 << TEC_1_BIT)

// Recursos utilizados por la segunda tecla
    .equ TEC_2_PORT,    4
    .equ TEC_2_PIN,     9
    .equ TEC_2_BIT,     13
    .equ TEC_2_MASK,    (1 << TEC_2_BIT)

// Recursos utilizados por la tercera tecla
    .equ TEC_3_PORT,    4
    .equ TEC_3_PIN,     10
    .equ TEC_3_BIT,     14
    .equ TEC_3_MASK,    (1 << TEC_3_BIT)

// Recursos utilizados por la cuarta tecla
    .equ TEC_4_PORT,    6
    .equ TEC_4_PIN,     7
    .equ TEC_4_BIT,     15
    .equ TEC_4_MASK,    (1 << TEC_4_BIT)

// Recursos utilizados por la tecla "Aceptar"
    .equ TEC_AC_PORT,    3
    .equ TEC_AC_PIN,     1
    .equ TEC_AC_BIT,     8
    .equ TEC_AC_MASK,    (1 << TEC_AC_BIT)

// Recursos utilizados por la tecla "Cancelar"
    .equ TEC_CN_PORT,    1
    .equ TEC_CN_PIN,     2
    .equ TEC_CN_BIT,     9
    .equ TEC_CN_MASK,    (1 << TEC_CN_BIT)

// Recursos utilizados por el teclado
    .equ TEC_GPIO,      5
    .equ TEC_MASK,      ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK | TEC_4_MASK | TEC_AC_MASK | TEC_CN_MASK )

/****************************************************************************/

// Recursos utilizados por el Segmento A del display
    .equ SEG_A_PORT,    4
    .equ SEG_A_PIN,     0
    .equ SEG_A_BIT,     0
    .equ SEG_A_MASK,    (1 << SEG_A_BIT)

// Recursos utilizados por el Segmento B del display
    .equ SEG_B_PORT,    4
    .equ SEG_B_PIN,     1
    .equ SEG_B_BIT,     1
    .equ SEG_B_MASK,    (1 << SEG_B_BIT)

// Recursos utilizados por el Segmento C del display
    .equ SEG_C_PORT,    4
    .equ SEG_C_PIN,     2
    .equ SEG_C_BIT,     2
    .equ SEG_C_MASK,    (1 << SEG_C_BIT)

// Recursos utilizados por el Segmento D del display
    .equ SEG_D_PORT,    4
    .equ SEG_D_PIN,     3
    .equ SEG_D_BIT,     3
    .equ SEG_D_MASK,    (1 << SEG_D_BIT)

// Recursos utilizados por el Segmento E del display
    .equ SEG_E_PORT,    4
    .equ SEG_E_PIN,     4
    .equ SEG_E_BIT,     4
    .equ SEG_E_MASK,    (1 << SEG_E_BIT)

// Recursos utilizados por el Segmento F del display
    .equ SEG_F_PORT,    4
    .equ SEG_F_PIN,     5
    .equ SEG_F_BIT,     5
    .equ SEG_F_MASK,    (1 << SEG_F_BIT)

// Recursos utilizados por el Segmento G del display
    .equ SEG_G_PORT,    4
    .equ SEG_G_PIN,     6
    .equ SEG_G_BIT,     6
    .equ SEG_G_MASK,    (1 << SEG_G_BIT)

// Recursos utilizados por los 7 segmentos del display
    .equ SEG_GPIO,      2
    .equ SEG_MASK,      ( SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK )


// Recursos utilizados por el Segmento DP del display
    .equ SEG_DP_PORT,    6
    .equ SEG_DP_PIN,     8
    .equ SEG_DP_BIT,     16
    .equ SEG_DP_MASK,    (1 << SEG_DP_BIT)

// Recursos utilizados por el punto del display
    .equ SEG_DP_GPIO,      5

/****************************************************************************/
// Recursos utilizados por el digito 1
    .equ DIG_1_PORT,    0
    .equ DIG_1_PIN,     0
    .equ DIG_1_BIT,     0
    .equ DIG_1_MASK,    (1 << DIG_1_BIT)

// Recursos utilizados por el digito 2
    .equ DIG_2_PORT,    0
    .equ DIG_2_PIN,     1
    .equ DIG_2_BIT,     1
    .equ DIG_2_MASK,    (1 << DIG_2_BIT)

// Recursos utilizados por el digito 3
    .equ DIG_3_PORT,    1
    .equ DIG_3_PIN,     15
    .equ DIG_3_BIT,     2
    .equ DIG_3_MASK,    (1 << DIG_3_BIT)

// Recursos utilizados por el digito 4
    .equ DIG_4_PORT,    1
    .equ DIG_4_PIN,     17
    .equ DIG_4_BIT,     3
    .equ DIG_4_MASK,    (1 << DIG_4_BIT)

// Recursos utilizados por los digitos
    .equ DIG_GPIO,      0
    .equ DIG_MASK,      ( DIG_1_MASK | DIG_2_MASK | DIG_3_MASK | DIG_4_MASK )


/****************************************************************************/
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
espera:
    .zero 1                 // Variable compartida con el tiempo de espera
segundo:
    .byte 0
minuto:
    .byte 0
contador:                   //variable para guardar estado del contador que se muestra en display
    .byte 0
habilitado:
    .byte 1                 // con 1 se habilita la cuenta
  bandera:     
    .byte 0x00  // indica si se presiono o no la tecla detener
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

    // Llama a una subrutina existente en flash para configurar los leds
    LDR R1,=leds_init
    BLX R1

    // Llama a una subrutina para configurar el systick
    BL systick_init

    // Configura los pines de los leds como gpio sin pull-up
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(LED_R_PORT << 7 | LED_R_PIN << 2)]
    STR R0,[R1,#(LED_G_PORT << 7 | LED_G_PIN << 2)]
    STR R0,[R1,#(LED_B_PORT << 7 | LED_B_PIN << 2)]

    // Configura los pines de las teclas como gpio con pull-up
    MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(TEC_1_PORT << 7 | TEC_1_PIN << 2)]
    STR R0,[R1,#(TEC_2_PORT << 7 | TEC_2_PIN << 2)]
    STR R0,[R1,#(TEC_3_PORT << 7 | TEC_3_PIN << 2)]
    STR R0,[R1,#(TEC_4_PORT << 7 | TEC_4_PIN << 2)]
    STR R0,[R1,#(TEC_AC_PORT << 7 | TEC_AC_PIN << 2)]
    STR R0,[R1,#(TEC_CN_PORT << 7 | TEC_CN_PIN << 2)]

    // Configura los pines de los segmentos del display y los habilitadores
    //de los digitoscomo gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(SEG_A_PORT << 7 | SEG_A_PIN << 2)]
    STR R0,[R1,#(SEG_B_PORT << 7 | SEG_B_PIN << 2)]
    STR R0,[R1,#(SEG_C_PORT << 7 | SEG_C_PIN << 2)]
    STR R0,[R1,#(SEG_D_PORT << 7 | SEG_D_PIN << 2)]
    STR R0,[R1,#(SEG_E_PORT << 7 | SEG_E_PIN << 2)]
    STR R0,[R1,#(SEG_F_PORT << 7 | SEG_F_PIN << 2)]
    STR R0,[R1,#(SEG_G_PORT << 7 | SEG_G_PIN << 2)]
    STR R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
    STR R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
    STR R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
    STR R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]

    //Configura el punto del display igual que los segmentos pero funcion distinta
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(SEG_DP_PORT << 7 | SEG_DP_PIN << 2)]

    // Apaga todos los bits gpio de los leds
    LDR R1,=GPIO_CLR0
    LDR R0,=LED_MASK
    STR R0,[R1,#(LED_GPIO << 2)]

    // Apaga todos los bits gpio de los segmentos,el punto y apago habilitadores de digitos
    LDR R0,=SEG_MASK
    STR R0,[R1,#(SEG_GPIO << 2)]
    LDR R0,=DIG_MASK
    STR R0,[R1,#(DIG_GPIO << 2)]
    LDR R0,=SEG_DP_MASK
    STR R0,[R1,#(SEG_DP_GPIO << 2)]

    // Configura los bits gpio de los leds como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#(LED_GPIO << 2)]
    ORR R0,#LED_MASK
    STR R0,[R1,#(LED_GPIO << 2)]

    // Configura los bits gpio de los botones como entradas
    LDR R0,[R1,#(TEC_GPIO << 2)]
    AND R0,#~TEC_MASK
    STR R0,[R1,#(TEC_GPIO << 2)]

    // Configura los bits gpio de los segmentos,punto y habilitadores de digitos como salidas
    LDR R0,[R1,#(SEG_GPIO << 2)]
    ORR R0,#SEG_MASK
    STR R0,[R1,#(SEG_GPIO << 2)]
    LDR R0,[R1,#(SEG_DP_GPIO << 2)]
    ORR R0,#SEG_DP_MASK
    STR R0,[R1,#(SEG_DP_GPIO << 2)]
    LDR R0,[R1,#(DIG_GPIO << 2)]
    ORR R0,#DIG_MASK
    STR R0,[R1,#(DIG_GPIO << 2)]

    // Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0
  //  LDR R5,=GPIO_NOT0
    
    // Registros usados como  antirebote
    MOV R5,#0
    MOV R6,#0
    MOV R7,#0
 
 refrescar:
    // Carga el estado actual de las teclas
    LDR   R0,[R4,#(TEC_GPIO << 2)]

    // Verifica el estado del bit correspondiente a la tecla uno
    ANDS  R1,R0,#(1 << TEC_AC_BIT)     //Si la tecla esta apretada
    MVN R6,R6   //garantizo que solo entra la primera vez que se presiona la tecla
    ANDS R6,R1
    IT NE
    BLNE detener       //detiene el conteo
    MOV R6,R1

    ANDS  R1,R0,#(1 << TEC_AC_BIT)  // Si la tecla esta apretada
    MVN R7,R7
    ANDS R7,R1
    IT NE
    BLNE comenzar      //comienza o reinicia la cuenta
    MOV R7,R1

    B refrescar

stop: B stop
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
    LDR R0,=#(600000 - 1)
    /*LDR R0,=#(400000 - 1)*/
    STR R0,[R1]             // Especifica valor RELOAD

    // Inicializar el valor actual del contador
    // Escribir cualquier valor limpia el contador
    LDR R1,=SYST_CVR
    MOV R0,#0
    STR R0,[R1]             // Limpia COUNTER y flag COUNT

    // Habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x07
    STR R0,[R1]             // Fija ENABLE, TICKINT y CLOCK_SRC

    CPSIE I            // Rehabilita interrupciones
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
    PUSH {R4-R11}
    LDR R10, =contador       //segundo lleva la cuenta del timer
    LDRB R11, [R10]
    
    CMP R1,#0               //espera lleva la cuenta que actualiza los displays
    IT EQ
    MOVEQ R1,#5

    SUB R1,#1              // Decrementa el valor de espera

    LDR R3,=segundo
    LDRB R2,[R3]            //obtengo valor de los segundos
    LDRB R0,[R3,#1]         //obtengo el valor de los minutos

    CMP R2, #59          //compara si lossegundos llegaron a 59 
    BEQ esMaxSeg

    CMP R11,#0              //cuando debe actualizar el contador
    ITTE EQ
    ADDEQ R2,#1     //sumo segundos
    MOVEQ R11, #160           //aca va la cantidad de ciclos
    SUBNE R11, #1
    B noCero

esMaxSeg:              //Si segundo es 59 entrara     
    MOV R2,#0           //Pongo en 0 para sumar un minuto 01 00
    ADD R0,#1           //Incrementa minutos
    B systick_exit

noCero:                         //prende led cuando cuenta no es 0
    LDR R5,=GPIO_PIN0
    MOV R4,#0
    
    STR   R4,[R5,#(LED_GPIO << 2)]
    B multiplexado

systick_exit:
    STRB R2,[R3]            //actualizo contador
    STRB R0,[R3,#1]
    STRB R11,[R10]          //actualizo ciclos
    POP {R4-R11}
    LDR R0,=espera
    STRB R1,[R0]            // Actualiza la variable espera
    BX   LR                 // Retorna al programa principal
    .pool                   // Almacena las constantes de código
    .endfunc

/******************************************************************
*******************************************************************/
    .func multiplexado
multiplexado:
    LDR R4,=GPIO_CLR0
    LDR R5,=GPIO_SET0
    LDR R8,=GPIO_PIN0
    ADR R7, tabla


    CMP R1,#4
    BEQ dig1
    
    CMP R1,#3
    BEQ dig2
    
    CMP R1,#2
    BEQ dig3
    
    CMP R1,#1
    BEQ dig4

dig1:
    //deshabilito los digitos 2 3 y 4
    MOV R6, #(DIG_2_MASK | DIG_3_MASK | DIG_4_MASK)
    STR R6,[R4,#(DIG_GPIO << 2)]

    //obtengo valor de la unidad
    MOV R4,#10
    UDIV R9, R2, R4
    MUL R9,R4
    SUB R5, R2,R9
    LDR R9, [R7,R5]                 //obtengo el digito
    //cargo el valor de los segmentos para el digito uno
    STRB R9,[R8,#(SEG_GPIO << 2)]

    LDR R5,=GPIO_SET0
    //Habilito digito uno
    LDR R6, =DIG_1_MASK
    STR R6,[R5,#(DIG_GPIO << 2)]

    B  systick_exit

dig2:

    //deshabilito digito uno
    MOV R6, #(DIG_1_MASK | DIG_3_MASK | DIG_4_MASK)
    STR R6,[R4,#(DIG_GPIO << 2)] //Habilito digito

    //obtengo el valor de la decena
    MOV R4,#10
    UDIV R5, R2, R4              //obtengo la decena
    LDR R9, [R7,R5]                 //obtengo el digito en display
    STRB R9,[R8,#(SEG_GPIO << 2)]   //PRENDO SEGMENTO

    LDR R5,=GPIO_SET0
    LDR R8,=GPIO_PIN0

    //cargo valor de segmentos para digito dos
    STRB R9,[R8,#(SEG_GPIO << 2)]
    //habilito digito dos
    LDR R6, =DIG_2_MASK
    STR R6,[R5,#(DIG_GPIO << 2)]

    B  systick_exit

dig3:
    
    MOV R6, #(DIG_1_MASK | DIG_2_MASK | DIG_4_MASK) //deshabilito digito 1 2 y 4
    STR R6,[R4,#(DIG_GPIO << 2)]

     //obtengo valor de la unidad
    MOV R4,#10
    UDIV R9, R0, R4
    MUL R9,R4
    SUB R5, R0,R9
    LDR R9, [R7,R5]                 //obtengo el digito
    //cargo el valor de los segmentos para el digito uno
    STRB R9,[R8,#(SEG_GPIO << 2)]

    LDR R5,=GPIO_SET0
    LDR R8,=GPIO_PIN0

    //cargo valor de segmentos para digito tres
    STRB R9,[R8,#(SEG_GPIO << 2)]
    //habilito digito dos
    LDR R6, =DIG_3_MASK
    STR R6,[R5,#(DIG_GPIO << 2)]

    B  systick_exit

dig4:
    CMP R1,#1
    BNE systick_exit

    //deshabilito digito uno
    MOV R6, #(DIG_1_MASK | DIG_2_MASK | DIG_3_MASK)
    STR R6,[R4,#(DIG_GPIO << 2)]

    //obtengo el valor de los minutos decena
    MOV R4,#10
    UDIV R5, R0, R4              //obtengo la decena
    LDR R9, [R7,R5]                 //obtengo el digito en display
    STRB R9,[R8,#(SEG_GPIO << 2)]

    LDR R5,=GPIO_SET0
    LDR R8,=GPIO_PIN0

    //cargo valor de segmentos para digito dos
    STRB R9,[R8,#(SEG_GPIO << 2)]
    //habilito digito dos
    LDR R6, =DIG_4_MASK
    STR R6,[R5,#(DIG_GPIO << 2)]

    B  systick_exit
    .endfunc

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

/*****************************************************************************/
/* Rutina para decrementar de 99 a 0                                                          
/*****************************************************************************/
    .func decrementar
decrementar:
    PUSH  {R0,R1,R2}
    LDR   R0,=contador
    LDRH  R1,[R0]
    LDRH  R2,= #0
    CMP   R1,R2
    ITE   EQ
    MOVEQ R1,#99
    subNE R1,#1
    STRH  R1,[R0]
    POP  {R0,R1,R2}
    BX    LR
    .endfunc

/****************************************************************************/
/* Rutina detener                                                           */
/* Esta rutina  pone un cero en la bandera para indicar que se detenga      */
/****************************************************************************/
    .func detener
detener:
    PUSH  {R0,R1}
    LDR  R0,=bandera
    MOV R1,#0
    STRB R1,[R0]
    POP   {R0,R1}
    BX    LR
    .endfunc
 /*****************************************************************************/
 /* Rutina comenzar                                                           */
 /* Esta rutina  pone un uno en la bandera para indicar que arranque la cuenta*/
 /* y habilita el systick                                                     */
 /*****************************************************************************/
    .func comenzar
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
    .endfunc
/*****************************************************************************/
/* Rutina resetear                                                           */
/* Esta rutina  pone un 0 en la variable contador                            */
/*****************************************************************************/
    .func resetear
resetear:
    PUSH  {R0,R1}
    LDR   R1,=SYST_CVR
    MOV   R0,#1
    STR   R0,[R1]             // Limpia COUNTER y flag COUNT

    LDR R0,=contador
    MOV R1,#0
    STRH R1,[R0]
    POP   {R0,R1}
    BX    LR
    .endfunc
    .pool

tabla:  .byte 0x3F,0x06,0x5B,0x4F,0x66
        .byte 0x6D,0x7D,0x07,0x7F,0x6F

