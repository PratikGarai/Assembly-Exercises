[BITS 16]
[ORG 0x7C00]

MOV AX, 19
INT 16
CALL PrintString
; MOV AX, 3
; INT 16
JMP $

PrintString :
MOV SI, HelloWorld

nextcharacter :
MOV AL, [SI]
INC SI
OR AL, AL
JZ exit_function
CALL PrintCharacter
JMP nextcharacter
exit_function :
RET

PrintCharacter :
MOV AH, 0x0E
MOV BH, 0x00
MOV BL, 0x0A
INT 0x10
RET

HelloWorld db 'My name is Pratik Garai', 0;

TIMES 510 - ($ - $$) db 0
DW 0xAA55
