keyCode db	EEH, EDH, EBH, E7H	; 7 8 9 T
	db	DEH, DDH, DBH, D7H	; 4 5 6 W
	db	BEH, BDH, BBH, B7H	; 1 2 3 B
	db	7EH, 7DH, 7BH, 77H	;   0 S E
keyAct	db	07h, 08h, 09h, f0h
	db	04h, 05h, 06h, f1h
	db	01h, 02h, 03h, f2h
	db	f5h, 00h, f4h, f3h


keyBfr	db	?
usrTemp	db	?
usrWegt	db	?

vlvSts	db	?
; 00 => closed, not flowing
; ff => open, flowing

tKey	equ	f0h
wKey	equ	f1h
bKey	equ	f2h
eKey	equ	f3h
sKey	equ	f4h

disp1	equ	00h
disp2	equ	02h
keyPad	equ	04h
creg1	equ	06h

tempInp	equ	10h
portB2	equ	12h
portC2	equ	14h
creg2	equ	16h

vlvOpn	equ	0ffh
vlvCls	equ	00h


timrA	equ	20h
timrB	equ	22h
timrC	equ	24h
timrCreg equ	26h
