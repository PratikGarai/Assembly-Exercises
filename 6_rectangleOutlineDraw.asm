[BITS 16]
[ORG 0x7C00]

MOV AX, 19
INT 16

MOV AH, 0x06
MOV AL, 0
CALL DrawBox
CALL FillVoid
JMP $

DrawBox :
MOV BH, 0x04
MOV CH, 1
MOV CL, 1
MOV DH, 23
MOV DL, 38
INT 0x10
RET


FillVoid :
MOV BH, 0x00
MOV CH, 2
MOV CL, 2
MOV DH, 22
MOV DL, 37
INT 0x10
RET


TIMES 510 - ($ - $$) db 0
DW 0xAA55
