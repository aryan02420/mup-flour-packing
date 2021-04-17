strTimrB proc near
	pusha
	mov	al, 00001001b
	out	portC2, al
	popa
	ret
strTimrB endp
