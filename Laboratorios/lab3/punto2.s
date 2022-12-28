    .cpu cortex-m4 // Indica el procesador de destino
    .syntax unified // Habilita las instrucciones Thumb-2
    .thumb // Usar instrucciones Thumb y no ARM
   
    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"

/**************************/
/* Definiciones de macros */
/**************************/

// Recursos utilizados por el canal Rojo del led RGB
    // Numero de puerto de entrada/salida utilizado en el Led Rojo
    .equ LED_R_PORT, 2
    // Numero de terminal dentro del puerto de e/s utilizado en el Led Rojo
    .equ LED_R_PIN, 0
    // Numero de bit GPIO utilizado en el Led Rojo
    .equ LED_R_BIT, 0
    // Mascara de 32 bits con un 1 en el bit correspondiente al Led Rojo
    .equ LED_R_MASK, (1 << LED_R_BIT)

// Recursos utilizados por el canal Verde del led RGB
    .equ LED_G_PORT, 2
    .equ LED_G_PIN, 1
    .equ LED_G_BIT, 1
    .equ LED_G_MASK, (1 << LED_G_BIT)

// Recursos utilizados por el canal Azul del led RGB
    .equ LED_B_PORT, 2
    .equ LED_B_PIN, 2
    .equ LED_B_BIT, 2       //0010
    .equ LED_B_MASK, (1 << LED_B_BIT)// 0000 0000 0000 0010

// Recursos utilizados por el led RGB
    // Numero de puerto GPIO utilizado por los todos leds
    .equ LED_GPIO, 5
    // Desplazamiento para acceder a los registros GPIO de los leds
    .equ LED_OFFSET, ( 4 * LED_GPIO )
    // Mascara de 32 bits con un 1 en los bits correspondiente a cada led
    .equ LED_MASK, ( LED_R_MASK | LED_G_MASK | LED_B_MASK )

// -------------------------------------------------------------------------

// Recursos utilizados por el led 1
    .equ LED_1_PORT, 2
    .equ LED_1_PIN, 10
    .equ LED_1_BIT, 14
    .equ LED_1_MASK, (1 << LED_1_BIT)
    .equ LED_1_GPIO, 0
    .equ LED_1_OFFSET, ( LED_1_GPIO << 2)

// Recursos utilizados por el led 2
    .equ LED_2_PORT, 2
    .equ LED_2_PIN, 11
    .equ LED_2_BIT, 11
    .equ LED_2_MASK, (1 << LED_2_BIT)

// Recursos utilizados por el led 3
    .equ LED_3_PORT, 2
    .equ LED_3_PIN, 12
    .equ LED_3_BIT, 12
    .equ LED_3_MASK, (1 << LED_3_BIT)

// Recursos utilizados por los leds 2 y 3
    .equ LED_N_GPIO, 1
    .equ LED_N_OFFSET, ( LED_N_GPIO << 2)
    .equ LED_N_MASK, ( LED_2_MASK | LED_3_MASK )

    // -------------------------------------------------------------------------
// Recursos utilizados por la primera tecla
    .equ TEC_1_PORT, 1
    .equ TEC_1_PIN, 0
    .equ TEC_1_BIT, 4
    .equ TEC_1_MASK, (1 << TEC_1_BIT)

// Recursos utilizados por la segunda tecla
    .equ TEC_2_PORT, 1
    .equ TEC_2_PIN, 1
    .equ TEC_2_BIT, 8
    .equ TEC_2_MASK, (1 << TEC_2_BIT)
   
// Recursos utilizados por la tercera tecla
    .equ TEC_3_PORT, 1
    .equ TEC_3_PIN, 2
    .equ TEC_3_BIT, 9
    .equ TEC_3_MASK, (1 << TEC_3_BIT)

// Recursos utilizados por el teclado
    .equ TEC_GPIO, 0
    .equ TEC_OFFSET, ( TEC_GPIO << 2)
    .equ TEC_MASK, ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK )

// CONFIGURACION DEL PONCHO

// Recursos utilizados por el BOTON 1
    // Numero de puerto de entrada/salida utilizado en el boton1
    .equ BOTON1_PORT, 4
    // Numero de terminal dentro del puerto de e/s utilizado en el boton1
    .equ BOTON1_PIN, 8
    // Numero de bit GPIO utilizado en el boton1
    .equ BOTON1_BIT, 12
    // Mascara de 32 bits con un 1 en el bit correspondiente al boton1
    .equ BOTON1_MASK, (1 << BOTON1_BIT)

// Recursos utilizados por el BOTON 2
    .equ BOTON2_PORT, 4
    .equ BOTON2_PIN, 9
    .equ BOTON2_BIT, 13
    .equ BOTON2_MASK, (1 << BOTON2_BIT)

