org 	100h

section .text

	call 	grafico	
        
	;f(0) = 1
	xor 	si, si
	xor 	di, di

	mov 	si, 130d 	; X -> Columna
	mov 	di, 100d 	; Y -> Fila
	mov	al, 30d		
	mov	[300h], al	; L -> Lado
	mov	al, 1100b
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '1'
	mov	[320h], al
	mov	al, 7d
	mov	[321h], al
	mov	al, 18d
	mov	[322h], al
	mov	al, 00001100b
	mov	[323h], al
	call	char

	;f(1) = 1
	xor 	si, si
	xor 	di, di

	mov 	si, 160d 	; X -> Columna
	mov 	di, 100d 	; Y -> Fila
	mov	al, 30d		
	mov	[300h], al	; L -> Lado
	mov	al, 1110b
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '1'
	mov	[320h], al
	mov	al, 7d
	mov	[321h], al
	mov	al, 22d
	mov	[322h], al
	mov	al, 00001110b
	mov	[323h], al
	call	char

	;f(2) = 2
	xor 	si, si
	xor 	di, di

	mov 	si, 130d 	; X -> Columna
	mov 	di, 40d 	; Y -> Fila
	mov	al, 60d		
	mov	[300h], al	; L -> Lado
	mov	al, 1010b
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '2'
	mov	[320h], al
	mov	al, 4d
	mov	[321h], al
	mov	al, 20d
	mov	[322h], al
	mov	al, 00001010b
	mov	[323h], al
	call	char

	;f(3) = 3
	xor 	si, si
	xor 	di, di

	mov 	si, 40d 	; X -> Columna
	mov 	di, 40d 	; Y -> Fila
	mov	al, 90d		
	mov	[300h], al	; L -> Lado
	mov	al, 1011b
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '3'
	mov	[320h], al
	mov	al, 5d
	mov	[321h], al
	mov	al, 10d
	mov	[322h], al
	mov	al, 00001011b
	mov	[323h], al
	call	char

	;f(4) = 5
	xor 	si, si
	xor 	di, di

	mov 	si, 40d 	; X -> Columna
	mov 	di, 130d 	; Y -> Fila
	mov	al, 150d		
	mov	[300h], al	; L -> Lado
	mov	al, 1001b
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '5'
	mov	[320h], al
	mov	al, 12d
	mov	[321h], al
	mov	al, 15d
	mov	[322h], al
	mov	al, 00001001b
	mov	[323h], al
	call	char

	;f(5) = 8
	xor 	si, si
	xor 	di, di

	mov 	si, 190d 	; X -> Columna
	mov 	di, 40d 	; Y -> Fila
	mov	al, 240d		
	mov	[300h], al	; L -> Lado
	mov	al, 0101b
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '8'
	mov	[320h], al
	mov	al, 9d
	mov	[321h], al
	mov	al, 38d
	mov	[322h], al
	mov	al, 00000101b
	mov	[323h], al
	call	char

	call 	kb

	int 	20h

grafico:mov	ah, 00h
	mov	al, 12h
	int 	10h
	ret

pixel:	mov	ah, 0Ch
	mov	al, [320h]
	mov	bh, 00h
	int 	10h
	ret

;Este segmento dibuja un cuadro iniciando en (si, di) con L = [300h]
cuadro:	mov	bx, 0000h	;Limites de si (BH) y di (BL)
	mov	[310h], si
hor:	mov 	cx, 0d 		; Columna 
	add 	cx, si
	mov	dx, di 		; Fila
	mov	[330h], bx
	call 	pixel
	mov	bx, [330h]
	inc 	si
	inc 	bh
	cmp 	bh, [300h]
	jne 	hor
	
	inc	di
	inc	bl
	cmp	bl, [300h]
	je	end
	mov	si, [310h]
	mov	bh, 00h
	jmp	hor

end:	ret

	;Escribir el caracter guardado en [320h] en la fila [321h] y columna [322h], color en [323h]
char:	mov  dl, [322h]   	; Columna
	mov  dh, [321h]   	; Fila
	mov  bh, 0h   
	mov  ah, 02h 
	int  10h

	mov  al, [320h]		; Caracter
	mov  bl, [323h]  	; Color
	mov  bh, 0h    		; Pagina 0
	mov  ah, 0Eh
	int  10h
	ret

kb: 	mov	ah, 00h
	int 	16h
	ret