opnVlv proc near
	mov	al, vlvSts
	cmp	al, vlvCls
	jne	ov_x0
	mov	al, 00000011b
	out	portC2, al
	mov	al, 00000010b
	out	portC2, al
	mov	al, vlvOpn
	mov	vlvSts, al
ov_x0:	ret
opnVlv endp
