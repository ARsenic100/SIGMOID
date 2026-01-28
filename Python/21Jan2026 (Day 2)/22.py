#Global Variable
a = 10

def f1():
    print(a)

def f2():
    print(a)

f1()
f2()
print(a)
     
# Local Variables
# Local variables are declared inside a function. They are only accessible within that function, and trying to access them outside raises a NameError.

def f1():
    aa = 10
    print(aa)

def f2():
    # Uncommenting below will raise NameError
    # print(aa)
    pass

f1()
f2()
     
# Using the global Keyword
# The global keyword allows variables declared inside a function to be treated as global. This means they can be accessed and modified outside the function or in other functions.


def f1():
    global ab
    ab = 10
    print(ab)

def f2():
    print(ab)

f1()
f2()

# Key Takeaways
# Global variables are accessible throughout the program.
# Local variables are limited to the function where they are defined.
# The global keyword allows creating or modifying global variables from within a function.