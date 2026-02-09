##################  Finding Factorial  ###################

#Iterative approach
def fact(num):
    result = 1
    while num >= 1:
        result *= num
        num -= 1
    return result

for i in range(1, 5):
    print('factorial of', i, fact(i))
    
#Recursive approach
def factorial(n):
    if n==0:
        return 1
    return n*factorial(n-1)

for i in range(1, 5):
    print('factorial of', i, factorial(i))
