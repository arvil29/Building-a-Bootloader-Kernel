void main() {
    volatile unsigned char *graphics_mem = (volatile unsigned char *) 0xb8000;

    unsigned char string[] = "Completed p2a";
    unsigned int i = 0;
    unsigned int j = 0;

    while (string[j] != 0)
    {
        graphics_mem[i] = string[j];
        ++i;
        ++j;
        graphics_mem[i] = 0x0f;
        ++i;
    }
    for(;;) {}
}
