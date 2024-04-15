    limpiarConsola MACRO
        MOV AX, 03h
        INT 10h
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

    imprimirColorCadena MACRO fila, columna, pagina, longitud, cadena, color
        MOV AL, 1          
        MOV BH, pagina      
        MOV BL, color     
        MOV CX, longitud  
        MOV DL, columna    
        MOV DH, fila       
        MOV BP, cadena      
        MOV AH, 13h
        INT 10h
    ENDM