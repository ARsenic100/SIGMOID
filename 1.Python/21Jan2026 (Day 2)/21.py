#Positional argument
###########################################

def add(num1, num2):
    return num1 + num2

result = add(3, 5)
print(result)
     
#keyword argument
############################################
def greet(name, msg):
    print("Hello!", name, msg)

# Positional arguments
greet('Ravi', 'Good Morning')
greet('Good Morning', 'Ravi')

# Keyword arguments
greet(msg='Good Morning', name='Ravi')

# Combination of positional and keyword
greet('Ravi', msg='Good Morning')

# Invalid usage: positional after keyword would raise SyntaxError
# greet('Good Morning', name='Ravi')

#Default argument
######################################################################

def greet(name='Guest'):
    print("Hello!", name)

# Providing argument
greet('Ravi')

# Using default value
greet()

#Variable name argument
########################################################################
def sum(*n):
    total = 0
    for e in n:
        total += e
    print("The Sum is", total)

sum()
sum(10, 20)
sum(10, 20, 30)
