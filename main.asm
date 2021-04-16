x0:	call	getKey
	cmp	al, 0
	jge	x0	; if number key pressed
	cmp	al, tKey
	jne	x1
	call	setTemp
x1:	cmp	al, wKey
	jne	x2
	call	setWegt
x2:	cmp	al, sKey
	jne	x0
	call	strtMach
