#Write a python program to display the total marks
# and average of 3 subjects and grade then accordingly.

sub1=int(input("Enter the subject 1 marks: "))
sub2=int(input("Enter the subject 2 marks: "))
sub3=int(input("Enter the subject 3 marks: "))
total=sub1+sub2+sub3
print("the total marks=",total)
avg=total/3
print("the average marks=",avg)
if avg>=80:
    print("Grade is A")
elif (avg>=70 and avg<=79):
    print("Grade is B")
elif (avg>=60 and avg<=69):
    print("Grade is C")
else:
    print("Fail")

