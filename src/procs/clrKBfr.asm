clrKBfr proc near
	pusha
	mov	al, 0
	mov	keyBfr, al
	call	setDisp1
	popa
	ret
clrKBfr endp
