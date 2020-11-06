.section .multiboot_hdr
.set MULTIBOOT_MAGIC, 0xe85250d6
.set ARCH, 0x0

multiboot_hdr:
    .long MULTIBOOT_MAGIC
    .long ARCH
    .long hdr_end - multiboot_hdr
    .long -(MULTIBOOT_MAGIC + (hdr_end - multiboot_hdr))

    /* no special tags */
    .word 0, 0
    .long 8

hdr_end:

.section .text

.code32

create_stack:
    mov boot_stack_start, %esp #setup stack

start_kernel:
    call main #get into C code
    hlt #infinite halt loop never returns