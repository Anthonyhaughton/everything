from random import randint
from art import logo

# Global Cost to set level tries
EASY_LEVEL_TURNS = 10
HARD_LEVEL_TURNS = 5

# Func to check usr guess agaisnt anwser
def check_answer(guess, answer, turns):
    ''' Checks answer against guess. Returns the number of turns remaining. '''
    if guess > answer:
        print('Too high!')
        return turns - 1
    elif guess < answer:
        print('Too low!')
        return turns - 1
    else:
        print(f'You got it! The answer was {answer}, you win!')

# Make Func to set difficulty
def set_difficulty():
    level = input('Choose a diffculty. Type "easy or "hard": ') 
    if level == 'easy':
        return EASY_LEVEL_TURNS
    else:
        return HARD_LEVEL_TURNS

# Create a func to run the game      
def game():
    #  Choosing a number between  1-100
    print(logo)
    answer = randint(1, 100)
    print('Welcome to the Number Guessing Game!')
    print("I'm thinking of a number between 1 and 100.")
    turns = set_difficulty()
    

    # Repeat the guessing game if they get it wrong
    guess = 0 
    while guess != answer:
        print(f'You have {turns} attempts remaining to guess the number.')
        
        # Let user guess a number
        guess = int(input('Make a guess: '))
        turns = check_answer(guess, answer, turns)
        if turns == 0:
            print(f'You have run out of guesses, you lose! The number was {answer}')
            return

game()

