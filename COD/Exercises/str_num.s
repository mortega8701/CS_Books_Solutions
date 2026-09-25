.global main

.data
str: .byte 0x32, 0x33, 0x34, 0x0 # 234

.text
main:
    lui     x10, %hi(str)
    addi    x10, x10, %lo(str)
    jal     x1, STR_NUM
idle:
    jal     x0, idle
    
STR_NUM:                    # int stringToNumber(char* ptrStr)
    addi    x2, x2, -16     # Save to stack
    sw  x1, 0(x2)
    sw  x9, 4(x2)
    sw  x18, 8(x2)
    sw  x19, 12(x2)

    addi    x5, x0, 0x30    # ASCII Numbers position
    addi    x6, x0, 0xA     # Ammount of numbers (10)
    addi    x19, x0, 0      # accum = 0
    lbu     x18, 0(x10)     # readChar = *ptrStr load first character
    addi    x9, x0, -1      # first negative to make positive as default if no sign is specified
    addi    x7, x0, 0x2D
    beq     x18, x5, NEXT   # if (readChar == “-”) sign = -1
    addi    x9, x0, 1
    addi    x7, x0, 0x2B
    beq     x18, x5, NEXT   # if (readChar == “+”) sign = 1
    jal     LOOP
NEXT:
    addi    x10, x10, 1     # ptrStr++
LOOP:
    lbu     x18, 0(x10)     # readChar = *ptrStr load first character
    beq     x18, x0, SUCC   # if (readChar != “\0”)
    sub     x18, x18, x5    # x18 = string to number
    blt     x18, x0, ERROR
    bge     x18, x6, ERROR  # if (readChar >= 0 || readChar <= 9)
    mul     x19, x19, x6    # accum *= 10
    add     x19, x19, x18   # accum += readChar
    addi    x10, x10, 1     # ptrStr++
    jal     LOOP

ERROR:
    addi    x10, x0, -1     # return -1
    jal     END
SUCCESS:
    mul     x10, x19, x9    # return accum*sign
END:
    lw      x1, 0(x2)
    lw      x9, 4(x2)
    lw      x18, 8(x2)
    lw      x19, 12(x2)
    addi    x2, x2, 16      # Restore from stack
    jalr    x0, 0(x1)
