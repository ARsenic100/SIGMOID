#Create a decorator function
def sample_decorator(func):
    def wrapper():
        print("Befor the function is called ")
        func()
        print("After the function is called ")
    return wrapper

#use a decorator function
@sample_decorator
def say_hello():
        print("Hello, world")

say_hello()


################## 2 ###########################

def smart_division(func):
    def inner(a, b):
        print("We are dividing", a, "by", b)
        if b == 0:
            print("Invalid operation: division by zero is undefined")
            return
        else:
            return func(a, b
            )
    return inner

@smart_division
def division(a, b):
    return a / b


print(division(20, 2))
print(division(20, 0))

################### 3 ##################################

def smart_decorator(func):
    def wrapper(*args, **kwargs):
        print("Function arguments:", args, kwargs)
        result = func(*args, **kwargs)
        print("Function executed successfully.")
        return result
    return wrapper

@smart_decorator
def greet_person(name, age):
    print(f"Hello {name}, you are {age} years old.")

greet_person("Emma", 28)

####################### 4 ###############################

def bold_decorator(func):
    def wrapper():
        return f"{func()}"
    return wrapper

def italic_decorator(func):
    def wrapper():
        return f"{func()}"
    return wrapper

@bold_decorator
@italic_decorator
def formatted_text():
    return "Decorators are powerful!"

print(formatted_text())


########################### 5 ##############################



def log_decorator(func):
    def wrapper(*args, **kwargs):
        with open("app_log.txt", "a") as log_file:
            log_file.write(f"Calling function: {func.__name__}\n")
        result = func(*args, **kwargs)
        with open("app_log.txt", "a") as log_file:
            log_file.write(f"Completed function: {func.__name__}\n")
        return result
    return wrapper

@log_decorator
def multiply(a, b):
    print(f"Multiplying {a} * {b}")
    return a * b

@log_decorator
def order_summary(*items, **details):
    print("Items Ordered:", items)
    print("Order Details:", details)


@log_decorator
def show_profile(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")


@log_decorator
def greet_people(greeting, *names):
    for name in names:
        print(f"{greeting}, {name}!")


greet_people("Hello", "Alice", "Bob", "Charlie")
show_profile(name="John", role="Trainer", skill="Python")
order_summary("Pizza", "Pasta", name="Alex", payment="Card", address="London")
print(multiply(6, 7))
greet_people("Hello", "Raj", "Tina", "Adam")
show_profile(name="Ravi", role="Developer", skill="AWS", sport = "Badminton")