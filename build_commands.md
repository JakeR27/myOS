### ASM to Binary
Run command **1** in VS Code to assemble `.asm` to `.bin`

### Prepare blank floppy disk
Run command **2** in Ubuntu environment (WSL)

### Load bootsector onto floppy disk
Run command **3** in Ubuntu environment (WSL)


### Commands:
1:    `nasm boot_sect.asm -f bin -o boot_sect.bin`

2:    `head -c 1474560 /dev/zero > bootloader.vfd`

3:    `dd status=noxfer conv=notrunc if=boot_sect.bin of=bootloader.vfd`