// Recursos utilizados por el BOTON 3
    .equ BOTON3_PORT, 4
    .equ BOTON3_PIN, 10
    .equ BOTON3_BIT, 14
    .equ BOTON3_MASK, (1 << BOTON3_BIT)

// Recursos utilizados por el BOTON 1
    .equ BOTON4_PORT, 6
    .equ BOTON4_PIN, 7
    .equ BOTON4_BIT, 15
    .equ BOTON4_MASK, (1 << BOTON4_BIT)

// Recursos utilizados por el teclado
    .equ BOTON_GPIO, 0
    .equ BOTON_OFFSET, ( BOTON_GPIO << 2)
    .equ BOTON_MASK, ( BOTON1_MASK | BOTON2_MASK | BOTON3_MASK | BOTON3_MASK )

//CONFIGURACION DE LOS DISPLAY DEL PONCHO

// Recursos utilizados por el SEGMENTO A
    // Numero de puerto de entrada/salida utilizado en el SegmentoA
    .equ SEGA_PORT, 4
    // Numero de terminal dentro del puerto de e/s utilizado en el SegmentoA
    .equ SEGA_PIN, 0
    // Numero de bit GPIO utilizado en el SegmentoA
    .equ SEGA_BIT, 0
    // Mascara de 32 bits con un 1 en el bit correspondiente al SegmentoA
    .equ SEGA_MASK, (1 << SEGA_BIT)

// Recursos utilizados por el SEGMENTO B
    .equ SEGB_PORT, 4
    .equ SEGB_PIN, 1
    .equ SEGB_BIT, 1
    .equ SEGB_MASK, (1 << SEGB_BIT)

// Recursos utilizados por el SEGMENTO C
    .equ SEGC_PORT, 4
    .equ SEGC_PIN, 2
    .equ SEGC_BIT, 2
    .equ SEGC_MASK, (1 << SEGC_BIT)

// Recursos utilizados por el teclado
    .equ SEG_GPIO, 2
    .equ SEG_OFFSET, (SEG_GPIO << 2)
    .equ SEG_MASK, ( SEGA_MASK | SEGB_MASK | SEGC_MASK)

// Configuracion para saber cual display usare
// Recursos utilizados por el DIGITO1
    // Numero de puerto de entrada/salida utilizado en el display1
    .equ DIGITO1_PORT, 0
    // Numero de terminal dentro del puerto de e/s utilizado en el dsiplay1
    .equ DIGITO1_PIN, 0
    // Numero de bit GPIO utilizado en el display1
    .equ DIGITO1_BIT, 0
    // Mascara de 32 bits con un 1 en el bit correspondiente al display1
    .equ DIGITO1_MASK, (1 << DIGITO1_BIT)

// Recursos utilizados por el DIGITO2
    .equ DIGITO2_PORT, 0
    .equ DIGITO2_PIN, 1
    .equ DIGITO2_BIT, 1
    .equ DIGITO2_MASK, (1 << DIGITO2_BIT)

// Recursos utilizados por el DIGITO3
    .equ DIGITO3_PORT, 1
    .equ DIGITO3_PIN, 15
    .equ DIGITO3_BIT, 2
    .equ DIGITO3_MASK, (1 << DIGITO3_BIT)

// Recursos utilizados por el DIGITO4
    .equ DIGITO4_PORT, 1
    .equ DIGITO4_PIN, 17
    .equ DIGITO4_BIT, 3
    .equ DIGITO4_MASK, (1 << DIGITO4_BIT)

// Recursos utilizados por el DISPLAY
    .equ DIGITO_GPIO, 0
    .equ DIGITO_OFFSET, (DIGITO_GPIO << 2)
    .equ DIGITO_MASK, ( DIGITO1_MASK | DIGITO2_MASK | DIGITO3_MASK | DIGITO4_MASK )


/**************************/
/* Vector de interrupciones */
/**************************/

.section .isr // Define una seccion especial para el vector
    .word stack     // 0: Initial stack pointer value
    .word reset+1   // 1: Initial program counter value
    .word handler+1 // 2: Non mascarable interrupt service routine
    .word handler+1 // 3: Hard fault system trap service routine
    .word handler+1 // 4: Memory manager system trap service routine
    .word handler+1 // 5: Bus fault system trap service routine
    .word handler+1 // 6: Usage fault system tram service routine
    .word 0 // 7: Reserved entry
    .word 0 // 8: Reserved entry
    .word 0 // 9: Reserved entry
    .word 0 // 10: Reserved entry
    .word handler+1 // 11: System service call trap service routine
    .word 0 // 12: Reserved entry
    .word 0 // 13: Reserved entry
    .word handler+1 // 14: Pending service system trap service routine
    .word systick_isr+1 // 15: System tick service routine
    .word handler+1 // 16: Interrupt IRQ service routine


