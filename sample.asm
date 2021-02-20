BITS 16

 start:
    mov ax, 07C0h           ; Set up 4K stack space after this bootloader
    add ax, 288             ; (4096 + 512) / 16 bytes per paragraph
    mov ss, ax
    mov sp, 4096

    mov ax, 07C0h           ; Set data segment to where we're loaded
    mov ds, ax


    mov si, text_string     ; Put string position into SI
    call print_string       ; Call our string-printing routine

    jmp $                   ; Jump here - infinite loop!


    text_string db 'Hello World by Pratik!', 0


 print_string:                   ; Routine: output string in SI to screen

    ; mov ah, 0Eh             ; int 10h 'print char' function
    ; mov bh, 0x00
    ; mov bl, 0x03

 ; .repeat:
    ; lodsb                   ; Get character from string
    ; cmp al, 0
    ; je .done                ; If char is zero, end of string
    ; int 10h                 ; Otherwise, print it
    ; jmp .repeat

 ; .done:
    ; ret

 .repeat:
    mov ah, 09h             ; int 10h 'print char' function
    mov bh, 0x00
    mov bl, 0x03
    mov cx, 01h
    mov al, [si]
    inc si 		    ; Get character from string
    cmp al, 0
    je .done                ; If char is zero, end of string
    int 10h                 ; Otherwise, print it
    mov bh, 00h
    mov ah, 03h
    int 10h
    mov ah, 02h
    mov bh, 00h
    inc dl
    int 10h
    jmp .repeat

 .done:
    ret


    times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
    dw 0xAA55               ; The standard PC boot signature
