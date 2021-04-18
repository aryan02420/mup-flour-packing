setTWegt proc near
	call	clrKBfr
	call	getNum
	mov	usrTWegt, ax
	mov	bh, ah		; store msb
	call	bcd2bin		; conv lsb
	mov	bl, al		; store clsb
	mov	al, bh
	call	bcd2bin		; conv msb
	mov	cl, 100
	mul	cl		; cmsb*100
	mov	bh, 0
	add	ax, bx		; cmsb*100 + clsb
	mov	cUsrTWegt, ax
	ret
setTWegt endp
