import random

# list of all card numbers
cards = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]

# Choose 2 cards for player and dealer at random from the list
dealer = random.sample(cards, 2)
player = random.sample(cards, 2)

#print card numbers 
print(dealer)
print(player)

# Add the sum of the two cards for both players
dealer_count = sum(dealer)
player_count = sum(player)

#print the sum for testing
print(f'Dealer: {dealer_count}')
print(f'Player: {player_count}')

# Check if player or dealer has blackjack 11 + 10
if player_count == 21:
    # Player wins
    print(f'You have {player_count} you win!')
    #break
elif dealer_count == 21:
    # Dealer wins
    print(f'Dealer has {dealer_count} you lose!')
    #break

# Need to give ace (11) two vaules to choose from
if 11 in player:
    ace = [11, 1]
    print(ace)

hit = input('Do you want another card? "y" for yes "n" for no: ')
if hit == 'y':
    extra_card = random.choice(player)
    extra_card
    
print(extra_card)
