 // ESTE PROGRAMA AUMENTA EN 1 CUANDO TOCAS EL BOTON DE LA DERECHA Y DISMINUYE 
 //CUANDO TOCAS EL SEGUNDO BOTON VA DE 0 HASTA 9
 
    .cpu cortex-m4          // Indica el procesador de destino
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s" //da acceso a rutinas para prender y apagar los leds
    .include "configuraciones/rutinas.s"

/****************************************************************************/
/* Definiciones de macros                                                   */
/****************************************************************************/

// Recursos utilizados para prender los digitos
    //D1= DIGITO1
    .equ ENABLE_D1_PORT,    0
    .equ ENABLE_D1_PIN,     0
    .equ ENABLE_D1_BIT,     0
    .equ ENABLE_D1_MASK,    (1 << ENABLE_D1_BIT)
    //D2= DIGITO2
    .equ ENABLE_D2_PORT,    0
    .equ ENABLE_D2_PIN,     1
    .equ ENABLE_D2_BIT,     1
    .equ ENABLE_D2_MASK,    (1 << ENABLE_D2_BIT)
    //D3= DIGITO3
    .equ ENABLE_D3_PORT,    1
    .equ ENABLE_D3_PIN,     15
    .equ ENABLE_D3_BIT,     2
    .equ ENABLE_D3_MASK,    (1 << ENABLE_D3_BIT)
    //D4= DIGITO4
    .equ ENABLE_D4_PORT,    1
    .equ ENABLE_D4_PIN,     17
    .equ ENABLE_D4_BIT,     3
    .equ ENABLE_D4_MASK,    (1 << ENABLE_D4_BIT)
    //ENCIENDO LOS DIGITOS EN LA GPIO 0
    .equ ENABLE_D_MASK,       (ENABLE_D1_MASK | ENABLE_D2_MASK | ENABLE_D3_MASK | ENABLE_D4_MASK)
    .equ ENABLE_D_GPIO,      0

// Recursos utilizados para el segmento A
    .equ A_PORT,    4
    .equ A_PIN,     0
    .equ A_BIT,     0
    .equ A_MASK,    (1 << A_BIT)

// Recursos utilizados para el segmento B
    .equ B_PORT,    4
    .equ B_PIN,     1
    .equ B_BIT,     1
    .equ B_MASK,    (1 << B_BIT)

// Recursos utilizados para el segmento C
     .equ C_PORT,    4
     .equ C_PIN,     2
     .equ C_BIT,     2
     .equ C_MASK,    (1 << C_BIT)

// Recursos utilizados para el segmento D
     .equ D_PORT,    4
     .equ D_PIN,     3
     .equ D_BIT,     3
     .equ D_MASK,    (1 << D_BIT)

// Recursos utilizados para el segmento E
    .equ E_PORT,    4
    .equ E_PIN,     4
    .equ E_BIT,     4
    .equ E_MASK,    (1 << E_BIT)

// Recursos utilizados para el segmento F
    .equ F_PORT,    4
    .equ F_PIN,     5
    .equ F_BIT,     5
    .equ F_MASK,    (1 << F_BIT)

// Recursos utilizados para el segmento G
     .equ G_PORT,    4
     .equ G_PIN,     6
     .equ G_BIT,     6
     .equ G_MASK,    (1 << G_BIT)

// Recursos utilizados para el segmento DP
     .equ DP_PORT,    6
     .equ DP_PIN,     8
     .equ DP_BIT,     16

     .equ DP_MASK,    (1 << DP_BIT)
     .equ DP_GPIO,      5

// Recursos utilizados para encender los segmentos en la GPIO 2
    .equ SEGM_GPIO,      2
    .equ SEGM_MASK,      (A_MASK |B_MASK |C_MASK |D_MASK |E_MASK |F_MASK |G_MASK | DP_MASK)

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

// Recursos utilizados por el teclado
    .equ TEC_GPIO,      5
    .equ TEC_MASK,      ( TEC_1_MASK | TEC_2_MASK)

/****************************************************************************/
/* Definicion de variables globales                                         */
/****************************************************************************/

    .section .data          // Define la sección de variables (RAM)
CONTADOR: .zero 1                 // Variable compartida con el tiempo de espera

