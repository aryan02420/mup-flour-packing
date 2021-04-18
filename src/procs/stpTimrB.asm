stpTimrB proc near
	pusha
	mov	al, 00001000b
	out	portC2, al
	mov	ticks, 0
	popa
	ret
stpTimrB endp
