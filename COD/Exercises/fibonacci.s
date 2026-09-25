.global main

.text
main:
    addi    x10, x0, 0x7
    jal     x1, FIB
idle:
    jal     x0, idle

FIB:                            # int fib(int n)
    addi    x2, x2, -16         # save to stack
    sw      x1, 0(x2)
    sw      x18, 4(x2)
    sw      x19, 8(x2)

    addi    x28, x0, 0
    bne     x10, x28, IFELSE    # if(n==0)
    addi    x10, x0, 0          # return 0
    jal     x0, DONE
IFELSE:
    addi    x28, x0, 1
    bne     x10, x28, ELSE      # if(n==1)
    addi    x10, x0, 1          # return 1
    jal     x0, DONE
ELSE:
    add     x18, x0, x10        # x18 = n
    addi    x10, x18, -1
    jal     x1, FIB             # fib(n-1)
    add     x19, x0, x10
    addi    x10, x18, -2
    jal     x1, FIB             # fib(n-2)
    add     x10, x19, x10       # x10 = fib(n-1) + fib(n-2)
DONE: 
    lw      x1, 0(x2)
    lw      x18, 4(x2)
    lw      x19, 8(x2)
    addi    x2, x2, 16          # load from stack
    jalr    x0, 0(x1)           # return fib(n)
