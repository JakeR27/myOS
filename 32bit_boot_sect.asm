; A boot sector by Jake Bailey-Saltmarsh that enters 32bit protected mode
[org 0x7c00]

    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm

    jmp $

%include "16bit_print_string.asm"
%include "32bit_gdt_setup.asm"
%include "32bit_print_string.asm"
%include "32bit_switch_to_pm.asm"

[bits 32]

BEGIN_PM:
    
    mov ebx, MSG_PROTECTED_MODE
    call print_string_pm

    jmp $

MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROTECTED_MODE db "Successfully transfered to 32-bit Protected Mode", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55