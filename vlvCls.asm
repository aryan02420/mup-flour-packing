vlvCls proc near
	cmp	vlvsts, ffh
	jne	vc_x0
	mov	al, 00000011b
	out	portC2, al
	mov	al, 00000010b
	out	portC2, al
vc_x0:	ret
vlvCls endp
