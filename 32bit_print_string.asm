[bits 32] ; Put in 32bit protected mode

; Define some constants
VIDEO_MEMORY equ 0xb800
WHITE_ON_BLACK equ 0x0f

; Prints a null terminated string pointed to by EDX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY   ; Set EDX to start of Vid Mem

print_string_pm_loop:
    mov al, [ebx]   ; Store char at EBX into AL
    mov ah, WHITE_ON_BLACK  ; Store writing style into AH

    cmp al, 0   ; Compare char with 0 to see if at end of string (null term)
    je done ; jump to done if done

    mov [edx], ax   ; Store char abd style at current vid mem location

    add ebx, 1  ; increment the char count
    add edx, 2  ; increment the vid mem location (2 bytes per char so +2)

    jmp print_string_pm_loop    ; repeat until done

print_string_pm_done:
    popa    ; return all register values from stack
    ret     ; return to addr where this was called

