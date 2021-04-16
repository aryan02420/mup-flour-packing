setTemp proc near
	call	clrKBfr
	call	getNum
	mov	usrTemp, al
	ret
setTemp endp
