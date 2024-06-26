INCLUDE <MACROS.ASM>

mostrarMenu MACRO
    LOCAL mostrarmenujuego, salir, regresar, nuevoJuego, regresaralMenu, mostrarinfo, modoVideo1, Reportes, salirMacro
    regresaralMenu:
        limpiarConsola
        imprimirMensajes salto
        imprimirColorCadena menu1,02
        imprimirMensajes salto
        imprimirColorCadena menu2,03
        imprimirMensajes salto
        imprimirColorCadena menu3,02
        imprimirMensajes salto
        imprimirColorCadena menu4,03
        imprimirMensajes salto
        imprimirColorCadena menu5,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena menu6,04
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena menu7,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena menu8,04
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena menu9,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena menu0,03
        imprimirMensajes salto
        imprimirMensajes ingreseOpcion
        tomarEntrada opcion

        CMP opcion, 52
        JE salir

        CMP opcion,49
        JE mostrarmenujuego

        CMP opcion,51
        JE mostrarinfo

        mostrarmenujuego:
            JMP nuevoJuego

        mostrarinfo:
            JMP informacion
        salir:
            terminarPrograma

    nuevoJuego:
        limpiarConsola
        imprimirMensajes salto
        imprimirColorCadena nuevoa,03
        imprimirMensajes salto
        imprimirColorCadena nuevob,02
        imprimirMensajes salto
        imprimirColorCadena nuevoc,03
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena nuevod,02
        imprimirMensajes salto
        imprimirColorCadena nuevoe,03
        imprimirMensajes salto
        imprimirColorCadena nuevof,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena nuevog,03
        imprimirMensajes salto
        imprimirColorCadena nuevoh,02
        imprimirMensajes salto
        imprimirColorCadena nuevoi,03
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena nuevoj,02
        imprimirMensajes salto
        imprimirColorCadena nuevok,03
        imprimirMensajes salto
        imprimirColorCadena nuevol,02
        imprimirMensajes salto
        imprimirMensajes ingreseOpcion
        tomarEntrada opcion2

        CMP opcion2,52
        JE regresar

        CMP opcion2,51
        JE Reportes

        CMP opcion2, 50
        JE modoVideo1

        modoVideo1:
            JMP salirMacro

        Reportes:

            

        regresar:
            JMP regresaralMenu

    informacion:
        limpiarConsola
        imprimirColorCadena datosa,02
        imprimirMensajes salto
        imprimirColorCadena datosb,03
        imprimirMensajes salto    
        imprimirColorCadena datosc,02
        imprimirMensajes salto
        imprimirColorCadena datosd,03
        imprimirMensajes salto        
        imprimirColorCadena datose,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosf,0Dh
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosg,0Eh
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosh,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosi,0Eh
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosj,0Dh
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosk,0Eh
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena datosl,02
        imprimirMensajes salto
        imprimirMensajes salto
        imprimirColorCadena regresarInfo,0Dh
        tomarEntrada opcion3

        CMP opcion3, 13
        JE regresar

    salirMacro:
        ;sda
ENDM


imprimirenVideo MACRO fila, columna, texto
    MOV AH, 13h  ; Codigo Interrupcion
    MOV AL, 1    ; 00000011 -> MOV AL, 2 Modo Escritura
    MOV BH, 0    ; Pagina a Utilizar
    MOV BL, 02h  ; Atributos 4 bits altos color black => 0000
                    ; Atributos 4 bits bajos color red => 0100
                    ; MOV BL, 00000100b (Opcion Alterna)
    MOV CX, lengthof texto  ; Cantidad De Caracteres De La Cadena
    MOV DL, columna   ; Columna Donde se va a empezar a escribir
    MOV DH, fila    ; Fila Donde se va a empezar a escribir
    MOV BP, OFFSET texto ; Offset de la segunda cadena 2 en B
    INT 10h  
ENDM

.MODEL small

.STACK 100h

