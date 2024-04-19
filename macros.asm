limpiarConsola MACRO
    MOV AX, 03h
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
