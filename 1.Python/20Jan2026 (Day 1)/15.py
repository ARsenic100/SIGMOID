s8 = "ABCDEFGHIJ"
print(s8[1:4])      # Start index to End-1
print(s8[1:8:2])    # With step
print(s8[1:800])    # Slice beyond length does not raise error
print(s8[-2:-8:-1]) # Negative slice

# Reverse string
print(s8[::-1])