#  Higher-order functionsssss

######### Using Filter ################

def isEven(x):
    if x % 2 == 0:
        return True
    else:
        return False

l1 = [1, 2, 4, 5, 6, 21, 24, 25]
l2 = list(filter(isEven, l1))
print(l2)

l3 = [11, 21, 42, 52, 61, 21, 24, 257]
l4 = list(filter(lambda x: x % 2 == 0, l3))
print(l4)
     

################# Using Map #####################


l1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
def double_l(x):
    return x * 2
l2 = list(map(double_l, l1))
print(l1)
print(l2)

l3 = [1, 2, 3, 4, 5]
l4 = list(map(lambda x: x * 2, l3))
l5 = list(map(lambda x: x * x, l3))
print('l3', l3)
print('l4', l4)
print('l5', l5)

################ Using Reduce ####################
from functools import reduce

l7 = [1, 2, 3, 4, 5]
res = reduce(lambda x, y: x + y, l7)
print(res)


##################### Function Alias ########################

def greet():
    print("Hello!")

greet()  # Function call

wish = greet  # Alias
wish()  # Function call using alias
