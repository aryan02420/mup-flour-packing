getTemp proc near
	mov	dl, 1
	mov	al, 00000000b
	out	portC2, al	; read adc
gt_x0:	nop
	cmp	dl, 1
	je	gt_x0:
	in	al, tempInp
	mov	ah, al
	mov	al, 00000001b
	out	portC2, al	; stop read adc
	mov	al, ah
	mov	actTemp, al
	ret
getTemp endp

; make dl 1
; start adc conversion
; loop till dl == 1
; store temp in al

; ISRTemp will make dl = 0
