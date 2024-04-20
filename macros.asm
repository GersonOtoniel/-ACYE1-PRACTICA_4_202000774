limpiarConsola MACRO
    MOV AX, 03h
    INT 10h
ENDM

regresarModoTexto MACRO
    MOV AX, 03
    INT 10h
ENDM

regresarControl MACRO
    MOV AL, 0
    MOV AH, 04Ch
    INT 21h
ENDM

modoVideo MACRO
    MOV AL,13h
    MOV AH,00h
    INT 10h
ENDM


Print MACRO registro
    LEA DX, registro
    MOV AH, 09h
    INT 21h
ENDM

imprimirMensajes MACRO print
    MOV AH, 09h
    LEA DX, print
    INT 21h
ENDM

terminarPrograma MACRO
    MOV AH, 4CH
    INT 21h
ENDM

imprimirCaracter MACRO caracter
    mov ah,02h
    mov dl,caracter
    int 21h
ENDM

tomarEntrada MACRO opcion
    MOV AH, 01h
    INT 21h

    MOV opcion, AL
ENDM

convertirLetraNumero MACRO letra
    SUB letra, 'a'
    SUB letra, 1
    INC letra
ENDM

convertirNumero MACRO numero
    SUB numero, '1'
ENDM

convertirNumero2 MACRO numero6
    ADD numero6,48
ENDM

CrearArchivo MACRO nombreArchivo, handler
    LOCAL ManejarError, FinCrearArchivo
    MOV AH, 3Ch ; Codigo interrupcion
    MOV CX, 00h ; Atributo del archivo
    LEA DX, nombreArchivo ; Nombre del archivo
    INT 21h

    MOV handler, AX ; capturar el handler asignado al archivo (16 bits)
    RCL BL, 1
    AND BL, 1
    CMP BL, 1
    JE ManejarError
    JMP FinCrearArchivo

    ManejarError:
        imprimirMensajes salto
        imprimirMensajes errorCrearArchivo
        tomarEntrada opcion

    FinCrearArchivo:
ENDM

EscribirArchivo MACRO cadena, handler
    LOCAL ManejarError, FinEscribirArchivo

    MOV AH, 40h ; Codigo de interrupcion
    MOV BX, handler ; Handler de archivo
    MOV CX, lengthof cadena ; Cantidad de bytes que se van a escribir
    DEC CX
    LEA DX, cadena ; Direccion de la cadena a escribir
    INT 21h

    RCL BL, 1 ; Capturar el bit de CF en el registro BL
    AND BL, 1 ; Validar que en BL quede un 1 o 0
    CMP BL, 1 ; Verificar si no hay codigo de error
    JE ManejarError
    JMP FinEscribirArchivo

    ManejarError:
        imprimirMensajes salto
        imprimirMensajes errorEscribirArchivo
        ;tomarEntrada opcion
    
    FinEscribirArchivo:
ENDM

CerrarArchivo MACRO handler
    LOCAL ManejarError, FinCerrarArchivo

    MOV AH, 3Eh ; Codigo de interrupcion
    MOV BX, handler ; handler del archivo
    INT 21h

    RCL BL, 1
    AND BL, 1
    CMP BL, 1
    JE ManejarError
    JMP FinCerrarArchivo

    ManejarError:
        imprimirMensajes salto
        imprimirMensajes errorCerrarArchivo
        tomarEntrada entrada

    FinCerrarArchivo:
ENDM

AbrirArchivo MACRO nombreArchivo, handler
    LOCAL ManejarError, FinAbrirArchivo
    MOV AH, 3Dh
    MOV AL, 00h
    LEA DX, nombreArchivo
    INT 21h

    MOV handler, AX
    RCL BL, 1
    AND BL, 1
    CMP BL, 1
    JE ManejarError
    JMP FinAbrirArchivo

    ManejarError:
        Print salto
        Print errorAbrirArchivo
        GetOpcion
    
    FinAbrirArchivo:
ENDM

LeerArchivo MACRO buffer, handler
    LOCAL ManejarError, FinLeerArchivo
    MOV AH, 3Fh
    MOV BX, handler
    MOV CX, 40
    LEA DX, buffer
    INT 21h

    RCL BL, 1
    AND BL, 1
    CMP BL, 1
    JE ManejarError
    Print salto
    Print buffer
    GetOpcion
    JMP FinLeerArchivo

    ManejarError:
        Print salto
        Print errorLeerArchivo
        GetOpcion

    FinLeerArchivo:
ENDM


imprimirColorCadena MACRO  cadena, color
    LOCAL comienzo
        MOV SI, offset cadena
        MOV AH,03
        INT 10h

        MOV CX,lengthof cadena
        comienzo:
            MOV AH,09h
            MOV AL,[SI]
            MOV BL,color
            PUSH CX
            MOV CX,0001
            INT 10h
            INC SI
            INC DL
            INC BL
            MOV AH,02
            INT 10h
            POP CX
        LOOP comienzo

ENDM











mCleanScreen macro
    PUSH AX

    MOV AH, 00h
    MOV AL, 03h
    INT 10h

    POP AX
endm

mPrint macro var
    PUSH DX
    PUSH AX
    
    MOV DX, OFFSET var
    MOV AH, 09
    INT 21

    POP AX
    POP DX
endm

pauseUntilEnter macro
    LOCAL until_press_enter
    PUSH AX

    until_press_enter:
        MOV AH,08h
        INT 21h
        CMP AL, 000DH
        JNE until_press_enter
    POP AX
