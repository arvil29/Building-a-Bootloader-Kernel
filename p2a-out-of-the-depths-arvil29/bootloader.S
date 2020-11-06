.section .text #assembled in .text section of binary
.code16 #16bit mode
.global _start #creates label _start
_start:
    #setting up our stack segment register
    movw $0x7c0, %ax
    addw $0x20, %ax
    movw %ax, %ss #base of stack
    movw $0x1000, %sp #set stack ptr to point to base+4kb offset

    #setup data segment
    movw $0x7c0, %ax
    movw %ax, %ds 

#where the msg is relative to where code was loaded
.set OFFSET, my_msg - _start
movw $OFFSET, %si

movb $0xe, %ah #sets BIOS call number
mov $0, %dx #clears dx

#BIOS only prints 1 char to screen so we need loop to print string
print_loop:
    lodsb #copy char to a1
    cmp $0, %al #check if a1 is 0
    je done #if 0 then done
    int $0x10 #maybe prints char?
    jmp print_loop #keep looping

done:
    hlt #halt instruction
    jmp done

my_msg:
    .asciz "Hello from the bootloader!\n"


#we've been writing bootloader code so far of MBR
#now we need to set the magic number part(last 2 bytes) of MBR
remainder:
    .set MBR_REMAINDER, 510 - (remainder - _start)
    .fill MBR_REMAINDER, 1, 0x0
    .word 0xaa55