.cpu cortex-m4          // Indica el procesador de destino  
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"
    
/****************************************************************************/
/* Definiciones de macros                                                   */
/****************************************************************************/
// Recursos utilizados por el primer segmento
    .equ SA_PORT,	4
    .equ SA_PIN,	0
    .equ SA_BIT,	0
    .equ SA_MASK,	(1 << SA_BIT)

	// Recursos utilizados por el segundo segmento
    .equ SB_PORT,	4
    .equ SB_PIN,	1
    .equ SB_BIT,	1
    .equ SB_MASK,	(1 << SB_BIT)

	// Recursos utilizados por el tercer segmento
    .equ SC_PORT,	4
    .equ SC_PIN,	2
    .equ SC_BIT,	2
    .equ SC_MASK,	(1 << SC_BIT)

	// Recursos utilizados por el cuatro segmento
    .equ SD_PORT,	4
    .equ SD_PIN,	3
    .equ SD_BIT,	3
    .equ SD_MASK,	(1 << SD_BIT)

	// Recursos utilizados por el quint segmento
    .equ SE_PORT,	4
    .equ SE_PIN,	4
    .equ SE_BIT,	4
    .equ SE_MASK,	(1 << SE_BIT)

	// Recursos utilizados por el sexto segmento
    .equ SF_PORT,	4
    .equ SF_PIN,	5
    .equ SF_BIT,	5
    .equ SF_MASK,	(1 << SF_BIT)

	// Recursos utilizados por el septimo segmento
    .equ SG_PORT,	4
    .equ SG_PIN,	6
    .equ SG_BIT,	6
    .equ SG_MASK,	(1 << SG_BIT)

	// Recursos utilizados por los segmentos en general
    .equ SEG_GPIO,	2
    .equ SEG_MASK,	( SA_MASK | SB_MASK | SC_MASK | SD_MASK | SE_MASK | SF_MASK | SG_MASK )



	// Recursos utilizados por el primer digito
    .equ D1_PORT,	0
    .equ D1_PIN,	0
    .equ D1_BIT,	0
    .equ D1_MASK,	(1 << D1_BIT)

	// Recursos utilizados por el segundo digito
    .equ D2_PORT,	0
    .equ D2_PIN,	1
    .equ D2_BIT,	1
    .equ D2_MASK,	(1 << D2_BIT)

	// Recursos utilizados por el tercer digito
    .equ D3_PORT,	1
    .equ D3_PIN,	15
    .equ D3_BIT,	2
    .equ D3_MASK,	(1 << D3_BIT)

	// Recursos utilizados por el cuatro digito
    .equ D4_PORT,	1
    .equ D4_PIN,	17
    .equ D4_BIT,	3
    .equ D4_MASK,	(1 << D4_BIT)

	// Recursos utilizados por los digitos en general
    .equ DIG_GPIO,	0
    .equ DIG_MASK,	( D1_MASK | D2_MASK | D3_MASK | D4_MASK)

	// Recursos utilizados por la primera tecla de funcion
    .equ B1_PORT,	4
    .equ B1_PIN,	8
    .equ B1_BIT,	12
    .equ B1_MASK,	(1 << B1_BIT)

	// Recursos utilizados por la segunda tecla de funcion
    .equ B2_PORT,	14
    .equ B2_PIN,	9
    .equ B2_BIT,	13
    .equ B2_MASK,	(1 << B2_BIT)

	// Recursos utilizados por la tercera tecla de funcion
    .equ B3_PORT,	4
    .equ B3_PIN,	10
    .equ B3_BIT,	14
    .equ B3_MASK,	(1 << B3_BIT)

    .equ BOT_GPIO,	5
    .equ BOT_MASK,	( B1_MASK | B2_MASK | B3_MASK)



    .equ TEC1, (BOT_GPIO << 5 | B1_BIT)
    .equ TEC2, (BOT_GPIO << 5 | B2_BIT)
    .equ TEC3, (BOT_GPIO << 5 | B3_BIT)
/****************************************************************************/
/* Vector de interrupciones                                                 */
/****************************************************************************/

