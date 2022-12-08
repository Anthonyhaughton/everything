word = input('Input: ')
print('Output: ', end = '')
for letter in word:
    if letter.lower() in ['a', 'e', 'i', 'o', 'u']:
        letter += ''
        #print(f'{letter}', end = '')
    else:
        print(letter, end = '')
print()