tabla: .byte 0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F


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
// Configura los pines de los segmentos y digito como gpio sin pull-up
    LDR R1,=SCU_BASE    //apunto al registro
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)//cargo la mascara
    STR R0,[R1,#(A_PORT << 7 | A_PIN << 2)]	// genera el desplazamiento del SPSPX automaticamente es lo mismo q hacerlo manuelanmebte
    STR R0,[R1,#(B_PORT << 7 | B_PIN << 2)]
    STR R0,[R1,#(C_PORT << 7 | C_PIN << 2)]
    STR R0,[R1,#(D_PORT << 7 | D_PIN << 2)]
    STR R0,[R1,#(E_PORT << 7 | E_PIN << 2)]
    STR R0,[R1,#(F_PORT << 7 | F_PIN << 2)]
    STR R0,[R1,#(G_PORT << 7 | G_PIN << 2)]
    STR R0,[R1,#(ENABLE_D1_PORT << 7 | ENABLE_D1_PIN << 2)] // genera el desplazamiento del SPSPX automaticamente es lo mismo q hacerlo manuelanmebte
    STR R0,[R1,#(ENABLE_D2_PORT << 7 | ENABLE_D2_PIN << 2)]
    STR R0,[R1,#(ENABLE_D3_PORT << 7 | ENABLE_D3_PIN << 2)]
    STR R0,[R1,#(ENABLE_D4_PORT << 7 | ENABLE_D4_PIN << 2)]

//Configuro el DP aparte  ya que su funcion es distinta
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)//cargo la mascara
    STR R0,[R1,#(DP_PORT << 7 | DP_PIN << 2)]

// Configura los pines de las teclas como gpio con pull-up
    MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(TEC_1_PORT << 7 | TEC_1_PIN << 2)]
    STR R0,[R1,#(TEC_2_PORT << 7 | TEC_2_PIN << 2)]

// Apaga todos los display, led y dp
    LDR R1,=GPIO_CLR0 // pongo 0 en los puertos gpio
    LDR R0,=SEGM_MASK
    STR R0,[R1,#(SEGM_GPIO << 2)] // apago todos los segmentos
    LDR R0,=ENABLE_D_MASK
    STR R0,[R1,#(ENABLE_D_GPIO << 2)] //apago los digitos
    LDR R0,=DP_MASK
    STR R0,[R1,#(DP_GPIO << 2)]  //apago dp

// Configura los bits gpio de los leds como salidas
    LDR R1,=GPIO_DIR0

    LDR R0,[R1,#(SEGM_GPIO << 2)]
    LDR R2,=SEGM_MASK
    ORR R0,R2
    STR R0,[R1,#(SEGM_GPIO << 2)]

// Configura los bits gpio de los digitos como salidas
    LDR R0,[R1,#(ENABLE_D_GPIO << 2)]
    LDR R2,=ENABLE_D1_MASK
    ORR R0,R2
    STR R0,[R1,#(ENABLE_D_GPIO << 2)]

    LDR R0,[R1,#(ENABLE_D_GPIO << 2)]
    ORR R0,#ENABLE_D2_MASK
    STR R0,[R1,#(ENABLE_D_GPIO << 2)]

    LDR R0,[R1,#(ENABLE_D_GPIO << 2)]
    ORR R0,#ENABLE_D3_MASK
    STR R0,[R1,#(ENABLE_D_GPIO << 2)]

    LDR R0,[R1,#(ENABLE_D_GPIO << 2)]
    ORR R0,#ENABLE_D4_MASK
    STR R0,[R1,#(ENABLE_D_GPIO << 2)]

// Configura los bits gpio del dp como salidas
    LDR R0,[R1,#(DP_GPIO << 2)]
    ORR R0,#DP_MASK
    STR R0,[R1,#(DP_GPIO << 2)]

// Configura los bits gpio de los botones como entradas
    LDR R1,=GPIO_DIR5
    LDR R0,[R1,#(TEC_GPIO << 2)]
    AND R0,#TEC_MASK                        
    STR R0,[R1,#(TEC_GPIO << 2)]

    LDR R4,=GPIO_SET0
    MOV R2,#1
    STR R2,[R4]


// Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0 // 5 tecla(bit 16 DP), 2 leds,0 enable

//Defino los registros para determinar si se apreto o no la tecla
    MOV R5,#0 //para comparar con la tecla 1
    MOV R6,#0 //para comparar con la tecla 2

refrescar:
// Carga el estado actual de las teclas
    LDR   R0,[R4,#(TEC_GPIO << 2)]

// Verifica SI LA TECLA1 ESTA APRETADO
    AND  R1,R0,#(1 << TEC_1_BIT)  
    MVN R5,R5   //niega todos los bits, los pone en 1
    ANDS R5,R1  //si todos son 1 se activara el flag
    IT NE  //si z=0(el resultado es dist de cero)
    BLNE aumento                         
    MOV R5,R1

// Verifica SI LA TECLA2 ESTA APRETADO
    AND  R1,R0,#(1 << TEC_2_BIT)
    MVN R6,R6
    ANDS R6,R1
    IT NE
    BLNE disminuyo
    MOV R6,R1

    PUSH {R5,R6}
// Actualiza las salidas

    LDR R5,=GPIO_CLR0
    LDR R1,=SEGM_MASK
    STR R1,[R5,#(SEGM_GPIO << 2)]
    LDR R10,=GPIO_SET2
    LDR R5,=tabla
    LDR R8,=CONTADOR
    LDRB R8,[R8]
    LDRB R11,[R5,R8]
    STR R11,[R10]

    POP {R5}   
 
    LDR R6,=GPIO_CLR0
    LDR R0,=SEGM_MASK
    STR R0,[R6,#(SEGM_GPIO << 2)]
    LDR R7,=GPIO_SET2
    LDR R6,=tabla
    LDR R8,=CONTADOR
    LDRB R8,[R8]
    LDRB R9,[R6,R8]
    STR R9,[R7]
    POP {R6}

    B     refrescar

stop:
    B stop


/********************************************************
******      Rutina para aumentar una unidad
*********************************************************/

aumento:
        PUSH {R7,R8}
        LDR R7,=CONTADOR
        LDRB R8,[R7]
        ADD R8,#1
        CMP R8,#10
        IT EQ
        MOVEQ R8,#0
        STRB R8,[R7]
        POP {R7,R8}
        BX LR
/********************************************************
******      Rutina para disminuir una unidad
*********************************************************/

disminuyo:
        PUSH {R7,R8}
        LDR R7,=CONTADOR
        LDRB R8,[R7]
        SUB R8,#1
        CMP R8,#-1
        IT EQ
        MOVEQ R8,#9
        STRB R8,[R7]
        POP {R7,R8}
        BX LR
