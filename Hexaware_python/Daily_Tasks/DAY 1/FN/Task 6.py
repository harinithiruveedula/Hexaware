# to print memory allocation of two numbers
num1,num2=int(input("Enter the 1st number: ")),int(input("Enter the 2nd number: "))
adress1=id(num1)
adress2=id(num2)
print("the memory allocation of  {0} and {1} is {2}and {2}".format(num1,num2,adress1,  ))

# by using identity operator checking both are having same adress or not
if(adress1 is adress2):
    print("both adresses are similar")
else:
    print("both adresses are not simlar")