/**
 * Vector de interrupciones
 */
    .section .isr
    .word   stack           //  0: Initial stack pointer value
    .word   reset+1         //  1: Initial program counter value: Program entry point
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
    .word   handler+1       // 16: IRQ 0: DAC service routine
    .word   handler+1       // 17: IRQ 1: M0APP service routine
    .word   handler+1       // 18: IRQ 2: DMA service routine
    .word   0               // 19: Reserved entry
    .word   handler+1       // 20: IRQ 4: FLASHEEPROM service routine
    .word   handler+1       // 21: IRQ 5: ETHERNET service routine
    .word   handler+1       // 22: IRQ 6: SDIO service routine
    .word   handler+1       // 23: IRQ 7: LCD service routine
    .word   handler+1       // 24: IRQ 8: USB0 service routine
    .word   handler+1       // 25: IRQ 9: USB1 service routine
    .word   handler+1       // 26: IRQ 10: SCT service routine
    .word   handler+1       // 27: IRQ 11: RTIMER service routine
    .word   handler+1       // 28: IRQ 12: TIMER0 service routine
    .word   handler+1       // 29: IRQ 13: TIMER1 service routine
    .word   handler+1       // 30: IRQ 14: TIMER2 service routine
    .word   handler+1       // 31: IRQ 15: TIMER3 service routine
    .word   handler+1       // 32: IRQ 16: MCPWM service routine
    .word   handler+1       // 33: IRQ 17: ADC0 service routine
    .word   handler+1       // 34: IRQ 18: I2C0 service routine
    .word   handler+1       // 35: IRQ 19: I2C1 service routine
    .word   handler+1       // 36: IRQ 20: SPI service routine
    .word   handler+1       // 37: IRQ 21: ADC1 service routine
    .word   handler+1       // 38: IRQ 22: SSP0 service routine
    .word   handler+1       // 39: IRQ 23: SSP1 service routine
    .word   handler+1       // 40: IRQ 24: USART0 service routine
    .word   handler+1       // 41: IRQ 25: UART1 service routine
    .word   handler+1       // 42: IRQ 26: USART2 service routine
    .word   handler+1       // 43: IRQ 27: USART3 service routine
    .word   handler+1       // 44: IRQ 28: I2S0 service routine
    .word   handler+1       // 45: IRQ 29: I2S1 service routine
    .word   handler+1       // 46: IRQ 30: SPIFI service routine
    .word   handler+1       // 47: IRQ 31: SGPIO service routine
    .word   gpio_isr+1      // 48: IRQ 32: PIN_INT0 service routine
    .word   gpio_isr+1      // 49: IRQ 33: PIN_INT1 service routine
    .word   gpio_isr+1      // 50: IRQ 34: PIN_INT2 service routine
    .word   gpio_isr+1      // 51: IRQ 35: PIN_INT3 service routine
    .word   handler+1       // 52: IRQ 36: PIN_INT4 service routine
    .word   handler+1       // 53: IRQ 37: PIN_INT5 service routine
    .word   handler+1       // 54: IRQ 38: PIN_INT6 service routine
    .word   handler+1       // 55: IRQ 39: PIN_INT7 service routine
    .word   handler+1       // 56: IRQ 40: GINT0 service routine
    .word   handler+1       // 56: IRQ 40: GINT1 service routine


/****************************************************************************/
/* Definicion de variables globales                                         */
/****************************************************************************/

    .section .data          // Define la sección de variables (RAM)
espera:                     
    .zero 1                 // Variable compartida con el tiempo de espera

/****************************************************************************/
/* Programa principal                                                       */
/****************************************************************************/

    .global reset           // Define el punto de entrada del código
    .section .text          // Define la sección de código (FLASH)
    .func main              // Inidica al depurador el inicio de una funcion
