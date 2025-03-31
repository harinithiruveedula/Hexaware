# calculating the amount payable after compound intrest

P = float(input("Enter the principal amount: "))
R = float(input("Enter the annual interest rate (in %): "))
T = float(input("Enter the time period (in years): "))

# Calculating Total Amount using Compound Interest formula
A = P * (1 + R / 100) ** T

# Calculate Compound Interest
CI = A - P

# Display the results
print("Compound Interest: {:.2f}".format(CI))
print("Total Amount Payable: {:.2f}".format(A))
