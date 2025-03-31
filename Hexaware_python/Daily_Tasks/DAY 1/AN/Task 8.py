
n = int(input("Enter the number: "))
original = n
sum_of_cubes = 0


while n > 0:
    digit = n % 10
    sum_of_cubes += digit ** 3
    n = n // 10


if sum_of_cubes == original:
    print(f"{original} is an Armstrong number.")
else:
    print(f"{original} is not an Armstrong number.")
