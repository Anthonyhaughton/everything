weight = input('What is your weight? ')
height = input('What is your height? ')

bmi = int(weight) / float(height) ** 2
print(f'Your BMI is: {bmi}')