#String Reversal in Python

#######################
#1
print("method 1")

s = "Python"
output = s[::-1]
print(output)  # nohtyP

#######################
#2
print("method 2")
s = "Python"
r = reversed(s)
output = "".join(r)
print(output)  # nohtyP

#######################
#3
print("method 3")
s = "Python"
output = ""
i = len(s) - 1

while i >= 0:
    output = output + s[i]
    i = i - 1

print(output)  # nohtyP

#######################
#4
print("method 4")

s = "Python"
r = reversed(s)
print(r, '---', type(r))  # shows 

#########################
#5
print("method 5")

# Convert to list
print(list(reversed(s)))

# Join into string
print("".join(reversed(s)))

# Loop through
for ch in reversed(s):
    print(ch, end="")
print()