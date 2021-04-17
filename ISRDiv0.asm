pusha
mov	al, cUsrWegt
mov	ah, 0
mov	bl, 0ffh
mul	bl
mov	totPac, ax
popa
iret