reset:
    CPSID I                 // Deshabilita interrupciones

    // Mueve el vector de interrupciones al principio de la segunda RAM
    LDR R1,=VTOR
    LDR R0,=#0x10080000
    STR R0,[R1]

    // Llama a una subrutina existente en flash para configurar los leds
    LDR R1,=leds_init
    BLX R1

    // Llama a una subrutina para configurar el systick
    BL systick_init

   LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(SA_PORT << 7 | SA_PIN << 2)]
    STR R0,[R1,#(SB_PORT << 7 | SB_PIN << 2)]
    STR R0,[R1,#(SC_PORT << 7 | SC_PIN << 2)]
    STR R0,[R1,#(SD_PORT << 7 | SD_PIN << 2)]
    STR R0,[R1,#(SE_PORT << 7 | SE_PIN << 2)]
    STR R0,[R1,#(SF_PORT << 7 | SF_PIN << 2)]
    STR R0,[R1,#(SG_PORT << 7 | SG_PIN << 2)]

    // Configuración de los pines de digitos como gpio sin pull-up
    STR R0,[R1,#(D1_PORT << 7 | D1_PIN << 2)]
    STR R0,[R1,#(D2_PORT << 7 | D2_PIN << 2)]
    STR R0,[R1,#(D3_PORT << 7 | D3_PIN << 2)]
    STR R0,[R1,#(D4_PORT << 7 | D4_PIN << 2)]

    // Configuración de los pines de teclas como gpio con pull-up
    MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(B1_PORT << 7 | B1_PIN << 2)]
    STR R0,[R1,#(B2_PORT << 7 | B2_PIN << 2)]
    STR R0,[R1,#(B3_PORT << 7 | B3_PIN << 2)]
    
    

    // Selecciono las tres teclas como fuente de interrupcion
    LDR R0,=( TEC3 << 16 | TEC2 << 8 | TEC1 << 0)
    STR R0,[R1,#PINTSEL0]

    // Apagado de todos los bits gpio de los segmentos
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#(SEG_GPIO << 2)]

    // Apagado de todos bits gpio de los digitos
    LDR R0,=DIG_MASK
    STR R0,[R1,#(DIG_GPIO << 2)]

    // Configuración de los bits gpio de segmentos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#(SEG_GPIO << 2)]
    ORR R0,#SEG_MASK
    STR R0,[R1,#(SEG_GPIO << 2)]

    // Configuración de los bits gpio de digitos como salidas
    LDR R0,[R1,#(SEG_GPIO << 2)]
    ORR R0,#DIG_MASK
    STR R0,[R1,#(DIG_GPIO << 2)]

    // Configuración los bits gpio de botones como entradas
    LDR R0,[R1,#(BOT_GPIO << 2)]
    AND R0,#~BOT_MASK
    STR R0,[R1,#(BOT_GPIO << 2)]

    // Configuro los pines para operacion por flancos
    LDR R4,=PINT_BASE
    MOV R0,#0x00
    STR R0,[R4,#ISEL]   //habilita las interrupciones por flanco ISEL=0
    
    MOV R0,#0x0F        
    STR R0,[R4,#SIENR]
    /*
    MOV R0,#0xFF
    STR R0,[R4,#CIENF]  //habilita todos los bits con interrupcion por flanco ascendente
    STR R0,[R4,#CIENR]  //Inhabilita flanco ascendente en todos los bits
    MOV R0,#0x03        
    STR R0,[R4,#SIENR]
    MOV R0,#0x05
    STR R0,[R4,#SIENF]
    */
    // Borro los pedidos pendientes de interrupciones del GPIO
    MOV R0,#0xFF
    STR R0,[R4,#IST]

    LDR R1,=NVIC_ICPR1
    MOV R0,0x0F
    STR R0,[R1]

    // Habilito los pedidos de interrupciones del GPIO en el NVIC
    LDR R1,=NVIC_ISER1
    MOV R0,0x0F
    STR R0,[R1]

    CPSIE I                 // Rehabilita interrupciones 


// Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0
    LDR R5,=GPIO_NOT0
 // Prendido de todos bits gpio de los digitos
    LDR R0,=0x0F
    STR R0,[R4]


refrescar:
   

    // lee el estado actual de los segmentos 
    LDR   R3,[R4,#(SEG_GPIO << 2)]
    // Carga el estado arctual de las teclas
    LDR   R0,[R4,#(BOT_GPIO << 2)]

    // Verifica el estado del bit correspondiente a la tecla uno
    ANDS  R1,R0,#(1 << B1_BIT)
    // Si la tecla esta apretada
    IT    EQ
    // Enciende el bit del segmento B
    ORREQ R3,#(1 << SB_BIT)

    // Prende el segmento C si la tecla 3 esta apretada
    ANDS  R1,R0,#(1 << B3_BIT)
    IT    EQ
    ORREQ R3,#(1 << SC_BIT)

    // Prende el segmento G si la tecla tres esta apretada
    ANDS  R1,R0,#(1 << B3_BIT)
    ITT   EQ
        ORREQ R3,#(1 << SB_BIT)
        ORREQ R3,#(1 << SC_BIT)


    // Actualiza las salidas con el estado definido para los segmentos
    STR   R3,[R4,#(SEG_GPIO << 2)]

    
    B refrescar
stop:
    B stop

    .pool                   // Almacenar las constantes de código

    .endfunc    

/****************************************************************************/
/* Rutina de inicialización del SysTick                                     */
/****************************************************************************/
    .func systick_init
systick_init: 
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
    LDR R0,=#(4800000 - 1)
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

    BX  LR                  // Retorna al programa principal
    .pool                   // Almacena las constantes de código
    .endfunc

/****************************************************************************/
/* Rutina de servicio para la interrupcion del GPIO                         */
/****************************************************************************/
.func gpio_isr
gpio_isr:
    // Leo el registro con la causa de interupción y borro los eventos
    LDR R1,=PINT_BASE
    LDR R0,[R1,#IST]
    STR R0,[R1,#IST]
    
    // Verifico si la causa de interupcion es el primer boton
    TST R0, #0x01
    ITE NE
    LDRNE R0,=toggle_led_1
    LDREQ R0,=toggle_led_2

    // Llamo a la rutina correspondiente
    PUSH {LR}
    BLX  R0
    POP  {LR}

    BX   LR             // Retorna al programa principal
    .pool
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
    LDR  R0,=toggle_led_3
    BLX  R0                 // Llama a la subrutina para destellar led
    POP  {R0,LR}            // Recupera los registros conservados
    MOV  R1,#10             // Vuelvo a carga espera con 10 iterciones
systick_exit:
    STRB R1,[R0]            // Actualiza la variable espera
    BX   LR                 // Retorna al programa principal
    .pool                   // Almacena las constantes de código
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