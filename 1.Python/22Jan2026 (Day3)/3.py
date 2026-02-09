#Exceptional Handling

#without exp handling
print("Hello, World")
print(10/0)
print("Hello, Again")

#with exceptional handling
print("Hello, World")
try:
    print(10/0)
except ZeroDivisionError:
    print("Divide by zero is not possible. Continuing program execution.")
print("Hello, Again")