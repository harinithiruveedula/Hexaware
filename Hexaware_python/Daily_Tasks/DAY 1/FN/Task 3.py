#area of cylinder
from math import  *
radius=float(input("Enter the radius of : "))
height=float(input("Enter the height of : "))

area=(2*pi*(radius**2))+(2*pi*radius*height)
print("The area of cylinder is : {0}".format(area))