### Correct usage with self for instance attribute

class Employee:
    def employeeDetails(self):
        self.name = 'Arjun'
        self.age = 25
        print('Age', self.age)

    def printEmployeeDetails(self):
        print("Printing employee details in another method")
        print('Name of the employee:', self.name)
        print('Age of the employee:', self.age)

employee = Employee()
employee.employeeDetails()
employee.printEmployeeDetails()
