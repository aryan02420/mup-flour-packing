calcTPac proc near
	mov	ax, cUsrTWegt
	mov	bl, cUsrWegt
	div	bl
	mov	ah, 0
	mov	totPac, ax
	ret
calcTPac endp
