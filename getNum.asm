getNum proc near
gn_str:	call	getKey
	cmp	al, eKey
	je	gn_ret
	cmp	al, bkey
	jne	gn_num
	call	clrKBfr
	jnp	gn_str
gn_num:	cmp	al, 0
	jl	gn_str
	mov	cl, 4
	shl	keyBfr, cl
	or	al, keyBfr
	call	setDisp1
	jmp	gn_str
gn_ret:	mov	ax, keyBfr
	ret
getNum endp
