
n = int(input("Enter the number: "))
original = n
reverse = 0


while n > 0:
    digit = n % 10
    reverse = (reverse * 10) + digit
    n = n // 10


if original == reverse:
    print(f"{original} is a Palindrome number.")
else:
    print(f"{original} is Not a palindrome.")
