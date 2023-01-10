import random
from art import logo
from art import vs
from game_data import data
import os

print(logo)

def get_celeb():
    rand_dict = random.choice(data)
    name = rand_dict['name']
    desc = rand_dict['description']
    country = rand_dict['country']
    followers = rand_dict['follower_count']
    return name, desc, country, followers


    # rand_dict2 = random.choice(data)
    # name2 = rand_dict2['name']
    # desc2 = rand_dict2['description']
    # country2 = rand_dict2['country']
    # followers2 = rand_dict2['follower_count']

celeb1 = get_celeb()
celeb2 = get_celeb()



while True:
    
    print(f'Compare A: {celeb1[0]}, a {celeb1[1]}, from {celeb1[2]}.')

    print(vs)

    print(f'Against B: {celeb2[0]}, a {celeb2[1]}, from {celeb2[2]}.')

    user_pick = input("Who has more followers? Type 'A' or 'B': ")
    print()

    if user_pick == ['a']:
        if celeb1[3] > celeb2[3]:
            os.system('cls')
            print(f'Correct {celeb1[0]} has {celeb1[3]}k followers and {celeb2[0]} has {celeb2[3]}k.')
            print()
            celeb1 = get_celeb()
            continue
        else:
            print('Sorry that is incorrect')
            break
    elif user_pick == 'b':
        if celeb2[3] > celeb1[3]:
            os.system('cls')
            print(f'Correct {celeb2[0]} has {celeb2[3]}k followers and {celeb1[0]} has {celeb1[3]}k.')
            print()
            celeb2 = get_celeb()
            continue
        else:
            print('Sorry that is incorrect')
            break
            