endm

mGetKey macro
    MOV AH,01h
    INT 21h
endm

modoTexto macro
    mov AX, 03
    MOV AH,00
    int 10
endm

mRetControl macro
        MOV AL, 0       ;mensaje de retorno
        MOV AH, 04Ch    ; devuelve el control al sistema
        INT 21
endm

; ----------------------------------------------------------------------------------------

mVideoMode macro
    mov AX, 13
    int 10
endm

mDivLine macro line, color
    PUSH AX

    ; INICIA EN 0 EL CONTADOR
    MOV PIXLINE, line
    MOV PIXCOL, 0

    CALL CALCPIXELLOC   ;SALIDA EN AX
    
    MOV BH, 00
    MOV BL, color
    MOV SQCOLOR, BX
    MOV SQHEIGHT, 4
    MOV SQWIDTH, 140
    CALL DRAWSQUARE

    POP AX
endm

imprimirVideo MACRO row, column, text, chars, color
    ;AH         13h
    ;AL         Subservice (0-3)
    ;BH         Display page number
    ;BL         Attribute (Subservices 0 and 1)
    ;CX         Length of string
    ;DH         Row position where string is to be written
    ;DL         Column position where string is to be written
    ;ES:BP      Pointer to string to write
    mPushRegisters
    CALL PMOVDATATOES

    MOV AH, 13
    MOV AL, 0
    MOV CX, chars
    MOV DH, row
    MOV DL, column
    LEA BX, text
    MOV BP,BX
    MOV BX, color
    INT 10

    CALL PMOVESTOVIDEOMODE
    mPopRegisters
ENDM

mPushRegisters macro
    push ax
    push bx
    push cx
    push dx

    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
endm

mPopRegisters macro
    pop ax
    pop bx
    pop cx
    pop dx
endm

; -----------------------------------------------------------------------------------------
mMoveToVideo macro
    MOV DX, 0A000H
    MOV DS, DX
endm

obtenerCoordenadas macro
    LOCAL enterChar, endproc
    LOCAL validChar, invalidChar, handleBackspace
    XOR DI, DI
    enterChar:
        INC cursorX
        MOV AH, 01
        INT 21h
        CMP AL, 3Bh    ; Comprueba si el carácter es un punto y coma
        JE  validChar   ; Si es igual a ';', salta a validChar
        CMP AL, 0Dh
        JE endproc
        CMP AL, 08     ; Comprueba si el carácter es el retroceso (backspace)
        JE  handleBackspace ; Si es retroceso, salta a handleBackspace
        CMP AL, 48     ; Comprueba si el carácter es un número
        JB  invalidChar ; Si es menor que '0', salta a invalidChar
        CMP AL, 57     ; Comprueba si el carácter es un número
        JA  invalidChar ; Si es mayor que '9', salta a invalidChar
        ; JMP validChar ; Si no es un número ni un punto y coma, salta a invalidChar
    validChar:
        MOV [bufferEntrada + DI], AL
        INC DI
        JMP enterChar
    handleBackspace:
        ; mPrintTextIntoVideo 0E, 00, mensaje_ingresar_coor, 16, 000F
        ; Retrocede el cursor
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dh, cursorY      ; Fila
        mov dl, cursorX      ; Columna anterior
        dec dl          ; Retrocede una columna
        dec dl          ; Retrocede una columna
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor

        ; Borra el carácter anterior en pantalla
        push dx
        mov ah, 02     ; Función de DOS para imprimir un carácter
        mov dl, 32
        ; mov al, 040     ; Carácter de espacio en blanco
        int 21h         ; Llama a la interrupción del BIOS para imprimir un carácter
        pop dx

        ; Retrocede el cursor nuevamente
        DEC cursorX
        DEC cursorX
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dl, cursorX      ; Columna actual
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor

        DEC DI          ; Retrocede el índice en el búfer
        JMP enterChar

    invalidChar:
        ; Retrocede el cursor
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dh, cursorY       ; Fila
        mov dl, cursorX      ; Columna anterior
        dec dl          ; Retrocede una columna
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor
        
        ; Borra el carácter anterior en pantalla
        push dx
        mov ah, 02     ; Función de DOS para imprimir un carácter
        mov dl, al
        ; mov al, 040     ; Carácter de espacio en blanco
        int 21h         ; Llama a la interrupción del BIOS para imprimir un carácter
        pop dx
        
        DEC cursorX
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dl, cursorX     ; Columna actual
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor

        JMP enterChar

    endproc:
        ; INC DI
        ; DEC DI
        MOV AL,00h ;
        MOV [bufferEntrada + DI], AL
endm

mVerficarCoordenadas macro
    PUSH BX
    PUSH AX
    PUSH DX
    PUSH CX
    
    MOV BX, offset bufferEntrada
    ; HACER VALIDACIONES QUE ESTE EN EL RANGO PARA NUMERO
    MOV AL, [BX]
    SUB AL, 31
    MOV AH, AL      ;VALOR DE MI FILA
    MOV ingresarCoordenadaY, AH
    
    INC BX
    MOV AL, [BX] ;ESTE SERIA LA COMA
    
    INC BX
    MOV AL, [BX] ;VALOR DE MI COLUMNA
    SUB AL, 31
    MOV DL, AL
    MOV ingresarCoordenadaX, DL

    POP CX
    POP DX
    POP AX
    POP BX
endm