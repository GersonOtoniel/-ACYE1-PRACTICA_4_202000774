.MODEL small

.STACK 64h

.DATA

    msg1 db "Hola Iniciando Modo Video...", "$"
    msg2 db "Ha Terminado Modo Video...", "$"

.CODE
    MOV AX, @data
    MOV DS, AX
    MOV ES, AX

    MOV AX, 03h ; Definimos el modo video AH = 0h | AL = 03h
    INT 10h

    Main PROC
        MOV AH, 09h     ; Imprimir Mensaje En Pantalla
        LEA DX, msg1 
        INT 21h
        
        MOV AH, 86h     ; Aplicar Un Delay
        MOV CX, 25
        INT 15h
        
        MOV AL, 13h     ; Cambiar A Modo Video
        MOV AH, 00H
        INT 10h 

        ; Pintar 50 Pixeles De Un Color
        MOV BL, 50      ; BL -> Contador 50 iteraciones
        MOV AL, 0Ch     ; Color codigo C (se puede usar un numero entre 0 y 255)
        MOV CX, 10      ; Empiecen en la columna 10
        MOV DX, 20      ; Empiece en la fila 20
        MOV AH, 0Ch     ; Codigo De la Interrupcion

        Ciclo:
            INT 10h
            
            INC CX
            DEC BL
            CMP BL, 0
            JNE Ciclo

        

        Salir:
            MOV AX, 4C00h            ; Terminamos El Programa
            INT 21h
    Main ENDP
END