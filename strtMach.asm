strtMach proc near
	call	calcDelay
sm_loop:call	getATemp
	mov	bl, cUsrTemp
	add	bl, 5
	mov	al, cActTemp
	cmp	al,  bl
	jbe	sm_norm
	call	ringAlm
	jmp	sm_ret
sm_norm:call	bin2bcd
	call	setDisp0
	mov	cx, cDelay
	call	strTimrB
	call	opnVlv
sm_x0:	nop
	cmp	ticks, cDelay
	jae	sm_x1
	jmp	sm_x0
sm_x1:	call	clsVlv
	call	stpTimrB
	inc	numPac
	call	calcAvPc
	call	bin2bcd
	call	setDisp1
	call	strTimrB
sm_x2:	nop
	cmp	ticks, 70
	jae	sm_x3
	jmp	sm_x2
sm_x3:	jmp	sm_loop
sm_ret:	ret
strtMach endp
