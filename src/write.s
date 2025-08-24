.text
.globl _main
.p2align 2

_main:
    mov     w0, #1 // 0 is STDERR, 1 is STDOUT, 2 is STDIN
    adrp    x1, L_.buf@PAGE // Load the address of the buffer into x1
    add     x1, x1, L_.buf@PAGEOFF // Load the end address of the buffer into x1
    mov     x2, #L_.len // length of the buffer
    bl      _write
    mov     x0, #0
    ret

// x0, x1, x2 are the arguments. Inserting into Write() then outputting to #1 being STDOUT.
// returns are always sent to X0 so you should always use X0 to check the return value.
// # is an immediate constant, moving the value of the variable into the register.
// L_.len is not an address, it's a constant value.
// W0 is 32 bits where as X0 is 64 bits.
// ssize_t write(int fd, const void *buf, size_t count);
// first param is a 32 bit int. Second param is a pointer to the buffer. Third param is the size of the buffer.
// Arguments (64 bit ints / pointers) go into X0 - X7 registers.
// Arguments (32 bit ints / pointers) go into W0 - W7 registers.
// V0 - V7 are used for doubles or floating point values.

.section __TEXT,__cstring
L_.buf: .asciz "Hello, World!\n"
.set L_.len, . - L_.buf