delayA proc near
	pusha
	mov	cx, 500
d_x0:	nop
	dec	cx
	jnz	d_x0
	popa
	ret
delayA endp
