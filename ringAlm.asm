ringAlm proc near
	mov	al, 00000101b
	out	portC2, al
	ret
ringAlm endp
