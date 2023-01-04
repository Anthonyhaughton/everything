from random import randint
# Global Cost to set level tries
EASY_LEVEL_TURNS = 10
HARD_LEVEL_TURNS = 5

# Func to check usr guess agaisnt anwser
def check_answer(guess, answer):
    if guess > answer:
        print('Too high!')
    elif guess < answer:
        print('Too low!')
    else:
        print(f'You got it! The answer was {answer}, you win!')

# Make Func to set difficulty
def set_difficulty():
    level = input('Choose a diffculty. Type "easy or "hard": ') 
    if level == 'easy':
        return EASY_LEVEL_TURNS
    else:
        return HARD_LEVEL_TURNS
        
    
#  Choose number between  1-100
answer = randint(1, 100)
print('Welcome to the Number Guessing Game!')
print("I'm thinking of a number between 1 and 100.")
turns = set_difficulty()
print(f'You have {turns} attempts remaining to guess the number.')

# Let user guess a number
guess = input('Make a guess: ')
check_answer(guess, answer)


# Track num of turns and sub by 1  if they get it wrong

