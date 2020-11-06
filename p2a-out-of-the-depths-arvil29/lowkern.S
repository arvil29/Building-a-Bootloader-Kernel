.section .multiboot_hdr
.set MULTIBOOT_MAGIC, 0xe85250d6
.set ARCH, 0x0

multiboot_hdr:
    .long MULTIBOOT_MAGIC #tells bootloader that this is Multiboot-compliant kernel
    .long ARCH #tells bootloader what architecture the bootloader is compiled for
    .long hdr_end - multiboot_hdr #find length of multiboot header
    .long -(MULTIBOOT_MAGIC + (hdr_end - multiboot_hdr)) #makes sure header is not corrupt

    /* no special tags */
    #tells bootloader we're not requesting special info from it
    .word 0, 0
    .long 8

hdr_end:

.section .text

.code32 #32bit mode

.global kernel_entry
kernel_entry:
    movb $'0',  0xb8000 #goes to graphics memory
    movb $0x0f, 0xb8001 #oxof means white on black background
    movb $'K',  0xb8002
    movb $0x0f, 0xb8003

end:
    hlt
    jmp end