vlvOpn proc near
	cmp	vlvSts, 00h
	jne	vo_x0
	mov	al, 00000011b
	out	portC2, al
	mov	al, 00000010b
	out	portC2, al
	mov	vlvSts, 0ffh
vo_x0:	ret
vlvOpn endp
