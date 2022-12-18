import random
import os
from art import logo

MAX_BET = 10000
MIN_BET = 1
# Theres a bug where if  get dealt 21(0) The dealer can deal itself 21 and I lose
# I need to figure out how to end the game when I get dealt 21

# Need to figure out how to implement this into my code to play with a buy in
def deposit():
    while True:
        amount = input("What would you like to deposit? $")
        if amount.isdigit():
            amount = int(amount)
            if amount > 0:
                break
            else:
                print("Amount must be greater than 0.")
        else:
            print("Please enter a number.")

    return amount

# Need to figure out how to implement this into my code to play with a buy in
def get_bet():
    # Create while loop to let user keep depositing money
    while True:
        bet_amount = input('What would you like to bet on this hand? $')
        # Check to make sure user entered in a num
        if bet_amount.isdigit():
            # If num then convert amount to int
            bet_amount = int(bet_amount)
            # Check to make sure the num is higher than 0
            if MIN_BET <= bet_amount <= MAX_BET:
                # If vaild - break the loop and retun the num
                break
            else:
                print(f'Amount must be between ${MIN_BET} - ${MAX_BET}.')
        else:
            print('Please enter in a number.')
    return bet_amount

def deal_card():
    cards = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
    card = random.choice(cards)
    return card
 
def calculate_score(cards):
    ''' This func will check for blackjack, check if an ace is high or low depending on score and return the sum of the cards. '''
    #Hint 7: Inside calculate_score() check for a blackjack (a hand with only 2 cards: ace + 10) and return 0 instead of the actual score. 0 will represent a blackjack in our game.
    # Check if player or dealer has blackjack 11 + 10
    if sum(cards) == 21 and len(cards) == 2:
    # Someone wins
        return 0
    
    #Hint 8: Inside calculate_score() check for an 11 (ace). If the score is already over 21, remove the 11 and replace it with a 1. You might need to look up append() and remove().
    if 11 in cards and sum(cards) > 21:
        cards.remove(11)
        cards.append(1)         
        
    return sum(cards)

def compare(user_score, computer_score):
    if user_score == computer_score:
        return f'Push!'
    elif computer_score == 0:
        return f'Computer has Blackjack, you lose!'
    elif computer_score == 0:
        return f'You have Blackjack, you win!'
    elif user_score > 21:
        return f'You bust!'
    elif computer_score > 21:
        return f'Computer busts, you win!'
    elif user_score > computer_score:
        return f'You win!'
    else:
        return f'You lose!'

def play_game(#balnce):
    print(logo)
    #Hint 5: Deal the user and computer 2 cards each using deal_card() and append().
    user_cards = []
    computer_cards = []
    is_over = False
    amount = deposit()
    bet_amount = get_bet()
    
    for _ in range(2):
        user_cards.append(deal_card())
        computer_cards.append(deal_card())

    while not is_over:
        #Hint 9: Call calculate_score(). If the computer or the user has a blackjack (0) or if the user's score is over 21, then the game ends.
        user_score = calculate_score(user_cards)
        computer_score = calculate_score(computer_cards)
        print(f'Your cards are {user_cards}, current score: {user_score}')
        print(f'Computers first card is: {computer_cards[0]}')

        if user_score == 0 or computer_score == 0 or user_score >21:
            is_over = True
            
        #Hint 10: If the game has not ended, ask the user if they want to draw another card. If yes, then use the deal_card() function to add another card to the user_cards List. If no, then the game has ended.
        else:
            hit = input('Do you want another card? Press Enter for yes, or "n" to stand. ')
            if hit == "":
                user_cards.append(deal_card())
            else:
                is_over = True


    while computer_score != 0 and computer_score < 17:
        computer_cards.append(deal_card())    
        computer_score = calculate_score(computer_cards)

    os.system('cls')
    print(f'Your final hand is: {user_cards} with a score of: {user_score}')
    print(f'The computers final hand is: {computer_cards} with a score of: {computer_score}')
    print(compare(user_score, computer_score))
    print()

def main():
    while input('Press Enter to deal or "q" to quit: ') == '':
        os.system('cls')
        balance = deposit()
        balance += play_game(balance)
        

main()