bcd2bin proc near
	mov	bl, al
	and	bl, 0fh
	mov	cl, 4
	shr	al, cl
	mov	cl, 10
	mul	cl
	add	al, bl
	ret
bcd2bin endp


; al = bcd 25h
; bl = 25h
; bl = 05h
; al = 02h
; al = 02h * 10 = 20 = 14h
; al = al + bl = 19h = 25
