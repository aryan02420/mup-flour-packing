clsVlv proc near
	pusha
	mov	al, 00000011b
	out	portC2, al
	popa
cv_x0:	ret
clsVlv endp
