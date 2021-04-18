setWegt proc near
	call	clrKBfr
	call	getNum
	mov	usrWegt, al
	call	bcd2bin
	mov	cUsrWegt, al
	ret
setWegt endp
