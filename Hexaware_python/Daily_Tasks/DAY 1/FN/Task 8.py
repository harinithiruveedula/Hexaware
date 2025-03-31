# calculating the amount payable after simple intreset


P = float(input("Enter the principal amount: "))
R = float(input("Enter the annual interest rate : "))
T = float(input("Enter the time period (in years): "))

# Calculating Simple Interest
SI = (P * R * T) / 100

# Calculate Total Amount Payable
total_amount = P + SI

# Display the results
print("Simple Interest: ".format(SI))
print("Total Amount Payable: ".format(total_amount))
