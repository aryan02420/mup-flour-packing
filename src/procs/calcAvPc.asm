calcAvPc proc near
	pusha
	mov	al, numPac
	mov	ah, 0
	mov	bl, minutes
	inc	bl
	div	bl
	mov	cl, 60
	mov	ah, 0
	mul	cl
	popa
	ret
calcAvPc endp
