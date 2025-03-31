#-------------------------TASK 1---------------
income=int(input("Enter the income: "))

if income<150000:
    charges=0
    print("the person has no tax")
    print("The person has a tax of ", charges)
    print("the amount to be paid is ", income + charges)
elif income>150000 and  income<300000:
    charges=income*0.10
    print("The person has a tax of ",charges)
    print("the amount to be paid is ",income+charges)
elif income>300000 and income<500000:
    charges=income*0.20
    print("The person has a tax of ",charges)
    print("the amount to be paid is ",income+charges)
else:
    charges=income*0.30
    print("The person has a tax of ",charges)
    print("the amount to be paid is ",income+charges)

