# Ask user for their name
# Adding Methods in to first line to clean up code

name = input ("What's your name? ").strip().title()

# Removes spaces from user input. Also Uppercase it. This is called a "method"
#name = name.strip().title()

# Capitalize users name but only the first name
#name = name.capitalize()

# Capitalize first letter of every word/ First and Last
#name = name.title()

# Say hello to user by using f str
print(f"hello, {name}")