l1=[1,2,3]
l2= l1.copy()

print('Before change: ')
print('l1:', l1)
print('l2:', l2)

l1.append(4)

print('After change')
print('l1:', l1)
print('l2:', l2)


############################################################
l1=[1,2,[3,4]]
l2= l1.copy()

print('Before change: ')
print('l1:', l1)
print('l2:', l2)

l1[2].append(99)     #shallow copy-- nested objects are still references to the same inner objects.

l1.append(5)

print('After change')
print('l1:', l1)
print('l2:', l2)
