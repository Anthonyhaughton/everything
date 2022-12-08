def main():
    dollars = dollars_to_float(input("How much was the meal? "))
    percent = percent_to_float(input("What percentage would you like to tip? "))
    tip = dollars * percent/100.0
    print(f"Leave ${tip:.2f}")

def dollars_to_float(d):
    dollars_to_float = float(d[1:])
    return dollars_to_float
def percent_to_float(p):
    percent_to_float = float(p[:2])
    return percent_to_float

main()