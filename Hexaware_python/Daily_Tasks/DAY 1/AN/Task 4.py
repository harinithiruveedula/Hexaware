
service=int(input("Enter the service: "))
current_salary=int(input("Enter the salary: "))
if service>=10:
    bonus=current_salary*0.10
    updated_salary=current_salary+bonus
    print("The salary is{0}".format(updated_salary))
elif service>=5 and service<10:
    bonus = current_salary * 0.05
    updated_salary = current_salary + bonus
    print("The salary is{0}".format(updated_salary))
elif service>=3 and service<5:
    bonus = current_salary * 0.03
    updated_salary = current_salary + bonus
    print("The salary is{0}".format(updated_salary))
else:

    print("no bonus is given")




