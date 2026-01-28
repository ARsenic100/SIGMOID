def f1():
    print("Python as a functional programming language")
    print("Python as a functional programming language")
    print("Python as a functional programming language")
    print("Python as a functional programming language")
    print("Python as a functional programming language")

# Function call
f1()


def square_number(num):
    print(num * num)

square_number(5)
square_number(6)


def add(num1, num2):
    return num1 + num2

result = add(3, 5)
print(result)

print(add(7, 9))


def calc(num1, num2):
    sum_val = num1 + num2
    diff = num1 - num2
    prod = num1 * num2
    div = num1 / num2
    return sum_val, diff, prod, div  # Packing tuple

# Unpacking tuple
a, b, c, d = calc(10, 2)
print(a)
print(b)
print(c)
print(d)

print(type(calc(10, 2)))