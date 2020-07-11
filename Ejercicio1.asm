org	100h

section	.text

	call	grafico
	xor	di, di
	xor	si, si
lupa:	mov	cx, 20d		;Caja amarilla 
	add	cx, si
	mov	dx, 30d
	add	dx, di
	call	pixel
	inc	di
	cmp	di, 201d
	jne	lupa
	xor	di, di
	inc	si
	cmp	si, 151d
	jne	lupa
	mov	ah, 3d
	call	m_cur

	xor	di, di
lupb:	mov	ah, 0Eh 	;Mensaje 1 
	mov	al, [msg+di]
	mov	bl, 1111b
	int	10h
	inc	di
	cmp	di, len
	jl	lupb

	xor	di, di
lupc:	call 	kb 		;Leer teclado
	cmp	al, 0Dh
	je	write
	cmp	al, 40h
	je	ajuste
cont:	mov	[300h+di], al
	inc	di
	jmp	lupc	

write:	mov	[360h], di
	cmp	di, 70d
	jg	error
	cmp	di, 50d
	jl 	error

	xor	ah, ah
	mov	ah, 3d
	call	m_cur2
	xor	si, si
lupd:	mov	ah, 0Eh 	;Mensaje 2 
	mov	al, [300h+si]
	mov	bl, 1110b
	int	10h
	cmp	si, 17d
	je	nl
	cmp	si, 35d
	je	nl2
	cmp	si, 53d
	je	nl3
cont1:	inc	si
	cmp	si, di
	jle	lupd

	mov	ah, 5d
	call	m_cur
	xor	di, di
lupe:	mov	ah, 0Eh 	;Mensaje 3 
	mov	al, [next+di]
	mov	bl, 0010b
	int	10h
	inc	di
	cmp	di, len3
	jl	lupe

	call	kb
	cmp	al, 0Dh
	je	new
	int	20h

new:	mov	ax, 0000h
	int	10h
	call	grafico
	xor	di, di
	xor	si, si
lupf:	mov	cx, 20d		;Caja amarilla 
	add	cx, si
	mov	dx, 30d
	add	dx, di
	call	pixel
	inc	di
	cmp	di, 201d
	jne	lupf
	xor	di, di
	inc	si
	cmp	si, 151d
	jne	lupf

	xor	ah, ah
	mov	ah, 3d
	call	m_cur2
	xor	si, si
lupg:	mov	ah, 0Eh 	;Mensaje 2 
	mov	al, [300h+si]
	add	al, 20h
	cmp	al, 40h
	je	ajuste2
cont3:	mov	bl, 1110b
	int	10h
	cmp	si, 17d
	je	nl4
	cmp	si, 35d
	je	nl5
	cmp	si, 53d
	je	nl6
cont2:	inc	si
	cmp	si, [360h]
	jle	lupg
	call	kb
	int	20h

nl:	mov	ah, 4d
	call	m_cur2
	jmp	cont1

nl2:	mov	ah, 5d
	call	m_cur2
	jmp	cont1

nl3:	mov	ah, 6d
	call	m_cur2
	jmp	cont1

nl4:	mov	ah, 4d
	call	m_cur2
	jmp	cont2

nl5:	mov	ah, 5d
	call	m_cur2
	jmp	cont2

nl6:	mov	ah, 6d
	call	m_cur2
	jmp	cont2

grafico:mov	ah, 00h
	mov	al, 12h
	int	10h
	ret

limpiar:mov	ah, 00h
	mov	al, 03h
	int	10h
	ret

pixel:	mov	ah, 0Ch
	mov	al, 1110b
	int 	10h
	ret

m_cur:	mov	dh, ah
	mov	dl, 25d
	mov	bh, 0d
	mov	ah, 02h
	int	10h
	ret

m_cur2:	mov	dh, ah
	mov	dl, 3d
	mov	bh, 0d
	mov	ah, 02h
	int	10h
	ret

ajuste:	mov	al, 20h
	jmp	cont

ajuste2:mov	al, 20h
	jmp	cont3

error:	mov	ah,3d
	call	m_cur
	xor	di, di
lupx:	mov	ah, 0Eh 	;Mensaje 1 
	mov	al, [err+di]
	mov	bl, 0100b
	int	10h
	inc	di
	cmp	di, len2
	jl	lupx
	int	20h

kb: 	mov	ah, 00h
	int 	16h
	ret

section	.data
msg	db	"Escriba un parrafo en MAYUSCULAS y de enter"
len	equ	$-msg
err	db	"El parrafo debe tener entre 50 y 70 caracteres"
len2	equ	$-err
next	db	"Desea continuar? (enter si | esc no)"
len3	equ	$-next

