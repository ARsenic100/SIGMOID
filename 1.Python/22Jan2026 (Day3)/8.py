########### OOPS ##########################

class SuperHero:
    def __init__(self, name, crown_color):
        self.name = name
        self.crown_color = crown_color

    def fly(self):
        print(f"{self.name} is flying with a {self.crown_color} crown")

# Create an object (instantiate the class)
superman = SuperHero("Superman", "Red")

# Access object attributes
print(superman.name)
print(superman.crown_color)

# Call the method
superman.fly()

# check if employee has achieved their weekly target

#noun--employee--class
#adjective--name, designation, sales made
#verb-- check if weekly target has been achieved

class Employee:
    name = "Arjun"
    designation = "Sales Executive"
    salesMadeThisWeek = 6

    def hasAchievedTarget(self):
        if self.salesMadeThisWeek >= 5:
            print("Target has been achieved")
        else:
            print("Target has not been achieved")

# Create first object
employeeOne = Employee()
print(employeeOne.name)
print(employeeOne.designation)
employeeOne.hasAchievedTarget()

# Create another object
employeeTwo = Employee()
print(employeeTwo.name)
print(employeeTwo.designation)


