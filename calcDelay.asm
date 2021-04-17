calcDelay proc near
	mov	al, cUsrWegt
	mov	ah, 0
	mov	cl, 100
	mul	cl
	mov	bl, wtFRate
	div	bl
	mov	ah, 0
	mov	cl, 10
	mul	cl
	mov	cDelay, ax
	ret
calcDelay endp
