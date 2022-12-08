import time

#Set the starting price and the minimum increase amount
start_price = 10.00
min_increase = 0.50

#Create a list to store the bids
bids = []

#Ask the user to enter the number of rounds
rounds = int(input('Enter the number of rounds: '))

#Start the auction
print('Auction has started!')

#Loop through the rounds
for round in range(rounds):

    #Print the current round
    print('Round {}'.format(round + 1))

    #Print the current price
    print('The current price is ${:.2f}'.format(start_price))

    #Get the bids from the user
    bid = float(input('Place your bid: '))

    #Add the bid to the list
    bids.append(bid)

    #Increase the price for the next round
    start_price += min_increase

    #Pause for one second
    time.sleep(1)

#Print the highest bid
print('The highest bid is ${:.2f}'.format(max(bids)))