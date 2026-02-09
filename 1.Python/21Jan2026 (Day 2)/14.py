d1 = {}
print(d1)
print(type(d1))


d2 = dict()
print(d2)
print(type(d2))


d2['stock'] = 8
d2['savings'] = 5
print(d2)

d3 = d2.copy()  #shallow copy
d4 = d2   #deep copy
d2.clear()
print(d2)

del d2
# Uncommenting below will raise NameError because d2 is deleted
# print(d2)

print(d3)
print(d4) #deep copy


print(d3.keys())
print(d3.values())

for k, v in d3.items():
    print(k, "-", v)
     