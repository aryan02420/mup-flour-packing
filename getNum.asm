getNum proc near
gn_str:	call	getKey
	cmp	al, eKey
	je	gn_ret
	cmp	al, bkey
	jne	gn_num
	call	clrKBfr
	jnp	gn_str
gn_num:	cmp	al, 0
	jb	gn_str
	mov	cl, 4
	shl	keyBfr, cl
	cbw
	or	keyBfr, ax
	jmp	gn_str
gn_ret:	ret
getNum endp
