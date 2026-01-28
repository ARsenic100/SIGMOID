##### Constructor ##################

# Class without __init__
class Employee:
    def enterEmployeeDetails(self):
        self.name = 'Arjun'

    def displayEmployeeDetails(self):
        print(self.name)

# Create an object
employee = Employee()
employee.enterEmployeeDetails
employee.displayEmployeeDetails()  # Error if enterEmployeeDetails() not called first

#using init
class Employee:
    def __init__(self):
        self.name = 'Arjun'

    def displayEmployeeDetails(self):
        print(self.name)

# Create an object
employee = Employee()
employee.displayEmployeeDetails()


#Parametrised Constructor
class Employee:
    def __init__(self, name):
        self.name = name

    def displayEmployeeDetails(self):
        print(self.name)

# Create two objects with different names
employeeOne = Employee("Arjun")
employeeTwo = Employee("Raju")

employeeOne.displayEmployeeDetails()
employeeTwo.displayEmployeeDetails()