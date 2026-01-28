se2 = set()
print(se2)
print(type(se2))

se3 = set(range(5))
print(se3)
print(type(se3))

se3.add(10)
print(se3)

se3.pop()
print(se3)

l1 = ['a', 'b']
l2 = ['x', 'y']
se3.update(l1, l2)
print(se3)

se4 = se3.copy()
print(se4)
print(type(se4))
     
se4.remove(10)
print(se4)

se4.pop()
print(se4)

se4.clear()
print(se4)