import module1

print(module1.x)
module1.add123(5, 6)

import module1 as m
m.add123(10, 20)

from module1 import prod123
prod123(2, 6)
#You can also alias imported members.

from module1 import prod123 as p
p(3, 8)

import module1
print(dir(module1))
#To view Python built-ins:

print(__builtins__)

import math
print(dir(math))
print(math.sqrt(16))
print(math.factorial(5))