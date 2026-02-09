#Generator

list_comp = [x*x for x in range(1, 10)]
print(list_comp)

gen_exp= (x * x for x in range(1, 10**20))
print(gen_exp)
print(type(gen_exp))



# This will lead to a memory error — do not execute!
# list_comp = [x * x for x in range(1, 10**20)]
# print(list_comp)

# This will not lead to memory issues
g = (x * x for x in range(1, 10**20))
print(g)
print(next(g))
print(next(g))
print(next(g))
print(next(g))

#Generator function with yield
def generator_demo():
    for i in range(1, 5):
        print("Generating:", i)
        yield i

gen = generator_demo()
print(next(gen))
print(next(gen))
print(next(gen))
print(next(gen))

#Checking memory efficiency


import sys

list_comp = [x * x for x in range(1000)]
gen_expr = (x * x for x in range(1000))

print("List size:", sys.getsizeof(list_comp))
print("Generator size:", sys.getsizeof(gen_expr))



