getATemp proc near
	mov	ah, 0
	mov	al, actTemp
	mov	cl, 100
	mul	cl
	mov	bl, 0ffh
	div	bl
	mov	cActTemp, al
	ret
getATemp endp

; 	measured	store
; 0*C	00000000b	00000000b
; 100*C	11111111b	01100100b
