.model tiny
.86
.data
	keyCode db	0EEH, 0EDH, 0EBH, 0E7H	; 7 8 9 T
		db	0DEH, 0DDH, 0DBH, 0D7H	; 4 5 6 W
		db	0BEH, 0BDH, 0BBH, 0B7H	; 1 2 3 B
		db	07EH, 07DH, 07BH, 077H	;   0 S E
	keyAct	db	007h, 008h, 009h, 0f0h
		db	004h, 005h, 006h, 0f1h
		db	001h, 002h, 003h, 0f2h
		db	0f5h, 000h, 0f4h, 0f3h


	keyBfr	dw	?
	usrTemp	db	?	; bcd
	usrWegt	db	?	; bcd
	usrTWegt dw	?	; bcd
	cUsrTemp db	?	; bin
	cUsrWegt db	?	; bin
	cUsrTWegt dw	?	; bin
	actTemp	db	?	; bin 0-255
	cActTemp db	?	; bin 0-100

	minutes	db	?	; counts minutes passed
	ticks	dw	?	; counts 0.25 seconds

	cDelay	dw	?	; how long valve is open

	numPac	dw	?
	avgPac	dw	?
	totPac	dw	?

	tpKG	equ	40
	;40 ticks = 10sec for 1kg

	tKey	equ	0f0h
	wKey	equ	0f1h
	bKey	equ	0f2h
	eKey	equ	0f3h
	sKey	equ	0f4h


	; IO addresses

	disp0	equ	00h
	disp1	equ	02h
	keyPad	equ	04h
	creg1	equ	06h

	tempInp	equ	10h
	portB2	equ	12h
	portC2	equ	14h
	creg2	equ	16h

	timrA	equ	20h
	timrB	equ	22h
	timrC	equ	24h
	timrCreg equ	26h

	8259_1	equ	30h
	8259_2	equ	32h
.code
.startup

; ISRTemp will make dl = 0
; initialize 8255 (1)
; portA = output / mode0
; portB = output / mode0
; portC = input:output / BSR
; 1   00 0 1   0 0 0
mov	al, 10001000b
out	creg1, al
out	disp0, 00h
out	disp1, 00h

; initialize 8255 (2)
; portA = input / mode0
; portB = input / mode0
; portC = output / BSR
; 1   00 1 0   0 1 0
mov	al, 10010010b
out	creg2, al

; set default values
mov	usrTemp, 50h
mov	usrWegt, 02h
mov	vlvSts, 00h

; adc read' = 1
mov	al, 00000001b
out	portC2, al

mov 	al,34h
out 	creg2,al		;control word for clock 1
mov 	al,54h
out	creg2,al		;control word for clock 2
mov 	al,94h
out 	creg2,al		;control word for clock 3

mov 	al,88h
out 	clk1,al			;load lsb in clk1
mov 	al,13h
out 	clk1,al			;load msb in clk1
mov 	al,0fah
out 	clk2,al			;load lsb in clk2
mov 	al,0f0h
out 	clk3,al			;load lsb in clk3

mov 	al,13h
out 	8259_1,al
mov 	al,40h
out 	8259_2,al
mov 	al,01h
out 	8259_2,al


mov	minutes, 0
mov	ticks, 0
mov	numPac, 0
mov	avgPac, 0

	call	setWegt
x0:	call	getKey
	cmp	al, 0
	jge	x0	; if number key pressed
	cmp	al, tKey
	jne	x1
	call	setTemp
x1:	cmp	al, wKey
	jne	x2
	call	setTWegt
x2:	cmp	al, sKey
	jne	x0
	call	strtMach

.exit

bcd2bin proc near
	mov	ah, al
	and	ah, 0fh
	mov	cl, 4
	shr	al, cl
	mov	cl, 10
	mul	cl
	add	al, ah
	ret
bcd2bin endp


; al = bcd 25h
; ah = 25h
; ah = ah & 0fh = 05h
; al = al >> 4 = 02h
; al = al * 10 = 20 = 14h
; al = al + ah = 19h = 25
bin2bcd proc near
	mov	ah, 0
	mov	cl, 10
	div	cl
	mov	cl, 4
	shl	al, cl
	or	al, ah
	ret
bin2bcd endp


; al = 3fh = 63d
; al = ax // 10 = 06h
; ah = ax % 10 = 03h
; al = al << 4 = 60h
; al = al | ah = 63h
calcAvPc proc near
	pusha
	mov	al, numPac
	mov	ah, 0
	mov	bl, minutes
	inc	bl
	div	bl
	mov	cl, 60
	mov	ah, 0
	mul	cl
	popa
	ret
calcAvPc endp

calcDelay proc near
	pusha
	mov	al, cUsrWegt
	mov	ah, 0
	mov	cl, tpKG
	mul	cl	; ax = al * cl
	mov	cDelay, ax
	popa
	ret
calcDelay endp

