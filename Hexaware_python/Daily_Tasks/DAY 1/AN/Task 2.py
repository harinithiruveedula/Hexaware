#Write a program to calculate the roots of a quadratic equation.
# Find if the roots are real roots,imaginary roots,equal roots.

from math import *

a=int(input("Enter  A value: "))
b=int(input("Enter  B value: "))
c=int(input("Enter  C value: "))

# finding discriminant
D = (b**2 )- (4*a*c)

if D>0:
    print("it has Two real and distinct roots")
    root1 = (-b + sqrt(D)) / (2 * a)
    root2 = (-b - sqrt(D)) / (2 * a)
    print("The root are{0} and {1} ".format(root1,root2))
elif D==0:
    print("it has Two real and equal roots")
    root1 = (-b)/(2*a)
    root2 = (-b)/(2*a)
    print("The root are{0} and {1} ".format(root1,root2))
else:
    print("it has imaginary roots")
    real_part = -b / (2 * a)
    imaginary_part = sqrt(abs(D)) / (2 * a)
    print("The root are{0} and {1} ".format(real_part,imaginary_part))

