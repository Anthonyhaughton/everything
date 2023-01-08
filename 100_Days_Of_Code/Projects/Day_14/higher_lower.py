import random
from art import logo
from art import vs
from game_data import data


print(logo)

compare_a = random.choice(data)
print(f'Compare A: {compare_a}')

print(vs)

compare_b = random.choice(data)
print(f'Agaisnt B: {compare_b}')

## Figure out how to index dict in a list to pull name desc and country

