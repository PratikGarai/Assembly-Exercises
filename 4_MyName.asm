[BITS 16]
[ORG 0x7C00]

MOV AX, 19 		; changing video mode to enable colors
INT 16 			; calling interrupt
CALL PrintString
JMP $

PrintString : 
MOV SI, HelloWorld 	; Move string to register

nextcharacter :
LODSB 			; load next character into AL, increment SI
OR AL, AL 		; check if end of string
JZ exit_function
CALL PrintCharacter
JMP nextcharacter 	; write next character
exit_function : 	
RET 			; end of loop

PrintCharacter :
MOV AH, 0x0E 		; Teletype output
MOV BH, 0x00 		; First Page
MOV BL, 0x0A 		; Color : Greem
INT 0x10 		; print a character
RET

HelloWorld db 'My name is Pratik Garai', 0;

TIMES 510 - ($ - $$) db 0
DW 0xAA55
