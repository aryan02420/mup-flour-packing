calcDelay proc near
	mov	al, cUsrWegt
	mov	ah, 0
	mov	cl, tpKG
	mul	cl	; ax = al * cl
	mov	cDelay, ax
	ret
calcDelay endp
