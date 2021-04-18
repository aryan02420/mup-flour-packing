calcDelay proc near
	pusha
	mov	al, cUsrWegt
	mov	ah, 0
	mov	cl, tpKG
	mul	cl	; ax = al * cl
	mov	cDelay, ax
	popa
	ret
calcDelay endp
