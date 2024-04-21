dibujarlineas MACRO
        MOV AL, 13h     ; Cambiar A Modo Video
        MOV AH, 00H
        INT 10h 

        MOV AH,0CH
        MOV AL, 02;COLOR
        MOV CX,30;CLUMNAS
        MOV DX,10;FILAS
        PUSH DX
        INT 10H

        COLUMNA:
            POP DX
    
            LINEA:
                INC DX
                INT 10H
                CMP DX,100
                JNE LINEA
            
            INC CX
            CMP CX,35
            JNE COLUMNA

;-------------------------
        MOV AH,0CH
        MOV AL, 03;COLOR
        MOV CX,70;CLUMNAS
        MOV DX,10;FILAS
        PUSH DX
        INT 10H

        COLUMNA2:
            POP DX
            LINEA2:
                INC DX
                INT 10H
                CMP DX,100
                JNE LINEA2
            
            INC CX
            CMP CX,75
            JNE COLUMNA2
;-------------------------------------
        MOV AH,0CH
        MOV AL, 03;COLOR
        MOV CX,5;CLUMNAS
        MOV DX,35;FILAS
        PUSH CX
        INT 10H

        FILA3:
            POP CX
            COLUMNA3:
                INC CX
                INT 10H
                CMP CX,100
                JNE COLUMNA3
            
            INC DX
            CMP DX,40
            JNE FILA3



        MOV AH,0CH
        MOV AL, 03;COLOR
        MOV CX,0;CLUMNAS
        MOV DX,75;FILAS
        PUSH CX
        INT 10H

        FILA4:
            POP CX
            COLUMNA4:
                INC CX
                INT 10H
                CMP CX,100
                JNE COLUMNA4
            
            INC DX
            CMP DX,80
            JNE FILA4            

ENDM

convertirNumero2 MACRO numero6
    ADD numero6,48
ENDM

imprimirCaracter MACRO caracter
    mov ah,02h
    mov dl,caracter
    SUB caracter,'1'
    int 21h
ENDM

mMoveToVideo macro
    MOV DX, 0A000H
    MOV DS, DX
endm

posicion_X MACRO fila,columna
    LOCAL verificar, verificar1,verificar2,verificar3, FILA1,FILA2,COLUMNA1,COLUMNA2,dibujar
    XOR AX,AX
    XOR CX,CX
    XOR SI,SI
    MOV SI, offset fila
    MOV CX, [SI]
    AND CX,03h
    MOV SI, offset columna
    MOV AX,[SI]
    AND AX,03h
    verificar:
        CMP CX,2
        JE FILA1
    verificar1:
        CMP CX,3
        JE FILA2
    verificar2:
        CMP AX,2
        JE COLUMNA1
    verificar3:
        CMP AX,3
        JE COLUMNA2
    
        
        JMP dibujar

        FILA1:
            MOV CX,4
            JMP verificar1

        FILA2:
            MOV CX,7
            JMP verificar2

        COLUMNA1:
            MOV AX,4
            JMP verificar3
    
        COLUMNA2:
            MOV AX,7

    
    dibujar:
        MOV DI, offset barrax_uno
        dibujarotraslineas
        INC AX
        MOV DI, offset barrax_dos
        dibujarotraslineas
        INC CX
        ;INC AX
        MOV DI, OFFSET barrax_uno
        dibujarotraslineas
        DEC AX
        MOV DI, offset barrax_dos
        dibujarotraslineas
ENDM

cambiarVideo MACRO
        MOV AL, 13h  
        MOV AH, 00H
        INT 10h
ENDM

posicion_o MACRO fila, columna
    LOCAL verificar, verificar1,verificar2,verificar3, FILA1,FILA2,COLUMNA1,COLUMNA2,dibujar
    XOR AX,AX
    XOR CX,CX
    XOR SI,SI
    MOV SI, offset fila
    MOV CX, [SI]
    AND CX,03h
    MOV SI, offset columna
    MOV AX,[SI]
    AND AX,03h

    verificar:
        CMP CX,2
        JE FILA1
    verificar1:
        CMP CX,3
        JE FILA2
    verificar2:
        CMP AX,2
        JE COLUMNA1
    verificar3:
        CMP AX,3
        JE COLUMNA2
    
        
        JMP dibujar

        FILA1:
            MOV CX,4
            JMP verificar1

        FILA2:
            MOV CX,7
            JMP verificar2

        COLUMNA1:
            MOV AX,4
            JMP verificar3
    
        COLUMNA2:
            MOV AX,7

    dibujar:
        MOV DI, offset barrao_uno
        dibujarotraslineas
        INC AX
        MOV DI, offset barrao_tres
        dibujarotraslineas
        
        DEC AX
        INC CX
        MOV DI, offset barrao_dos
        dibujarotraslineas
        INC AX
        MOV DI, offset barrao_cuatro
        dibujarotraslineas


ENDM

