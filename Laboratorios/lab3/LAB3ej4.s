/* Copyright 2016-2020, Laboratorio de Microprocesadores 
 * Facultad de Ciencias Exactas y Tecnología 
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * Copyright 2016-2020, Esteban Volentini <evolentini@herrera.unt.edu.ar>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

    .cpu cortex-m4          // Indica el procesador de destino
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"
    

/****************************************************************************/
/* Definiciones de macros                                                   */
/****************************************************************************/
.equ LED_R_PORT,    2

// Numero de terminal dentro del puerto de e/s utilizado en el Led Rojo
.equ LED_R_PIN,     0
// Numero de bit GPIO utilizado en el Led Rojo
.equ LED_R_BIT,     0
// Mascara de 32 bits con un 1 en el bit correspondiente al Led Rojo
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
// Numero de puerto GPIO utilizado por los todos leds
.equ LED_GPIO,      5
// Desplazamiento para acceder a los registros GPIO de los leds
.equ LED_OFFSET,    ( 4*LED_GPIO )
// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
.equ LED_MASK,      ( LED_R_MASK | LED_G_MASK | LED_B_MASK )
// -------------------------------------------------------------------------// Recursos utilizados por el led 1
.equ LED_1_PORT,    2
.equ LED_1_PIN,     10
.equ LED_1_BIT,     14
.equ LED_1_MASK,    (1 << LED_1_BIT)
.equ LED_1_GPIO,    0
.equ LED_1_OFFSET,  ( LED_1_GPIO << 2)
// Recursos utilizados por el led 2
.equ LED_2_PORT,    2
.equ LED_2_PIN,     11
.equ LED_2_BIT,     11
.equ LED_2_MASK,    (1 << LED_2_BIT)
// Recursos utilizados por el led 3
.equ LED_3_PORT,    2
.equ LED_3_PIN,     12
.equ LED_3_BIT,     12
.equ LED_3_MASK,    (1 << LED_3_BIT)
// Recursos utilizados por los leds 2 y 3
.equ LED_N_GPIO,    1
.equ LED_N_OFFSET,  ( LED_N_GPIO << 2)
.equ LED_N_MASK,    ( LED_2_MASK | LED_3_MASK )
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

// Recursos utilizados por la tecla aceptar
    .equ TEC_A_PORT,    3
    .equ TEC_A_PIN,     1
    .equ TEC_A_BIT,     8
    .equ TEC_A_MASK,    (1 << TEC_A_BIT)

// Recursos utilizados por la tecla cancelar
    .equ TEC_C_PORT,    3
    .equ TEC_C_PIN,     2
    .equ TEC_C_BIT,     9
    .equ TEC_C_MASK,    (1 << TEC_C_BIT)

// Recursos utilizados por el teclado
    .equ TEC_N_GPIO,      5
    .equ TEC_N_OFFSET,    ( TEC_N_GPIO << 2)
    .equ TEC_N_MASK,      ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK | TEC_4_MASK | TEC_A_MASK | TEC_C_MASK) 

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
    .equ DIG_4_PIN,     16
    .equ DIG_4_BIT,     3
    .equ DIG_4_MASK,    (1 << DIG_4_BIT)

// Recursos utilizados por los display
    .equ DIG_N_GPIO,      0
    .equ DIG_N_OFFSET,    ( DIG_N_GPIO << 2)
    .equ DIG_N_MASK,      ( DIG_1_MASK | DIG_2_MASK | DIG_3_MASK | DIG_4_MASK)

// Recursos utilizados por el segmento A
    .equ SEG_A_PORT,    4
    .equ SEG_A_PIN,     0
    .equ SEG_A_BIT,     0
    .equ SEG_A_MASK,    (1 << SEG_A_BIT)

// Recursos utilizados por el segmento B
    .equ SEG_B_PORT,    4
    .equ SEG_B_PIN,     1
    .equ SEG_B_BIT,     1
    .equ SEG_B_MASK,    (1 << SEG_B_BIT)

// Recursos utilizados por el segmento C
    .equ SEG_C_PORT,    4
    .equ SEG_C_PIN,     2
    .equ SEG_C_BIT,     2
    .equ SEG_C_MASK,    (1 << SEG_C_BIT)

// Recursos utilizados por el segmento D
    .equ SEG_D_PORT,    4
    .equ SEG_D_PIN,     3
    .equ SEG_D_BIT,     3
    .equ SEG_D_MASK,    (1 << SEG_D_BIT)