.DATA
    salto db 10,13,'$'
    opcion db ?
    opcion2 db ?
    opcion3 db ?


    reportea db ' ', 95 dup(196),'$'
    reporteb db ' |   Fecha    |   Hora   | Jugador 1   | Jugador 2   |  Resultado  |   Ganador   |   Perdedor  |$' 
    reportec db '|', 12 dup(196),'|', 12 dup(196),'|', 12 dup(196),'|', 12 dup(196),'|', 12 dup(196),'|', 12 dup(196),'|', 12 dup(196),'|','$'


    finReporte db '|_____________________________________________________________________________________________|$'


    menu1 db '       _             _   _          _    _   _','$'
    menu2 db ' |\/| |_ |\ | |  |  |_| |_| | |\ | |  | |_| |_| |'
    menu3 db ' |  | |_ | \| |__|  |   | \ | | \| |_ | |   | | |_'
    menu4 db ' ', 49 dup(196)
    menu5 db ' +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+'
    menu6 db ' |         |1.| N U E V O   J U E G O            |'
    menu7 db ' |         |2.| A N I M A C I O N                |'
    menu8 db ' |         |3.| I N F O R M A C I O N            |'
    menu9 db ' |         |4.| S A L I R                        |'
    menu0 db ' +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+'
    menu77 db '$',00h

    nuevoa db '                   _    _  _     '
    nuevob db '  /|     /|  \  / |_   |  |_| | |'
    nuevoc db '   | o    |   \/   _|  |_ |   |_|'
    nuevod db '  _               _'
    nuevoe db '  _|    /|  \  / |_   /|'
    nuevof db ' |_ o    |   \/   _|   |'
    nuevog db '  _       _   _  _   _   _  ___  _  _ '
    nuevoh db '  _|     |_| |_ |_| | | |_|  |  |_ |_ '
    nuevoi db '  _| o   | \ |_ |   |_| | \  |  |_  _|'
    nuevoj db '          _   _  _   _   _  _   _   _'
    nuevok db ' |_|     |_| |_ | _ |_| |_ |_  |_| |_|' 
    nuevol db '   |o    | \ |_ |_| | \ |_  _| | | | \'
    nuevom db '$',00h

    ingreseOpcion db ' Ingrese opcion >> $s'


    datosa db '  ____   ____   ____   ____   _____   _   ____   ____    _   _'    
    datosb db ' /  __\ /  __\ /  _ \ /   _\ /__ __\ / \ /   _\ /  _ \  | \_| |'
    datosc db ' |  \/| |  \/| | /_\| |  /     | |   | | |  /   | /_\|  |__   |'
    datosd db ' |  __/ |    / | | || |  |__   | |   | | |  |__ | | ||     |  |'
    datose db ' \_/    \_/\_\ \_/ \/ \____/   \_/   \_/ \____/ \_/ \/     |__|'
    datosf db '             UNIVERSIDAD DE SAN CARLOS DE GUATEMALA'
    datosg db '                    FACULTAD DE INGENIERIA'
    datosh db '                 ESCUELA DE CIENCIAS Y SISTEMAS'
    datosi db '          ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 2'
    datosj db '                     PRIMER SEMESTRE 2024'
    datosk db '              Gerson David Otoniel Cox Gonzalez Morales'
    datosl db '                          202000774'
    regresarInfo db 'Para regresar al menu presione Enter>>'


    errorCerrarArchivo db ' Error al cerrar el Archivo','$'
    errorCrearArchivo db "Ocurrio Un Error Al Crear El Archivo", "$"
    errorLeerArchivo db "Ocurrio Un Error Al Leer Archivo", "$"
    errorEscribirArchivo db "Ocurrio Un Error Al Escribir Archivo", "$"
    errorAbrirArchivo db "Ocurrio Un Error Al Abrir Archivo", "$"
    handlerArchivo dw ?



    turno db ?
    Ganador db 00
    celdaInvalida db 00
    ingresarCoordenadaX db 00
    ingresarCoordenadaY db 00
    cursorX db 00
    cursorY db 00
    limpiarFila db 00
    ingresarCoordenadas db 'Ingresar coordenadas x:y >>'
    mensajeCeldaInvalida db 'Esta celda ya esta ocupada'
    mensajeGanador db 'HA GANADO EL JUGADOR $'
    IA db 'IA$'
    JUGADOR db ?
    bufferEntrada db 255 dup('$')
    wallRead db 00
    posXRead dw 00
    posYRead dw 00
    indiceTablero db 00, '$'
    object_map db 09 dup (0)
    ocupadox db 9 dup('$')
    ocupadoy db 9 dup('$')
    limpiar db 26 dup(0)


    empty_block db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
    wall_one    db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_two    db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_three  db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_four   db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
    wall_five   db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_six    db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_ten    db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_eleven db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 01, 01, 01, 01, 01, 01, 01
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
    wall_twelve db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
    wall_fourteen   db     00, 00, 01, 01, 01, 01, 00, 00
                    db     00, 00, 01, 01, 01, 01, 00, 00
                    db     00, 00, 01, 01, 01, 01, 01, 01
                    db     00, 00, 01, 01, 01, 01, 01, 01
                    db     00, 00, 01, 01, 01, 01, 01, 01
                    db     00, 00, 01, 01, 01, 01, 01, 01
                    db     00, 00, 00, 00, 00, 00, 00, 00
                    db     00, 00, 00, 00, 00, 00, 00, 00
    wall_fifteen    db     00, 00, 01, 01, 01, 01, 00, 00
                    db     00, 00, 01, 01, 01, 01, 00, 00
                    db     01, 01, 01, 01, 01, 01, 00, 00
                    db     01, 01, 01, 01, 01, 01, 00, 00
                    db     01, 01, 01, 01, 01, 01, 00, 00
                    db     01, 01, 01, 01, 01, 01, 00, 00
                    db     00, 00, 00, 00, 00, 00, 00, 00
                    db     00, 00, 00, 00, 00, 00, 00, 00    
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

    ;FIGURA O
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
inicio:
    
    
    MAIN PROC
        MOV DX, @data
        MOV DS, DX
        MOV ES,DX

        mostrarMenu

        CMP opcion2,50
        JE Jugar1


        Jugar1:
            ;limpiarConso
            ;imprimirMensajes mensajeGanador
            cambiarVideo
            ;CALL mLimpiar
            CALL crearTablero

            iniciojuego:
                ;CMP Ganador,01
                ;JE imprimirGanador
                imprimirenVideo 13,00, ingresarCoordenadas
                MOV cursorX,27
                MOV cursorY,13
                CALL PMOVERCURSOR
                obtenerCoordenadas
                mVerficarCoordenadas
                CMP turno,01
                JE turnox
                CMP turno,02
                JE turnoo

                turnox:
                    ;PUSH AX
                    ;PUSH CX
                    ;PUSH DX
                    XOR AX, AX
                    MOV AL, ingresarCoordenadaX
                    ;imprimirenVideo 17,00,ingresarCoordenadaX
                    XOR CX, CX
                    MOV CL, ingresarCoordenadaY
                    ;imprimirenVideo 18,00, ingresarCoordenadaY
                    MOV DH, turno
                    ;CALL PPUTFIGURE
                    verificarOcupado ingresarCoordenadaY, ingresarCoordenadaX
                    
                    ;POP DX
                    ;POP CX
                    ;POP AX
                    CMP celdaInvalida, 01
                    JE volver_a_intentar
                    guardarCoordenadas ingresarCoordenadaY, ingresarCoordenadaX
                    imprimirenVideo 0Bh, 00, limpiar,0000
                    ;CALL PDRAWX
                    posicion_X ingresarCoordenadaY, ingresarCoordenadaX
                    imprimirenVideo 20,3,ocupadoy
                    imprimirenVideo 19,3,ocupadox
                    CALL PCLEANLINECURSOR
                    MOV limpiarFila, 0Bh
                    CALL PCLEANANYLINE
                    CALL PCHECKPLAYERWIN
                    MOV turno, 02
                    JMP iniciojuego

                turnoo:
                    ;PUSH AX
                    ;PUSH CX
                    ;PUSH DX
                    XOR AX, AX
                    MOV AL, ingresarCoordenadaX
                    XOR CX, CX
                    MOV CL, ingresarCoordenadaY
                    MOV DH, turno
                    ;CALL PPUTFIGURE
                    ;POP DX
                    ;POP CX
                    ;POP AX
                    verificarOcupado ingresarCoordenadaY, ingresarCoordenadaX
                    
                    CMP celdaInvalida, 01
                    JE volver_a_intentar
                    guardarCoordenadas ingresarCoordenadaY, ingresarCoordenadaX
                    imprimirenVideo 0Bh, 00, limpiar,0000
                    posicion_o ingresarCoordenadaY,ingresarCoordenadaX
                    CALL PCLEANLINECURSOR
                    MOV limpiarFila, 0Bh
                    CALL PCLEANANYLINE
                    CALL PCHECKPLAYERWIN
                    MOV turno, 01
                    JMP iniciojuego

                volver_a_intentar:
                    CALL PCLEANLINECURSOR
                    MOV celdaInvalida, 00
                    JMP iniciojuego

                imprimirGanador:
                    CMP turno,01
                    JE ganador2
                    CMP turno,02
                    JE ganador1
                ganador2:
                    imprimirenVideo 15,00, mensajeGanador
                    JMP iniciojuego
                ganador1:
                    imprimirenVideo 15,00,mensajeGanador
                    JMP iniciojuego
        terminarPrograma

    MAIN ENDP

    crearTablero PROC
        MOV CX, 00
        INC CX
        CALL PPAINTVERTICAL
        INC CX
        CALL PPAINTVERTICAL
        INC CX   
        MOV AX, 3;posicion columna de la cruz
        MOV DI, offset wall_six ;cruz
        CALL PDRAWFIGURESCREEN;dibujo la cruz
        MOV AX, 06;posicion columna de la cruz
        MOV DI, offset wall_six ;cruz
        CALL PDRAWFIGURESCREEN;dibujo la cruz
        CALL PPAINTHORIZONTAL

        INC CX
        CALL PPAINTVERTICAL
        INC CX
        CALL PPAINTVERTICAL
        INC CX
        MOV AX, 0003 ;posicion columna de la cruz
        MOV DI, offset wall_six;curz
        CALL PDRAWFIGURESCREEN;dibujo la cruz
        MOV AX, 0006 ;posicion columna de la cruz
        MOV DI, offset wall_six;cruz
        CALL PDRAWFIGURESCREEN;dibujo la cruz
        CALL PPAINTHORIZONTAL

        INC CX
        CALL PPAINTVERTICAL
        INC CX
        CALL PPAINTVERTICAL
        INC CX
        MOV DI, offset wall_eleven
        RET
    crearTablero ENDP

    PPAINTHORIZONTAL PROC
        MOV AX, 01
        MOV DI, offset wall_four
        CALL PDRAWFIGURESCREEN
        INC AX
        MOV DI, offset wall_four
        CALL PDRAWFIGURESCREEN
        
        INC AX;se incrementa dos veces porque hay intersecciones
        INC AX
        MOV DI, offset wall_four
        CALL PDRAWFIGURESCREEN
        INC AX
        MOV DI, offset wall_four
        CALL PDRAWFIGURESCREEN

        INC AX
        INC AX
        MOV DI, offset wall_four
        CALL PDRAWFIGURESCREEN
        INC AX
        MOV DI, offset wall_four
        CALL PDRAWFIGURESCREEN
        RET

    PPAINTHORIZONTAL ENDP

    PPAINTVERTICAL PROC
      MOV AX, 0003
      MOV DI, offset wall_three
      CALL PDRAWFIGURESCREEN
      ADD AX, 0003
      MOV DI, offset wall_three
      CALL PDRAWFIGURESCREEN
      RET
    PPAINTVERTICAL ENDP
    
    PDRAWFIGURESCREEN PROC
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
            ret
    PDRAWFIGURESCREEN ENDP
    

    PCREAROBJETO PROC
        make_wall: 
            mov AX, [posXRead]    ; POS X DE LA PARED
            DEC AX
            mov CX, [posYRead]    ; POS Y DE LA PARED
            mov DH, [wallRead]
            call PPUTFIGURE
            JMP end_coordinates
        end_coordinates:
            RET
    PCREAROBJETO ENDP

    PPUTFIGURE PROC
        ;PUSH AX
        ;PUSH CX

        MOV DI, offset object_map       
        MOV DL, 03          ; 3d
        XCHG AX, CX
        MUL DL              ; POS Y * 3d
        XCHG AX, CX
        ADD DI, AX          ; Hacer row major: offset + x + y * 3d
        ADD DI, CX
        MOV AL, [DI]
        CMP AL, 00
        JNE celda_ocupada
        MOV [DI], DH        ; colocar objeto
        JMP finish_put_figure
        celda_ocupada:
            imprimirenVideo 0Bh, 00, mensajeCeldaInvalida,0004
            MOV celdaInvalida, 01
        finish_put_figure:
            ;POP CX
            ;POP AX
            ret
    PPUTFIGURE ENDP

    dibujarFigura PROC
        MOV BX,0000
        MOV DL,08
        MUL DL
        ADD BX,AX
        XCHG AX,CX
        MUL DL
        XCHG AX,CX
        posicion:
            CMP CX,0000
            JE finalPosicion
            ADD BX,140
            LOOP posicion
        finalPosicion:
            MOV CX,0008
        dibujarFiguraFila:
            PUSH CX
            MOV CX,0008
        dibujarFiguraColum:
            MOV AL,[DI]

            PUSH DS

            mMoveToVideo
            MOV  [BX],AL
            INC BX
            INC DI

            POP DS
            LOOP dibujarFiguraColum

            POP CX
            SUB BX,08
            ADD BX,140
            LOOP dibujarFiguraFila

            ret
    dibujarFigura ENDP

    mLimpiar PROC
        XOR AX,AX
        XOR CX,CX
        XOR SI,SI
        XOR BX,BX
        MOV CX,19
        atravesarFilas:
            XOR AX,AX
            PUSH CX
            XCHG CX,SI
            XCHG CX,BX
            MOV CX,28
        atravesarColumnas:
            PUSH CX
            XCHG CX,BX
            MOV DI, offset empty_block
            PUSH AX
            PUSH CX
            CALL dibujarFigura
            POP CX
            POP AX
            INC AX
            XCHG CX,BX

            POP CX
            loop atravesarColumnas
            XCHG CX,BX
            INC CX
            XCHG CX,SI
            POP CX
            loop atravesarFilas

        finalizarlimpieza:
            ret
    mLimpiar ENDP

    PMOVDATATOES PROC
      PUSH DX

      MOV DX, @data
      MOV ES, DX

      POP DX
      RET
    PMOVDATATOES ENDP

    PMOVESTOVIDEOMODE PROC
      PUSH DX

      MOV DX, 0A000h
      MOV ES, DX

      POP DX
      RET
    PMOVESTOVIDEOMODE ENDP

    PMOVERCURSOR PROC
        PUSH DX
        PUSH AX
        mov dh, cursorY       ; Fila
        mov dl, cursorX      ; Columna
        mov ah, 02h     ; Función de DOS para mover el cursor
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor
        POP AX
        POP DX
        RET
    PMOVERCURSOR ENDP

    PCOORDENADASOBJETOS PROC
        XOR AX, AX
        MOV AL, ingresarCoordenadaX
        DEC AL
        MOV CL, 3
        MUL CL
        ADD AX, 3
        INC AX
        PUSH AX
        MOV AL, ingresarCoordenadaY
        DEC AL
        MOV CL, 3
        MUL CL
        ADD AX, 3
        INC AX
        XOR CX, CX
        MOV CX, AX
        POP AX
        RET
    PCOORDENADASOBJETOS ENDP

    PCLEANLINECURSOR PROC
        XOR AX, AX      ; POS X
        XOR CX, CX      ; POS Y
        XOR SI, SI
        XOR BX, BX
        MOV CX, 28
        columns_cls:
            mov DI, offset empty_block
            push AX
            push CX
            XOR CX, CX
            mov CL, cursorY 
            call dibujarFigura
            pop CX
            pop AX
            inc AX      ; SE INCREMENTA POSICION EN X
            loop columns_cls
        clean_screen:
            ret
    PCLEANLINECURSOR ENDP

    PCLEANANYLINE PROC
        XOR AX, AX      ; POS X
        XOR CX, CX      ; POS Y
        XOR SI, SI
        XOR BX, BX
        MOV CX, 28
        traverse_columns_cls:
            mov DI, offset empty_block
            push AX
            push CX
            XOR CX, CX
            mov CL, limpiarFila
            call dibujarFigura
            pop CX
            pop AX
            inc AX      ; SE INCREMENTA POSICION EN X
            loop traverse_columns_cls
        finish_clean_screen:
            ret
    PCLEANANYLINE ENDP

    PCHECKPLAYERWIN proc
        ; Comprueba las filas
        mov cx, 3 ; Número de filas
        mov si, offset object_map
        checkRows:
            ; Compara cada fila
            PUSH SI
            mov al, [si]
            inc si
            cmp al, [si]
            jne nextRow
            inc si
            cmp al, [si]
            jne nextRow
            ; Si los tres elementos de la fila son 1, hay un ganador
            cmp al, turno
            jne nextRow
            ; En este punto, tenemos un ganador (jugador 1)
            POP SI
            mov al, 1
            mov Ganador, 01
            ret

        nextRow:
            POP SI
            add si, 3 ; Avanza al inicio de la siguiente fila
            loop checkRows ; Repite para todas las filas

            ; Comprueba las columnas
            mov cx, 3 ; Número de columnas
            mov si, offset object_map
        checkColumns:
            ; Compara cada columna
            PUSH SI
            mov al, [si]
            add si, 3 ; Avanza a la siguiente columna
            cmp al, [si]
            jne nextColumn
            add si, 3 ; Avanza a la siguiente columna
            cmp al, [si]
            jne nextColumn
            ; Si los tres elementos de la columna son 1, hay un ganador
            cmp al, turno
            jne nextColumn
            ; En este punto, tenemos un ganador (jugador 1)
            mov al, turno
            mov Ganador, 01
            POP SI
            ret

        nextColumn:
            POP SI
            ; sub si, 8 ; Retrocede al inicio de la siguiente columna
            INC SI
            loop checkColumns ; Repite para todas las columnas

            ; Comprueba las diagonales
            mov si, offset object_map
            ; Compara la diagonal principal (de izquierda a derecha)
            mov al, [si]
            add si, 4 ; Avanza a la siguiente celda de la diagonal
            cmp al, [si]
            jne checkSecondaryDiagonal
            add si, 4 ; Avanza a la siguiente celda de la diagonal
            cmp al, [si]
            jne checkSecondaryDiagonal
            ; Si los tres elementos de la diagonal son 1, hay un ganador
            cmp al, turno
            jne checkSecondaryDiagonal
            ; En este punto, tenemos un ganador (jugador 1)
            mov al, turno
            mov Ganador, 01
            ret

        checkSecondaryDiagonal:
            ; Comprueba la diagonal secundaria (de derecha a izquierda)
            mov si, offset object_map + 2 ; Comienza en la segunda celda de la diagonal secundaria
            mov al, [si] ; Obtiene el primer elemento de la diagonal
            add si, 2 ; Retrocede a la siguiente celda de la diagonal
            cmp al, [si] ; Compara con el segundo elemento de la diagonal
            jne noWinner ; Si no son iguales, no hay ganador
            add si, 2 ; Retrocede a la siguiente celda de la diagonal
            cmp al, [si] ; Compara con el tercer elemento de la diagonal
            jne noWinner ; Si no son iguales, no hay ganador
            ; Si los tres elementos de la diagonal son 1, hay un ganador
            cmp al, turno
            jne noWinner ; Si no todos son iguales a 1, no hay ganador
            ; En este punto, tenemos un ganador (jugador 1)
            mov al, turno
            mov Ganador, 01
            ret

        noWinner:
            ; No hay ganador para el jugador 1
            xor al, al
            ret

    PCHECKPLAYERWIN endp
    

END inicio