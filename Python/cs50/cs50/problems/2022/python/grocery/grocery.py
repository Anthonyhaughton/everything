# Create empty dict
items = {}
#Create Infinite Loop
while True:
    try:
        # Get user input
        food = input().lower()
        # Check if food is already in the dict
        if food in items:
            # If it is add one to the count
            items[food] += 1
        else:
            # Otherwise add the food for the first time
            items[food] = 1

    except EOFError:
        # Print all items in order. Also print the keys and values.
        for key in sorted(items.keys()):
            print(items[key], key.upper())
        break

