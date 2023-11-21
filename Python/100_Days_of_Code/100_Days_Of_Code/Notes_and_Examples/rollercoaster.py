print('Welcome to the park!')
height = int(input('How tall are you? '))
bill = 0
if height >= 120:
  print('You can ride this rollercoaster')

  age = int(input('How old are you? '))
  if age < 12:
    bill = 5
    print('Child tickets are $5.')
  elif age <= 18:
    bill = 7
    print('Youth tickets are $7')
  elif age >= 45 and age <= 55:
    print('You can ride for free!')
  else:
    bill = 12
    print('Adult tickets are $12')

  ticket = input('Do you want a picture? ')
  if ticket == 'Yes':
    bill += 3

  print(f'Your final bill is ${bill}')

else:
  print('You are not tall enough to ride this ride.')
  