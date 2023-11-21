# Get user input
camelCase = input('camelCase: ')

# Print "snake_case: "
print('snake_case: ', end = '')

# Loop through every letter
for letter in camelCase:

    # Check if letter is upper case
    if letter.isupper():

        # Print underscores and the letter in lowercase
        print(f'_{letter.lower()}', end = '')

    # Otherwise, print letter
    else:
        print(letter, end = '')

# Print space in the end
print()