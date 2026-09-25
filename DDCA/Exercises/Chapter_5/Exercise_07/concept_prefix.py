N=3

for i in range(1, N+1):
    for j in range(0, 2**N):
        if ((j%(2**i) <= 2**(i+1)) and (j%(2**i) >= 2**(i-1))):
            #k=j-1-(j%(2**i)) + (2**(i-1))
            k=j
            flag = True
        else:
            #k=j
            k=j-(j%(2**i)) + (2**(i-1))
            flag = False
        print (i, j, k, flag)
