# Mauris viverra massa id lorem pretium gravida.

if num == 1:
    print(num, "is not a prime.")
elif num > 1:
    for i in range(2, num):
    if (num % i) == 0:
        print(num, "is a prime.")
        break
