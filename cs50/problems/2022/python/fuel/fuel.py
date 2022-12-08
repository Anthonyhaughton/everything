# Loop forever
while True:
    # Get user input
    gas = input('Fraction: ')
    try:
        # Try to split the fuel
        x,y = gas.split("/")
        # Convert into integers
        new_x = int(x)
        new_y = int(y)
        # Calculate the percentage
        f = new_x / new_y
        # Check if it's less than 1 and stop the loop
        if f <= 1:
            break
    except (ValueError, ZeroDivisionError):
        pass

# Multiply percent by 100
percent = round(f * 100)
# Check if percentage is less than 1, print E
if percent <= 1:
    print('E')
# Check if percentage is greater than 99, print F
elif percent >= 99:
    print('F')
# Otherwise print the %
else:
    print(f'{percent}%')