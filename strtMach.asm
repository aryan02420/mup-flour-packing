strtMach proc near
	call	calcDelay
sm_loop:call	getATemp
	mov	bl, cUsrTemp
	add	bl, 5
	cmp	cActTemp,  bl
	jbe	sm_norm
	call	ringAlm
	jmp	sm_ret
sm_norm:
	jmp	sm_loop
sm_ret:	ret
strtMach endp
