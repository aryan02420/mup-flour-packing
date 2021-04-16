setWegt proc near
	call	clrKBfr
	call	getNum
	mov	usrWegt, al
	ret
setWegt endp
