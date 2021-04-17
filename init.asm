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
