opnVlv proc near
	pusha
	mov	al, 00000010b
	out	portC2, al
	popa
ov_x0:	ret
opnVlv endp