/**************************/
/* Definicion de variables globales */
/**************************/

.section .data // Define la seccion de variables (RAM)
espera:
.zero 1 // Variable compartida con el tiempo de espera

/**************************/
/* Programa principal */
/**************************/
    .global reset // Define el punto de entrada del codigo
    .section .text // Define la seccion de codigo (FLASH)
    .func main // Inidica al depurador el inicio de una funcion
reset:
    // Mueve el vector de interrupciones al principio de la segunda RAM
    LDR R1,=VTOR
    LDR R0,=#0x10080000
    STR R0,[R1]
    
    // Llama a una subrutina para configurar el systick
    BL systick_init
    
    // Configura los pines de los leds rgb como gpio sin pull-up
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(4 * (32 * LED_R_PORT + LED_R_PIN))]
    STR R0,[R1,#(4 * (32 * LED_G_PORT + LED_G_PIN))]
    STR R0,[R1,#(4 * (32 * LED_B_PORT + LED_B_PIN))]

    // Se configuran los pines de los leds 1 al 3 como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(LED_1_PORT << 7 | LED_1_PIN << 2)]
    STR R0,[R1,#(LED_2_PORT << 7 | LED_2_PIN << 2)]
    STR R0,[R1,#(LED_3_PORT << 7 | LED_3_PIN << 2)]

    
    // Configura los pines de las teclas como gpio con pull-up
    MOV R0,#(SCU_MODE_PULLDOWN | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#((TEC_1_PORT << 5 | TEC_1_PIN) << 2)]
    STR R0,[R1,#((TEC_2_PORT << 5 | TEC_2_PIN) << 2)]
    STR R0,[R1,#((TEC_3_PORT << 5 | TEC_3_PIN) << 2)]
    
    // Se configuran los pines de los digitos del display como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(DIGITO1_PORT << 7 | DIGITO1_PIN << 2)]
    STR R0,[R1,#(DIGITO2_PORT << 7 | DIGITO2_PIN << 2)]
    STR R0,[R1,#(DIGITO3_PORT << 7 | DIGITO3_PIN << 2)]
    STR R0,[R1,#(DIGITO4_PORT << 7 | DIGITO4_PIN << 2)]

    // Configura los pines de las teclas como gpio con pull-up ~~~~  PONCHO  ~~~
    MOV R0,#(SCU_MODE_PULLDOWN | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#((BOTON1_PORT << 5 | BOTON1_PIN) << 2)]
    STR R0,[R1,#((BOTON2_PORT << 5 | BOTON2_PIN) << 2)]
    STR R0,[R1,#((BOTON3_PORT << 5 | BOTON3_PIN) << 2)]
    STR R0,[R1,#((BOTON4_PORT << 5 | BOTON4_PIN) << 2)]

    // Se configuran los pines de los DISPLAY como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(SEGA_PORT << 7 | SEGA_PIN << 2)]
    STR R0,[R1,#(SEGB_PORT << 7 | SEGB_PIN << 2)]
    STR R0,[R1,#(SEGC_PORT << 7 | SEGC_PIN << 2)]

    // Apaga todos los bits gpio de los segmentos
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#SEG_OFFSET]

    //Apago los digitos
    LDR R0,=DIGITO_MASK
    STR R0,[R1,#DIGITO_OFFSET]

    // Configura los bits gpio de los segmentos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#SEG_OFFSET]
    ORR R0,#SEG_MASK
    STR R0,[R1,#SEG_OFFSET]

    // Configura los bits gpio de los DIGITOS como salidas
    LDR R0,[R1,#DIGITO_OFFSET]
    ORR R0,#DIGITO1_MASK
    STR R0,[R1,#DIGITO_OFFSET]

    LDR R0,[R1,#DIGITO_OFFSET]
    ORR R0,#DIGITO2_MASK
    STR R0,[R1,#DIGITO_OFFSET]

    LDR R0,[R1,#DIGITO_OFFSET]
    ORR R0,#DIGITO3_MASK
    STR R0,[R1,#DIGITO_OFFSET]
    
    LDR R0,[R1,#DIGITO_OFFSET]
    ORR R0,#DIGITO4_MASK
    STR R0,[R1,#DIGITO_OFFSET]
    
    // Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0
    LDR R5,=GPIO_NOT0
    
refrescar:
    // Define el estado actual de los SEGMENTOS como todos apagados
    MOV R3,#0x00
    // Carga el estado arctual de las teclas
    LDR R0,[R4,#BOTON_OFFSET]
    // Verifica el estado del bit correspondiente a la BOTON1 uno
    TST R0,#BOTON1_MASK
    // Si la tecla esta apretada
    IT EQ
    // Enciende el bit del SEGMENTOA
    ORREQ R3,#LED_1_MASK

    // Prende el canal SEGMENTO B Y C si la tecla dos esta apretada
    TST R0,#BOTON2_MASK
    IT EQ
    ORREQ R3,#LED_2_MASK

    
    // Prende el canal azul si la tecla tres esta apretada
    TST R0,#BOTON3_MASK
    IT EQ
    ORREQ R3,#LED_B_MASK

    // Actualiza las salidas con el estado definido para los leds
    STR R3,[R4,#LED_OFFSET]
    // Repite el lazo de refresco indefinidamente
    B refrescar
    stop:
    B stop
    .pool // Almacenar las constantes de codigo
    .endfunc


/****************************/
/* Rutina de inicializacion del SysTick */
/****************************/
    .func systick_init
systick_init:
    
    CPSID I // Se deshabilitan globalmente las interrupciones
    
    // Se sonfigura prioridad de la interrupcion, SHPR3 es registro del NVIC
    LDR R1,=SHPR3 // Se apunta al registro de prioridades
    LDR R0,[R1] // Se cargan las prioridades actuales
    MOV R2,#2 // Se fija la prioridad en 2

    //La prioridad esta en los bits mas significativos, usando los 3 bits    
    BFI R0,R2,#29,#3 // Se inserta el valor en el campo
    STR R0,[R1] // Se actualizan las prioridades
    
    // Se habilita el SysTick con el reloj del nucleo
    // SYST_CSR, SYST_RVR, SYST_CVR Son registros del systick

    LDR R1,=SYST_CSR    //Apunto al registro CONTROL y ESTADO.
    MOV R0,#0x00  // Desactivamos las interrupciones
    STR R0,[R1] // Se quita el bit ENABLE
    
    // Se configura el desborde para un periodo de 100 ms
    LDR R1,=SYST_RVR
    LDR R0,=#(48000000 - 1) // deberia ser 4800000 menos 1, pero ejecuta 10 veces menos
    STR R0,[R1] // Se especifica el valor de RELOAD
    
    // Se inicializa el valor actual del contador
    LDR R1,=SYST_CVR
    MOV R0,#0
    
    // Escribir cualquier valor limpia el contador
    STR R0,[R1] // Se limpia COUNTER y flag COUNT
    
    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR    //Apunto al registro CONTROL y ESTADO.
    MOV R0,#0x07    //0000 0111
    STR R0,[R1] // Se fijan ENABLE, TICKINT y CLOCK_SRC
    
    CPSIE I // Se habilitan globalmente las interrupciones

    BX LR // Se retorna al programa principal
    .pool // Se almacenan las constantes de codigo
    .endfunc


/****************************/
/* Rutina de servicio para la interrupcion del SysTick */
/****************************/

// SYSTICK NO HAY INTERRUPCIONES
    
    .func systick_isr
systick_isr:
    
    LDR R0,=espera // Se apunta R0 a la variable espera
    LDRB R1,[R0] // Se carga el valor de la variable espera
    SUBS R1,#1 // Se decrementa el valor de espera
    BHI systick_exit // Si Espera > 0 entonces NO pasaron 10 veces
    
    LDR R1,=GPIO_NOT0 // Se apunta a la base de registros NOT
    MOV R0,#LED_1_MASK // Se carga la mascara para el LED 1
    STR R0,[R1,#LED_1_OFFSET] // Se invierte el bit GPIO del LED 1
    MOV R1,#10 // Se recarga la espera con 10 iteraciones
    
systick_exit:
    STRB R1,[R0] // Se actualiza la variable espera
    BX LR // Se retorna al programa principal
    
    .pool // Se almacenan las constantes de codigo
    .endfunc



/****************************/
/* Rutina de servicio generica para excepciones */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa. */
/* Se declara como una medida de seguridad para evitar que el procesador */
/* se pierda cuando hay una excepcion no prevista por el programador */
/****************************/

//PARPADEA EL LED ROJO EN EL LED 1
    .func handler
handler:
    
    LDR R1,=GPIO_SET0 // Se apunta a la base de registros SET
    MOV R0,#LED_1_MASK // Se carga la mascara para el LED 1
    STR R0,[R1,#LED_1_OFFSET] // Se activa el bit GPIO del LED 1
    B handler // Lazo infinito para detener la ejecucion
    
    .pool // Se almacenan las constantes de codigo
    .endfunc