// Recursos utilizados por el segmento E
    .equ SEG_E_PORT,    4
    .equ SEG_E_PIN,     4
    .equ SEG_E_BIT,     4
    .equ SEG_E_MASK,    (1 << SEG_E_BIT)

// Recursos utilizados por el segmento F
    .equ SEG_F_PORT,    4
    .equ SEG_F_PIN,     5
    .equ SEG_F_BIT,     5
    .equ SEG_F_MASK,    (1 << SEG_F_BIT)

// Recursos utilizados por el segmento G
    .equ SEG_G_PORT,    4
    .equ SEG_G_PIN,     6
    .equ SEG_G_BIT,     6
    .equ SEG_G_MASK,    (1 << SEG_G_BIT)

// Recursos utilizados por el segmento DP
    .equ SEG_DP_PORT,    6
    .equ SEG_DP_PIN,     8
    .equ SEG_DP_BIT,     16
    .equ SEG_DP_MASK,    (1 << SEG_DP_BIT)

// Recursos utilizados por los segmentos
    .equ SEG_N_GPIO,      2
    .equ SEG_N_OFFSET,    ( SEG_N_GPIO << 2)
    .equ SEG_N_MASK,      ( SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK)

// Recursos utilizados por el segmento DP
    .equ SEG_N1_GPIO,      5
    .equ SEG_N1_OFFSET,    ( SEG_N1_GPIO << 2)
    .equ SEG_N1_MASK,      ( SEG_DP_MASK )

 
    .equ REP0, (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK)                    //SEGMENTO 0
    .equ REP1, (SEG_B_MASK | SEG_C_MASK)                                                                        //SEGMENTO 1
    .equ REP2, (SEG_A_MASK | SEG_B_MASK | SEG_D_MASK | SEG_E_MASK | SEG_G_MASK)                                 //SEGMENTO 2
    .equ REP3, (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_G_MASK)                                 //SEGMENTO 3
    .equ REP4, (SEG_B_MASK | SEG_C_MASK | SEG_F_MASK | SEG_G_MASK)                                              //SEGMENTO 4
    .equ REP5, (SEG_A_MASK | SEG_C_MASK | SEG_D_MASK | SEG_F_MASK | SEG_G_MASK)                                 //SEGMENTO 5
    .equ REP6, (SEG_A_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK)                    //SEGMENTO 6
    .equ REP7, (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK)                                                           //SEGMENTO 7
    .equ REP8, (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK)       //SEGMENTO 8
    .equ REP9, (SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_F_MASK | SEG_G_MASK)                    //SEGMENTO 9

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
    divisor:
            .hword 0x3E8 //1000 milisegundos
    
    segundos:
            .byte 0x00          
            .byte 0x00          
    hora:
            .byte 0x00
            .byte 0x00
            .byte 0x09
            .byte 0x01
    pause:
            .byte 0x00

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

    LDR R1,=SCU_BASE

    // Configura los pines de las teclas como gpio con pull-up
    MOV R0,#(SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#((TEC_1_PORT << 5 | TEC_1_PIN) << 2)]
    STR R0,[R1,#((TEC_2_PORT << 5 | TEC_2_PIN) << 2)]
    STR R0,[R1,#((TEC_3_PORT << 5 | TEC_3_PIN) << 2)]
    STR R0,[R1,#((TEC_4_PORT << 5 | TEC_4_PIN) << 2)]
    STR R0,[R1,#((TEC_A_PORT << 5 | TEC_A_PIN) << 2)]
    STR R0,[R1,#((TEC_C_PORT << 5 | TEC_C_PIN) << 2)]

    // Configura los pines de los digitos como gpio 
    MOV R0,#(SCU_MODE_INBUFF_EN | SCU_MODE_INACT | SCU_MODE_FUNC0)
    STR R0,[R1,#((DIG_1_PORT << 5 | DIG_1_PIN) << 2)]
    STR R0,[R1,#((DIG_2_PORT << 5 | DIG_2_PIN) << 2)]
    STR R0,[R1,#((DIG_3_PORT << 5 | DIG_3_PIN) << 2)]
    STR R0,[R1,#((DIG_4_PORT << 5 | DIG_4_PIN) << 2)]

    // Configura los pines de los segmentos como gpio 
    MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_INACT | SCU_MODE_FUNC0)
    STR R0,[R1,#((SEG_A_PORT << 5 | SEG_A_PIN) << 2)]
    STR R0,[R1,#((SEG_B_PORT << 5 | SEG_B_PIN) << 2)]
    STR R0,[R1,#((SEG_C_PORT << 5 | SEG_C_PIN) << 2)]
    STR R0,[R1,#((SEG_D_PORT << 5 | SEG_D_PIN) << 2)]
    STR R0,[R1,#((SEG_E_PORT << 5 | SEG_E_PIN) << 2)]
    STR R0,[R1,#((SEG_F_PORT << 5 | SEG_F_PIN) << 2)]
    STR R0,[R1,#((SEG_G_PORT << 5 | SEG_G_PIN) << 2)]
    STR R0,[R1,#((SEG_DP_PORT << 5 | SEG_DP_PIN) << 2)]


    //Apago todos los bits gpio de los segmentos
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_N_MASK
    STR R0,[R1,#SEG_N_OFFSET]

    //Apago todos los bits gpio de los digitos
    LDR R1,=GPIO_CLR0
    LDR R0,=DIG_N_MASK
    STR R0,[R1,#DIG_N_OFFSET]

    //Se configuran los bits gpio de los segmentos como como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#SEG_N_OFFSET]
    ORR R0,#SEG_N_MASK
    STR R0,[R1,#SEG_N_OFFSET]

    //Se configura el bit gpio del segmento DP como como salida
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#SEG_N1_OFFSET]
    ORR R0,#SEG_N1_MASK
    STR R0,[R1,#SEG_N1_OFFSET]

    //Se configuran los bits gpio de los digitos como salidas
    LDR R0,[R1,#DIG_N_OFFSET]
    ORR R0,#DIG_N_MASK
    STR R0,[R1,#DIG_N_OFFSET]

    // Configura los bits gpio de los botones como entradas
    LDR R0,[R1,#TEC_N_OFFSET]
    BIC R0,#TEC_N_MASK
    STR R0,[R1,#TEC_N_OFFSET]

    // Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0
    LDR R5,=GPIO_NOT0

    
refrescar:
    

    MOV R7,#0
    STR   R7,[R4,#DIG_N_OFFSET]
    LDR R8,=tabla
    LDR R9,=segundos

    LDR   R0,[R4,#TEC_N_OFFSET]
    TST R0,#TEC_C_MASK              // Si la tecla esta apretada
    ITT NE
    // Enciende el segmento B
    MOVNE R3,#0
    STRNE R3,[R9]

    LDR   R0,[R4,#TEC_N_OFFSET]
    TST R0,#TEC_A_MASK              // Si la tecla esta apretada
    IT NE
    // Enciende el segmento B
    BLNE INIPAU

    LDRB R10,[R9],#1
    LDRB R10,[R8,R10] 
    STR   R10,[R4,#SEG_N_OFFSET]
    ORR R7,#DIG_1_MASK
    STR   R7,[R4,#DIG_N_OFFSET]
    BL delay

    LDRB R10,[R9]
    LDRB R10,[R8,R10]
    MOV R7,#0
    STR   R7,[R4,#DIG_N_OFFSET]
    
    ORR R7,#DIG_2_MASK
    STR   R10,[R4,#SEG_N_OFFSET]
    STR   R7,[R4,#DIG_N_OFFSET]
    BL delay
    LDR R9,=hora
    LDRB R10,[R9],#1
    LDRB R10,[R8,R10]
    MOV R7,#0
    STR   R7,[R4,#DIG_N_OFFSET]
    
    ORR R7,#DIG_3_MASK
    STR   R10,[R4,#SEG_N_OFFSET]
    STR   R7,[R4,#DIG_N_OFFSET]
    BL delay

    
    LDRB R10,[R9]
    LDRB R10,[R8,R10]
    MOV R7,#0
    STR   R7,[R4,#DIG_N_OFFSET]
    
    ORR R7,#DIG_4_MASK
    STR   R10,[R4,#SEG_N_OFFSET]
    STR   R7,[R4,#DIG_N_OFFSET]
    BL delay
    B     refrescar
stop:
    B stop
    .pool                   // Almacenar las constantes de código
    .endfunc

/************************************************************************************/
/* Rutina de inicialización del SysTick                                             */
/************************************************************************************/
.func systick_init
systick_init:
    CPSID I                     // Se deshabilitan globalmente las interrupciones

    // Se sonfigura prioridad de la interrupcion
    LDR R1,=SHPR3               // Se apunta al registro de prioridades
    LDR R0,[R1]                 // Se cargan las prioridades actuales
    MOV R2,#2                   // Se fija la prioridad en 2
    BFI R0,R2,#29,#3            // Se inserta el valor en el campo
    STR R0,[R1]                 // Se actualizan las prioridades

    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x00
    STR R0,[R1]                 // Se quita el bit ENABLE

    // Se configura el desborde para un periodo de 100 ms
    LDR R1,=SYST_RVR
    LDR R0,=#(480000 - 1)
    STR R0,[R1]                 // Se especifica el valor de RELOAD

    // Se inicializa el valor actual del contador
    LDR R1,=SYST_CVR
    MOV R0,#0
    // Escribir cualquier valor limpia el contador
    STR R0,[R1]                 // Se limpia COUNTER y flag COUNT

    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x07
    STR R0,[R1]                 // Se fijan ENABLE, TICKINT y CLOCK_SRC

    CPSIE I                     // Se habilitan globalmente las interrupciones
    BX  LR                      // Se retorna al programa principal
    .pool                       // Se almacenan las constantes de código
.endfunc

/************************************************************************************/
/* Rutina de servicio para la interrupcion del SysTick                              */
/************************************************************************************/
    .func systick_isr
systick_isr:
    LDR  R0,=pause
    LDRB R0,[R0]
    CMP R0,#0
    IT EQ
    BEQ salto
    LDR  R0,=divisor             // Se apunta R0 a la variable divisor
    LDRB R1,[R0]                // Se carga el valor de la variable divisor
    SUBS R1,#1                  // Se decrementa el valor de divisor
    BHI  systick_exit           // Si Espera > 0 entonces NO paso un segundo
    MOV  R1,0x3E8                // Se recarga la espera con 10 iteraciones
    STRB R1,[R0]
    MOV R0,0x01
    LDR R1,=segundos
    PUSH {R0,LR}
    BL incrementar
    LDR R1,=hora
    CMP R0,0x01
    IT EQ
    BLEQ incrementar
    POP {R0,LR}
    
systick_exit:
    STRB R1,[R0]                // Se actualiza la variable espera
salto:
    BX   LR                     // Se retorna al programa principal
    .pool                       // Se almacenan las constantes de codigo
    .endfunc
 .func incrementar
        incrementar:
            PUSH {R4,R5}
            LDRB R4,[R1]
            ADD R4,R4,#1
            LDRB R5,[R1,#1]!
            CMP R4,0x09
            ITT HI
            MOVHI R4,0x00
            ADDHI R5,R5,#1
            CMP R5,0x05
            ITTTE HI
            MOVHI R4,0x00
            MOVHI R5,0x00
            MOVHI R0,0x01
            MOVLS R0,0x00
            STRB R5,[R1],#-1
            STRB R4,[R1]
            POP {R4,R5}
            BX LR
    .endfunc     
/************************************************************************************/
/* Rutina de servicio generica para excepciones                                     */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa.          */
/* Se declara como una medida de seguridad para evitar que el procesador            */
/* se pierda cuando hay una excepcion no prevista por el programador                */
/************************************************************************************/
    .func handler
handler:
    LDR R1,=GPIO_SET0           // Se apunta a la base de registros SET
    MOV R0,#LED_1_MASK          // Se carga la mascara para el LED 1
    STR R0,[R1,#LED_1_OFFSET]   // Se activa el bit GPIO del LED 1
    B handler                   // Lazo infinito para detener la ejecucion
    .pool                       // Se almacenan las constantes de codigo
    .endfunc

.func delay
delay:
PUSH {R4,R5,LR}
MOV R5,#0
repetir:
ADD R5,#1
MOV R4,#0
BL delaySegundo
CMP R5,#250
IT NE
BNE repetir

POP {R4,R5,LR}
BX LR

delaySegundo:
    ADD R4,#1
    CMP R4,#250
    IT EQ
    BXEQ LR
    B delaySegundo
.endfunc

tabla:
.byte REP0,REP1,REP2,REP3,REP4
.byte REP5,REP6,REP7,REP8,REP9

.func INIPAU
INIPAU:
PUSH {R4,R5,R6,R7}
LDR R4,=pause
LDRB R5,[R4]
CMP R5,#0
ITE EQ
MOVEQ R6,#1
MOVNE R6,#0
 
STRB R6,[R4]
POP {R4,R5,R6,R7}
BX LR
.endfunc