calcTPac proc near
	mov	ax, cUsrTWegt
	mov	bl, cUsrWegt
	div	bl
	mov	totPac, al
	ret
calcTPac endp

clrKBfr proc near
	pusha
	mov	al, 0
	mov	keyBfr, al
	call	setDisp1
	popa
	ret
clrKBfr endp

clsVlv proc near
	pusha
	mov	al, 00000011b
	out	portC2, al
	popa
cv_x0:	ret
clsVlv endp

delayA proc near
	pusha
	mov	cx, 500
d_x0:	nop
	dec	cx
	jnz	d_x0
	popa
	ret
delayA endp

getATemp proc near
	call	getTemp
	mov	ah, 0
	mov	al, actTemp
	mov	cl, 100
	mul	cl
	mov	bl, 0ffh
	div	bl
	mov	cActTemp, al
	ret
getATemp endp

; 	measured	store
; 0*C	00000000b	00000000b
; 100*C	11111111b	01100100b
getKey proc near

; check no key is pressed
; if a key is kept pressed
; wait for release
	mov	al, 00h
	out	keypd, al
k_x0:	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if no key was pressed
	je	x0

	call delayA			; debounce

	mov	al, 00h
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if still no key was pressed
	je	k_x0


; check for key press
	mov	al, 00h
	out	keypd, al
k_x1:	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if some key is pressed
	jne	k_x1

	call delayA			; debounce

; check for key press
	mov	al, 00h
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h		; if some key is still pressed
	jne	k_x1

; key pressed in col1

	mov	al, 0eh
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; key pressed in col2

	mov	al, 0dh
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; key pressed in col3

	mov	al, 0bh
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; key pressed in col4

	mov	al, 07h
	mov	bl, al
	out	keypd, al
	in	al, keypd
	and	al, 0f0h
	cmp	al, 0f0h
	jne	k_x3

; decode key
k_x3:	or	al, bl			; combine input:output
	mov	di, 0
k_x4:	cmp	al, keyCode[di]
	jne	k_x5			; find matching entry in keyCode
	inc	di
	cmp	di, 16
	jb	k_x4

k_x5:	mov	al, keyAct[di]
	mov	ah, 0h
	ret

getKey endp

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

getTemp proc near
	mov	dl, 1
	mov	al, 00000000b
	out	portC2, al	; read adc
gt_x0	nop
	cmp	dl, 1
	je	gt_x0:
	in	ah, tempInp
	mov	al, 00000001b
	out	portC2, al	; stop read adc
	mov	al, ah
	mov	actTemp, al
	ret
getTemp endp

; make dl 1
; start adc conversion
; loop till dl == 1
; store temp in al



opnVlv proc near
	pusha
	mov	al, 00000010b
	out	portC2, al
	popa
ov_x0:	ret
opnVlv endp

ringAlm proc near
	pusha
	mov	al, 00000101b
	out	portC2, al
	popa
	ret
ringAlm endp

setDisp0 proc near
	out	disp0, al
	ret
setDisp0 endp

setDisp0 proc near
	out	disp1, al
	ret
setDisp0 endp

setTemp proc near
	call	clrKBfr
	call	getNum
	mov	usrTemp, al
	call	bcd2bin
	mov	cUsrTemp, al
	ret
setTemp endp

setTWegt proc near
	call	clrKBfr
	call	getNum
	mov	usrTWegt, ax
	mov	bh, ah		; store msb
	call	bcd2bin		; conv lsb
	mov	bl, al		; store clsb
	mov	al, bh
	call	bcd2bin		; conv msb
	mov	cl, 100
	mul	cl		; cmsb*100
	mov	bh, 0
	add	ax, bx		; cmsb*100 + clsb
	mov	cUsrTWegt, ax
	ret
setTWegt endp

setWegt proc near
	call	clrKBfr
	call	getNum
	mov	usrWegt, al
	call	bcd2bin
	mov	cUsrWegt, al
	ret
setWegt endp

stpTimrB proc near
	pusha
	mov	al, 00001000b
	out	portC2, al
	mov	ticks, 0
	popa
	ret
stpTimrB endp

strTimrB proc near
	pusha
	mov	al, 00001001b
	out	portC2, al
	popa
	ret
strTimrB endp

strtMach proc near
	call	calcTPac
	call	calcDelay
sm_loop:mov	ax, numPac
	cmp	ax, totPac
	jae	sm_ret
	call	getATemp
	mov	bl, cUsrTemp
	add	bl, 5
	mov	al, cActTemp
	cmp	al, bl
	jbe	sm_norm
	call	ringAlm
	jmp	sm_ret
sm_norm:call	bin2bcd
	call	setDisp0
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
	cmp	ticks, 200
	jae	sm_x3
	jmp	sm_x2
sm_x3:	jmp	sm_loop
sm_ret:	ret
strtMach endp

end

; ISRs


inc	minutes
iret

mov	al, 0ffh
iret

inc	ticks
iret

mov	dl, 0
iret
