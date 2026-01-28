#tuples

t1 = (10, 20, 30, 40)
print(t1)
print(type(t1))


t2 = 1, 2, 3, 4
print(t2)
print(type(t2))

t3 = (10)
print(t3)
print(type(t3))


t4 = (10,)
print(t4)
print(type(t4))

#convering list to tuple


l1 = [1, 2, 3]
t5 = tuple(l1)
print(t5)
print(type(t5))
print(t5[0])
print(t5[-1])

# Uncommenting below will raise IndexError
# print(t5[100])

# Uncommenting below will raise TypeError
# t5[0] = 999

#tuple operations

print('t2', t2)
print('t5', t5)

# Concatenation
t6 = t2 + t5
print('t6', t6)

# Repetition
t7 = t6 * 2
print('t7', t7)

print('Length of t7', len(t7))
print(t7.count(1))  # number of occurrences
print(t7.index(1))  # first occurrence

print(sorted(t7))  # sort elements
print(sorted(t7, reverse=True))  # reverse order

print(min(t7))
print(max(t7))


a = 10; b = 20; c = 30; d = 40
t8 = a, b, c, d
print(t8)
print(type(t8))

# Unpacking
p, q, r, s = t8
print("p=", p, "q=", q, "r=", r, "s=", s)