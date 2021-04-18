calcTPac proc near
	mov	ax, cUsrTWegt
	mov	bl, cUsrWegt
	div	bl
	mov	totPac, al
	ret
calcTPac endp
