clrKBfr proc near
	pusha
	mov	ax, 0
	mov	keyBfr, ax
	call	setDisp1
	popa
	ret
clrKBfr endp
