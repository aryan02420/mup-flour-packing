bin2bcd proc near
	mov	ah, 0
	mov	cl, 10
	div	cl
	mov	cl, 4
	shl	al, cl
	or	al, ah
	ret
bin2bcd endp


; al = 3fh = 63d
; al = ax // 10 = 06h
; ah = ax % 10 = 03h
; al = al << 4 = 60h
; al = al | ah = 63h
