; GDT
gdt_start:

gdt_null: ; Mandatory null descriptor
    dd 0x0 ; dd means define a double word eg 4B (32b)
    dd 0x0

gdt_code: ; Code segment descriptor
    ; we will use the following info for our descriptor
    ; base = 0x0, limit = 0xfffff
    ; 1st set of flags:
    ; (present)1 (privilage)00 (descriptor type)1 -> 1001b
    
    ; type flags:
    ; (code)1 (conforming)1 (readable)1 (accessed)0 -> 1010b

    ; 2nd set of flags:
    ; (granularity)1 (32bit def)1 (64bit seg)0 (AVL)0 -> 1100b

    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; 1st flags and type flags
    db 11001111b    ; 2nd flags, limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_data: ; Data segment descriptor
    ; Same as code segment except for:
    ; type flags:
    ; (code)0 (expand down)0 (writable)0 (accessed)0 -> 0010b

    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10010010b    ; 1st flags and type flags
    db 11001111b    ; 2nd flags, limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_end: ; This is so that the assembler can calculate the size of descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT is always 1 less than true size
    dd gdt_start                ; Start addr of our GDT


; Define some constants for GDT offsets
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
