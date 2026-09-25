def ConvertBaseNumber(InitNumber, InitBase, FinalBase):
    NumSym = ('0', '1', '2', '3', '4', '5', '6', '7',
              '8', '9', 'A', 'B', 'C', 'D', 'E', 'F')
    Number=tuple(InitNumber)
    decimal=0
    for i in range (0,len(Number)):
        decimal+=NumSym.index(Number[i])*InitBase**(len(Number)-i-1)
    Number=""
    while (decimal>0):
        Number= NumSym[decimal%FinalBase] + Number
        decimal=int(decimal/FinalBase)
    return Number
 
InitBase=int(input("Give a base for a number system (2-16): "))
InitNumber=str(input("Give the number on that number system: "))
FinalBase=int(input("Give the base to convert (2-16): "))
FinalNumber=ConvertBaseNumber(InitNumber, InitBase, FinalBase)
print(FinalNumber)
