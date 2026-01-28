l2 = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
print(l2)
print(l2[2:7])      # elements from index 2 to 6
print(l2[2:9:2])    # every 2nd element from index 2 to 8
print(l2[2:700])    # slicing beyond length is safe
print(l2[::-1])     # reversed list
print(l2[6:0:-2])   # reverse step slicing