# Define salary variables
base_salary = int(input('How much do you make a year? '))
bonus = int(input('If you recieved a bouns enter the number else, put in "0" '))
hours_worked = int(input('How many hours do you work? '))

# Define the function that calculates the total salary
def calculate_salary(base_salary, bonus, hours_worked):
    total_salary = (base_salary + bonus) * (hours_worked/40)
    return total_salary

# Calculate the total salary
total_salary = calculate_salary(base_salary, bonus, hours_worked)
print("Your total salary is ", total_salary)