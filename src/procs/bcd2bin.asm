bcd2bin proc near
	mov	ah, al
	and	ah, 0fh
	mov	cl, 4
	shr	al, cl
	mov	cl, 10
	mul	cl
	add	al, ah
	ret
bcd2bin endp


; al = bcd 25h
; ah = 25h
; ah = ah & 0fh = 05h
; al = al >> 4 = 02h
; al = al * 10 = 20 = 14h
; al = al + ah = 19h = 25
