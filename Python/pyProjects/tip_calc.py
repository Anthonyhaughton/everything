print('Welcome to the tip calculator')
bill = float(input('What was the total bill? $'))
tip_percent = int(input('What percentage tip would you like to give? 10, 12, or 15? '))
people_split = int(input('How many people to split the bill? '))

tip = tip_percent / 100
total_tip = bill * tip
total_bill = bill + total_tip
pre_total = total_bill / people_split
# This "{:.2f}".format adds the zero to 33.6 to make it 33.60
total = "{:.2f}".format(pre_total)


print(f'Each person should pay: ${total}')