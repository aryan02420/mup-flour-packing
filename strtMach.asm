strtMach proc near
	call	calcDelay
sm_loop:call	getATemp
	mov	bl, cUsrTemp
	add	bl, 5
	cmp	cActTemp,  bl
	jbe	sm_norm
	call	ringAlm
	jmp	sm_ret
sm_norm:mov	cx, cDelay
	call	strTimrB
	call	opnVlv
sm_x0:	nop
	cmp	ticks, cDelay
	jae	sm_x1
	jmp	sm_x0
sm_x1:	call	clsVlv
	call	stpTimrB
	mov	cx, 70		; wait before next cycle
	call	strTimrB
sm_x2:	nop
	cmp	ticks, 70
	jae	sm_x3
	jmp	sm_x2
sm_x3:	jmp	sm_loop
sm_ret:	ret
strtMach endp
