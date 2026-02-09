
l5 = [5, 6, 7]
l6 = l5  # reference
l5.append(100)
print("l5:", l5)
print("l6:", l6)

l7 = l5.copy()  # shallow copy
l5.append(222)
print("l5:", l5)
print("l6:", l6)
print("l7:", l7)