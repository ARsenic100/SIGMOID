###################### INSTANCE METHODS #######################

#Simple Instance Method


class Employee:
    def employeeDetails(self):
        self.name = 'Arjun'

employee = Employee()
employee.employeeDetails()
print(employee.name)

#Instance Method Calling Another Instance Method


class Employee:
    def employeeDetails(self):
        self.name = 'Arjun'

    def welcomeMessage(self):
        print("Welcome to our organization!")

employee = Employee()
employee.employeeDetails()
print(employee.name)
employee.welcomeMessage()

#Static Method in Action


class Employee:
    def employeeDetails(self):
        self.name = 'Arjun'

    @staticmethod
    def welcomeMessage():
        print("Welcome to our organization!")

employee = Employee()
employee.employeeDetails()
print(employee.name)
employee.welcomeMessage()  # Can also call as Employee.welcomeMessage()

     

     
# In this example:

# employeeDetails() initializes an instance variable.
# welcomeMessage() is another instance method that simply prints a message.
# Both methods belong to the object, not the class itself.