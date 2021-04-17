ringAlm proc near
	pusha
	mov	al, 00000101b
	out	portC2, al
	popa
	ret
ringAlm endp