dibujarotraslineas MACRO
        LOCAL position_screen, end_position_screen, draw_figure_column_screen, draw_figure_row_screen
        PUSH AX ;control de columnas
        PUSH CX ;control de filas

        MOV BX, 0000
        MOV DL, 08
        MUL DL          ; SE MULTIPLICA AX * 8 PARA OBTENER LA COLUMNA EN LA CUAL SE UBICARA
        ADD BX, AX
        XCHG AX, CX     ; INTERCAMBIA POS X = CX y POS Y = AX
        MUL DL
        XCHG AX, CX     ; POS X = BX    POS Y = CX
        position_screen:
            CMP CX, 0001
            JE end_position_screen
            ADD BX, 320    ; BX SE QUEDA CON LA POSICION FINAL DONDE SE COLOCARA EL GRAFICO
            LOOP position_screen
        end_position_screen:
            MOV CX, 008;8 columnas
        draw_figure_row_screen:;seva a ir fila por fila, las 8 filas
            PUSH CX
            MOV CX, 0008;8 filas
        draw_figure_column_screen:;se va a ir columna por columna, las 8 columnas
            MOV AL, [DI]

            PUSH DS

            mMoveToVideo

            MOV [BX], AL
            INC BX
            INC DI

            POP DS
            LOOP draw_figure_column_screen

            POP CX
            SUB BX, 08      ; SE LE RESTA LOS 8 QUE SE AVANZAN EN LAS COLUMNAS
            ADD BX, 320     ; SE LE SUMA LOS 320 PARA AVANZAR A LA SIGUIENTE FILA
            LOOP draw_figure_row_screen
            POP CX
            POP AX
            

endm




.MODEL small

.STACK 64h

.DATA

    msg1 db "Hola Iniciando Modo Video...", "$"
    msg2 db "Ha Terminado Modo Video...", "$"
    X db ?
    Y db ?
    contador db ?
    cox db 9 dup(0)
    coy db 9 dup(0)

    wall_three  db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    barrax_uno      db     01, 01, 00, 00, 00, 00, 00, 00
                    db     00, 01, 01, 00, 00, 00, 00, 00
                    db     00, 00, 01, 01, 00, 00, 00, 00
                    db     00, 00, 00, 01, 01, 00, 00, 00
                    db     00, 00, 00, 00, 01, 01, 00, 00
                    db     00, 00, 00, 00, 00, 01, 01, 00
                    db     00, 00, 00, 00, 00, 00, 01, 01
                    db     00, 00, 00, 00, 00, 00, 00, 01
    barrax_dos      db     00, 00, 00, 00, 00, 00, 01, 01
                    db     00, 00, 00, 00, 00, 01, 01, 00
                    db     00, 00, 00, 00, 01, 01, 00, 00
                    db     00, 00, 00, 01, 01, 00, 00, 00
                    db     00, 00, 01, 01, 00, 00, 00, 00
                    db     00, 01, 01, 00, 00, 00, 00, 00
                    db     01, 01, 00, 00, 00, 00, 00, 00
                    db     01, 00, 00, 00, 00, 00, 00, 00

    barrao_uno      db     00, 00, 00, 00, 00, 00, 01, 01
                    db     00, 00, 00, 00, 00, 01, 01, 00
                    db     00, 00, 00, 01, 01, 01, 00, 00
                    db     00, 00, 01, 01, 01, 00, 00, 00
                    db     00, 00, 01, 01, 00, 00, 00, 00
                    db     00, 01, 01, 00, 00, 00, 00, 00
                    db     01, 01, 00, 00, 00, 00, 00, 00
                    db     01, 00, 00, 00, 00, 00, 00, 00

    barrao_dos      db     01, 01, 00, 00, 00, 00, 00, 00
                    db     01, 01, 00, 00, 00, 00, 00, 00
                    db     01, 01, 01, 00, 00, 00, 00, 00
                    db     00, 00, 01, 01, 00, 00, 00, 00
                    db     00, 00, 01, 01, 01, 00, 00, 00
                    db     00, 00, 00, 01, 01, 01, 01, 01
                    db     00, 00, 00, 00, 00, 01, 01, 01
                    db     00, 00, 00, 00, 00, 01, 01, 01

    barrao_tres     db     01, 01, 01, 00, 00, 00, 00, 00
                    db     00, 01, 01, 01, 00, 00, 00, 00
                    db     00, 00, 01, 01, 01, 00, 00, 00
                    db     00, 00, 00, 01, 01, 01, 00, 00
                    db     00, 00, 00, 00, 01, 01, 00, 00
                    db     00, 00, 00, 00, 00, 01, 01, 00
                    db     00, 00, 00, 00, 00, 00, 01, 01
                    db     00, 00, 00, 00, 00, 00, 00, 01

    barrao_cuatro   db     00, 00, 00, 00, 00, 00, 00, 01
                    db     00, 00, 00, 00, 00, 00, 01, 01
                    db     00, 00, 00, 00, 00, 01, 01, 01
                    db     00, 00, 00, 00, 01, 01, 01, 00
                    db     00, 00, 00, 01, 01, 01, 00, 00
                    db     00, 00, 01, 01, 01, 00, 00, 00
                    db     00, 01, 01, 00, 00, 00, 00, 00
                    db     01, 01, 00, 00, 00, 00, 00, 00
.CODE
    MOV AX, @data
    MOV DS, AX
    MOV ES, AX

    MOV AX, 03h ; Definimos el modo video AH = 0h | AL = 03h
    INT 10h

    Main PROC


        mov cx,8
        ciclo:
            


        mov contador, 48
        imprimirCaracter contador
        ADD contador,1
        imprimirCaracter contador
        ;MOV X, 1
        ;MOV Y,1
        ;cambiarVideo
        ;posicion_o Y,X;posicion 1:1
        ;posicion_X 1,2;posicion 1:2
        ;posicion_X 1,7;posicion 1:3
        ;posicion_X 4,1;posicion 2:1
        ;posicion_X 4,4;posicion 2:2
        ;posicion_X 4,7;posicion 2:3
        ;posicion_X 7,1;posicion 3:1
        ;posicion_X 7,4;posicion 3:2
        ;posicion_X 7,7;posicion 3:3


        

        Salir:
            MOV AX, 4C00h            ; Terminamos El Programa
            INT 21h
    Main ENDP
END