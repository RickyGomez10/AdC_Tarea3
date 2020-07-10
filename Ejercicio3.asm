org 	100h

section .text

	call 	grafico	; Llamada a iniciar modo grafico 13h
	xor 	di, di 
    xor     si, si
            
   mov [300h], byte 0100b
    mov si, 10d ; columna a empezar a printear
    mov di, 70d ; fila a empezar a printear
    jmp mouse;
    


mouse: 
    MOV AX, 0
    INT 33h
    MOV AX, 1

    INT 33h
    mov ax, 04h
    mov cx, 300
    mov dx, 200
    int 33h
    call printearCuadrado
    mov ax, 06h
    int 33h 
       
validar:  
        mov ax,03h
        int 33h
        and bx, 3h
        CMP CX, 10d  ;comparar limite columna 70 inicio del cubo
        JGE s
    s:  CMP CX, 85d ; comparar limite columna 140 final del cubo
        JLE s1
        jmp validar ; si no esta dentro de los limites regresar a validar
    s1: cmp dx, 70d ; 
        JGE s2
    s2: cmp dx, 145d
        JLE s3
        jmp validar
    s3: cmp bx, 00000001b
        JE cambiarColor
        JL s4
    s4: cmp bx, 00000010b
        JE terminar
        jmp validar


cambiarColor:
        cmp [300h], byte 0100b
        JE color2
        cmp [300h], byte 0010b
        JE color3
        cmp  [300h], byte 0001b 
        JE resetcolor

color2:
   
    mov  [300h], byte  0010b
      mov si, 10d ; columna a empezar a printear
    mov di, 70d ; fila a empezar a printear
    jmp mouse

color3:

    mov [300h], byte 0001b 
      mov si, 10d ; columna a empezar a printear
    mov di, 70d ; fila a empezar a printear
    jmp mouse

resetcolor:

    mov [300h], byte 0100b
    mov si, 10d ; columna a empezar a printear
    mov di, 70d ; fila a empezar a printear
    jmp mouse

printearCuadrado:
 
    mov cx, si ; columna
    mov dx, di ; fila
    call pixel ; printeaer pixel
    inc si    ; aumentar columna para printear el horizontal
    cmp si, 85d ; verificar si se ha printeado una linea
    jne printearCuadrado ; repetir el loop
    xor si, si ;limpiamos las columnas
    mov si, 10d ; reiniciamos las columnas
    mov cx, si ; seteamos las columnas
    inc di    ; incrementamos la fila
    cmp di, 145d ; comparamos si printeamos 70 filas
    jne printearCuadrado
    ret

grafico:

        mov ah,00h
        mov al, 12h
        int 10h
        ret

pixel: 
        mov ah, 0Ch
        mov al, [300h]
        int 10h
        ret
kb: 	
    mov	ah, 00h
	int 	16h
	ret

terminar:
    mov ah, 00h
    int 10h
    mov ah,0x4C          ;DOS "terminate" function
    int 0x21
