import random
from art import logo
from art import vs
from game_data import data
import os


    

print(logo)




while True:
    rand_dict1 = random.choice(data)
    name1 = rand_dict1['name']
    desc1 = rand_dict1['description']
    country1 = rand_dict1['country']
    followers1 = rand_dict1['follower_count']

    rand_dict2 = random.choice(data)
    name2 = rand_dict2['name']
    desc2 = rand_dict2['description']
    country2 = rand_dict2['country']
    followers2 = rand_dict2['follower_count']
    
    print(f'Compare A: {name1}, a {desc1}, from {country1}.')

    print(vs)

    print(f'Against B: {name2}, a {desc2}, from {country2}.')

    user_pick = input("Who has more followers? Type 'A' or 'B': ")
    print()

    if user_pick == 'A':
        if followers1 > followers2:
            os.system('cls')
            print(f'Correct {name1} has {followers1}k followers and {name2} has {followers2}k.')
            print()
            continue
        else:
            print('Sorry that is incorrect')
            break
    elif user_pick == 'B':
        if followers2 > followers1:
            os.system('cls')
            print(f'Correct {name2} has {followers2}k followers and {name1} has {followers1}k.')
            print()
            continue
        else:
            print('Sorry that is incorrect')
            break
            




