strTimrB proc near
	mov	al, 01110100b
	out	timrCreg, al
	mov	al, cx
	out	timrB, al
	mov	al, 00001001b
	out	portC2, al
	ret
strTimrB endp
