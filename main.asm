INCLUDE <MACROS.ASM>

mostrarMenu MACRO
    LOCAL mostrarmenujuego, salir, regresar, nuevoJuego, regresaralMenu, mostrarinfo
    regresaralMenu:
        limpiarConsola
        imprimirMensajes salto
        imprimirMensajes reportec
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
        imprimirMensajes regresarInfo
        tomarEntrada opcion3

        CMP opcion3, 13
        JE regresar
ENDM

.MODEL small

.STACK 100h

.DATA
    num1 db '$hola'
    num3 db 'hola2$'
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
    datosf db '           UNIVERSIDAD DE SAN CARLOS DE GUATEMALA$'
    datosg db '                 FACULTAD DE INGENIERIA$'
    datosh db '             ESCUELA DE CIENCIAS Y SISTEMAS$'
    datosi db '         ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 2$'
    datosj db '                 PRIMER SEMESTRE 2024$'
    datosk db '            Gerson David Otoniel Gonzalez Morales$'
    datosl db '                      202000774$'
    regresarInfo db 'Para regresar al menu presione Enter. $'


    errorCerrarArchivo db ' Error al cerrar el Archivo','$'
    errorCrearArchivo db "Ocurrio Un Error Al Crear El Archivo", "$"
    errorLeerArchivo db "Ocurrio Un Error Al Leer Archivo", "$"
    errorEscribirArchivo db "Ocurrio Un Error Al Escribir Archivo", "$"
    errorAbrirArchivo db "Ocurrio Un Error Al Abrir Archivo", "$"
    handlerArchivo dw ?

.CODE

    MOV AX, @data
    MOV DS, AX
    MAIN PROC

        mostrarMenu
        terminarPrograma

    MAIN ENDP    

END