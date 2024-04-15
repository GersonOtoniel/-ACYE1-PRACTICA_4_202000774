INCLUDE "MACROS.ASM"


.MODEL small

.STACK 100h

.DATA
    num1 db '$hola'
    num3 db 'hola2$'

    menu1 db 10,13,'+-+-+-+-+-+-+-+-+-+-+-+-+-+-+'
    menu2 db 10,13,'|M|E|N|U| |P|R|I|N|C|I|P|A|L|'
    menu3 db 10,13,'+-+-+-+-+-+-+-+-+-+-+-+-+-+-+'
    menu4 db 10,13,'-----------------------------'
    menu5 db 10,13,'+-+-+-+-+-+-+-+-+-+-+-+-+-+-+'
    menu6 db 10,13,'|1.| |N|u|e|v|o| |J|u|e|g|o|'
    menu7 db 10,13,'|2.| |A|n|i|m|a|c|i|o|n|'
    menu8 db 10,13,'|3.| |I|n|f|o|r|m|a|c|i|o|n|'
    menu9 db 10,13,'|4.| |S|a|l|i|r|'
    menu0 db 10,13,'+-+-+-+-+-+-+-+-+-+-+-+-+-+-+$'
    ;menu7 db '$',00h

    num2 db 0
    SaltoCadena dw ? 

.CODE

    MOV AX, @data
    MOV DS, AX
    MAIN PROC
        limpiarConsola
        imprimirMensajes menu1
        
        terminarPrograma

    MAIN ENDP    

END