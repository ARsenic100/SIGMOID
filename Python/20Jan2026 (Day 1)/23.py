l2 = [1, 2, "Hello", "Python", 5]
print(l2)
print(type(l2))
print(id(l2))

print(l2[0])
print(type(l2[0]))
print(id(l2[0]))

l2[0] = 'Modified Value'
print(l2[0])
print(type(l2[0]))
print(id(l2[0]))
print(l2)
print(type(l2))
print(id(l2))

l3 = l2
print(l3)
print(l2 is l3)

l4 = l3 * 2
print(l4)

l5 = l4 + l3
print(l5)