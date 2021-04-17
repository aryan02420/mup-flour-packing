strtMach proc near
	call	getATemp
	mov	bl, cUsrTemp
	add	bl, 5
	cmp	cActTemp,  bl
	jbe	sm_norm
	call	ringAlm
	jmp	sm_ret
sm_norm:call	calcDelay

sm_ret:	ret
strtMach endp
