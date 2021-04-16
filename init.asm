; initialize 8255 (1)
; portA = output / mode0
; portB = output / mode0
; portC = input:output / BSR
; 1   00 0 1   0 0 0
mov	al, 10001000b
out	creg1, al
out	disp12,00h
out	disp34,00h

; initialize 8255 (2)
; portA = input / mode0
; portB = input / mode0
; portC = output / BSR
; 1   00 1 0   0 1 0
mov	al, 10010010b
out	creg2, al

; set default values
mov	usrTemp, 30h
mov	usrWegt, 02h
