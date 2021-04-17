stpTimrB proc near
	mov	al, 00001000b
	out	portC2, al
	mov	ticks, 0
	ret
stpTimrB endp
