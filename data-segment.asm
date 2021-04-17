keyCode db	0EEH, 0EDH, 0EBH, 0E7H	; 7 8 9 T
	db	0DEH, 0DDH, 0DBH, 0D7H	; 4 5 6 W
	db	0BEH, 0BDH, 0BBH, 0B7H	; 1 2 3 B
	db	07EH, 07DH, 07BH, 077H	;   0 S E
keyAct	db	007h, 008h, 009h, 0f0h
	db	004h, 005h, 006h, 0f1h
	db	001h, 002h, 003h, 0f2h
	db	0f5h, 000h, 0f4h, 0f3h


keyBfr	db	?
usrTemp	db	?	;bcd
usrWegt	db	?	;bcd
cUsrTemp db	?	;bin
cUsrWegt db	?	;bin
actTemp	db	?	;bin 0-255
cActTemp db	?	;bin 0-100

minutes	db	?
ticks	dw	?

vlvSts	db	?

cDelay	dw	?

numPac	db	?
avgPac	db	?

vlvOpn	equ	0ffh
vlvCls	equ	00h

tpKG	equ	80
; 80 ticks = 20sec for 1kg

tKey	equ	0f0h
wKey	equ	0f1h
bKey	equ	0f2h
eKey	equ	0f3h
sKey	equ	0f4h

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
