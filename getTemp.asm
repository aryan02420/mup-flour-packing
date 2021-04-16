getTemp proc near

	;make cx 1
	;start adc conversion
	;loop till cx != 0
	;store temp in al
	ret
getTemp endp

;ISRTemp will make cx = 0
