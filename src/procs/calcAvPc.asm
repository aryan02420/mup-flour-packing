calcAvPc proc near
	pusha
	mov	ax, numPac
	mov	bl, minutes
	inc	bl
	div	bl
	mov	cl, 60
	mov	ah, 0
	mul	cl
	mov	avgPac, ax
	popa
	ret
calcAvPc endp
