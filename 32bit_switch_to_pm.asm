[bits 16]

; switch to protected mode
switch_to_pm:
    cli                     ; Turn off interrupts until we create handlers for this
    lgdt [gdt_descriptor]   ; Load our GDT which specifies segments

    mov eax, cr0            ; To switch we need to set this register
    or eax, 0x1             ; Set first bit to 1
    mov cr0, eax            ; "save" to the register

    jmp CODE_SEG:init_pm    ; Make a "far" jmp to 32bit code
                            ; This forces CPU to flush all of its
                            ; optimisation and pipelining stuff
                            ; Eliminates 16bit executing 32 bit etc

[bits 32]
; Initialise registers and stack, as now in protected mode
init_pm:
    mov ax, DATA_SEG    ; Old segments are meaningless, replace them
    mov ds, ax          ; with data seg address
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000    ; Update stack position (pointers) so the 
    mov esp, ebp        ; stack is at top of free space

    call BEGIN_PM