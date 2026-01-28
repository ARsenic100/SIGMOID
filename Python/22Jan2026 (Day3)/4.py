print("Division Operation")
try:
    num1 = int(input("Enter numerator: "))
    num2 = int(input("Enter denominator: "))
    print("The quotient is", num1 // num2)
except ZeroDivisionError:
    print("Cannot divide by zero!")
except ValueError:
    print("Please enter valid integer values only.")
except:
    print("Unexpected error occurred.")
finally:
    print("Cleanup code inside the finally block.")
print("Program Completed.")