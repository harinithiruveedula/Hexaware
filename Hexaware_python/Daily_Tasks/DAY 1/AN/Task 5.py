#  Use the arithmetic operators to perform match case statement.
x = float(input("Enter the first number: "))
y = float(input("Enter the second number: "))
operator = input("Enter the operator (+, -, *, /, %): ")

match operator:
    case '+':
        result = x + y
    case '-':
        result = x - y
    case '*':
        result = x * y
    case '/':
        if y != 0:
            result = x / y
        else:
            print("Error: Division by zero is not allowed.")
            result = None
    case '%':
        if y != 0:
            result = x % y
        else:
            print("Error: Modulus by zero is not allowed.")
            result = None
    case _:
        print("Invalid operator.")
        result = None


if result is not None:
    print(f"Result: {result:.2f}")
