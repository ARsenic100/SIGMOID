list1 = ['a', 'b', 'c', 'd', 'e', 'f']
list2 = ['a', 'b', 'c']
list3 = [e for e in list1 if e not in list2]
print(list3)

list1 = ['a', 'b', 'c', 'd', 'e', 'f', 'a', 'a']

# Length
print(len(list1))

# Count occurrences
print(list1.count('a'))
print(list1.count('b'))

# Append
list1.append('Hello')
print(list1)

# Insert at index
list1.insert(1, 8888)
print(list1)

# Remove first occurrence
list1.remove('a')
print(list1)

#list operators
l1 = [100, 200, 300]
l2 = l1 + l1
print(l2)

l3 = l1 * 5
print(l3)

print(l1 == l2)   # equality
print(100 in l1)  # membership

l3.clear()
print(l3)  # cleared list


l6 = [[1, 2], [3, 4]]
print(l6)
print(l6[1])     # [3, 4]
print(l6[1][0])  # 3