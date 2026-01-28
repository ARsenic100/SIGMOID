class Employee:
    # Class Attribute
    numberOfWorkingHours = 40

employeeOne = Employee()
employeeTwo = Employee()

print(employeeOne.numberOfWorkingHours)
print(employeeTwo.numberOfWorkingHours)

# Changing class attribute value
Employee.numberOfWorkingHours = 60
print(employeeOne.numberOfWorkingHours)
print(employeeTwo.numberOfWorkingHours)

# Creating instance attributes
employeeOne.name = 'Arjun'
employeeTwo.name = 'Ravi'
print(employeeOne.name)
print(employeeTwo.name)

# Modifying class attribute using an object
employeeOne.numberOfWorkingHours = 30

print(employeeOne.numberOfWorkingHours)  # Instance-level change
print(employeeTwo.numberOfWorkingHours)  # Reflects class-level value
print(Employee.numberOfWorkingHours)     # Class-level value