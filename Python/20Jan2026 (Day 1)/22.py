print(range(10))  # Generate numbers from 0 to 9

r1 = range(10)
for n in r1:
    print(n)

r2 = range(10, 20)
for n in r2:
    print(n)

r3 = range(10, 20, 2)
for n in r3:
    print(n)

print(type(r3))
print(r3[1])

# Uncommenting below will raise IndexError
# print(r3[100])

# Uncommenting below will raise TypeError
# r3[1] = 200

l1 = list(range(10))
print(l1)
print(type(l1))