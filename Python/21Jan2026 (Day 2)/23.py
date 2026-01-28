###################### Lambda function ##########################
def square_number(n):
    print(n * n)

square_number(5)

sqr = lambda n: n * n
print('The square of 5 is', sqr(5))
print('The square of 8 is', sqr(8))

def add(n1, n2):
    return n1 + n2

result = add(3, 5)
print(result)

add1 = lambda n1, n2: n1 + n2
print('The sum of 5+12 is', add1(5, 12))
print('The sum of 8+6 is', add1(8, 6))