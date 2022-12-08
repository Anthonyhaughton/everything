def main():
    number = float(input("How much do you make an hour? "))
    salary = get_salary(number)
    tax = .35 * salary
    gross = salary - tax
    print(f"You make ${gross:,} a year. ")

def get_salary(s):
   get_salary = s * 40 * 52
   return get_salary

main()