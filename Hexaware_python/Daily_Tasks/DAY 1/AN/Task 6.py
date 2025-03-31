from math import *
choice=int(input("Enter your choice: "))

match choice:
    case '1':
        print("Now u need to find area of circle so enter::")
        radius=int(input("Enter the radius: "))
        area=pi*radius*radius
        print("The area of the circle is: ",area)
    case '2':
        print("Now u need to find area of Triangle so enter::")
        base=float(input("Enter the base: "))
        height=float(input("Enter the height: "))
        area=base*height/2
        print("The area of the triangle is: ",area)
    case '3':
        print("Now u need to find area of Rectangle so enter::")
        length=int(input("Enter the lenght: "))
        width=float(input("Enter the width: "))
        area=len*width
        print("The area of the rectangle is: ",area)
    case _:
        print("Invalid operator.")



