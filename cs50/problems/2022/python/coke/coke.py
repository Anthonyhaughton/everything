# Set the starting amount due
amount_due = 50

# Make a while loop to keep running until it hits zero
while amount_due > 0:
    print(f'Amount due: {amount_due}')
    coin = int(input('Insert coin: '))
    # Only allow the numbers in the list to be used
    if coin in [25, 10, 5]:
        amount_due -= coin

change_owed = abs(amount_due)
print(f'Change owed: {change_owed}')