def BinaryToDecimal(A):
    n=0
    for i in range (0,len(A)):
        n=n+int(A[i])*2**(len(A)-i-1)
    return n
 
A=str(input("Give a binary number: "))
n=BinaryToDecimal(A)
print(n)
