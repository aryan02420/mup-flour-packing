getTemp proc near
	mov	dl, 1
	mov	al, 00000000b
	out	portC2, al	; read adc
gt_x0	nop
	cmp	dl, 1
	je	gt_x0:
	in	ah, tempInp
	mov	al, 00000000b
	out	portC2, al	; stop read adc
	mov	al, ah
	;make dl 1
	;start adc conversion
	;loop till dl == 1
	;store temp in al
	ret
getTemp endp

;ISRTemp will make dl = 0
