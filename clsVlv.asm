clsVlv proc near
	mov	al, vlvSts
	cmp	al, vlvOpn
	jne	cv_x0
	mov	al, 00000011b
	out	portC2, al
	mov	al, 00000010b
	out	portC2, al
	mov	al, vlvCls
	mov	vlvSts, al
cv_x0:	ret
clsVlv endp
