setTemp proc near
	call	clrKBfr
	call	getNum
	mov	usrTemp, al
	call	bcd2bin
	mov	cUsrTemp, al
	ret
setTemp endp
