getKey proc near

; check no key is pressed
; if a key is kept pressed
; wait for release
	mov	al, 00h
	out	keypd, al
k_x0:	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if no key was pressed
	je	x0

	call delayA			; debounce

	mov	al, 00h
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if still no key was pressed
	je	k_x0


; check for key press
	mov	al, 00h
	out	keypd, al
k_x1:	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if some key is pressed
	jne	k_x1

	call delayA			; debounce

; check for key press
	mov	al, 00h
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if some key is still pressed
	jne	k_x1

; key pressed in col1

	mov	al, 0eh
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; key pressed in col2

	mov	al, 0dh
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; key pressed in col3

	mov	al, 0bh
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; key pressed in col4

	mov	al, 07h
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; decode key
k_x3:	or	al, bl			; combine input:output
	mov	di, 0
k_x4:	cmp	al, keyCode[di]
	jne	k_x5			; find matching entry in keyCode
	inc	di
	cmp	di, 16
	jb	k_x4

k_x5:	mov	al, keyAct[di]
	mov	ah, 0h
	ret

getKey endp
