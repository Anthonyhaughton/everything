import os

from art import logo

print(logo)

def winner(bidding_record):
    winner = ''
    highest_bid = 0
    for bidder in bidding_record:
        bid_amount = bidding_record[bidder]
        if bid_amount > highest_bid:
            highest_bid = bid_amount
            winner = bidder
    print(f'The winner is {winner} with a bid of ${highest_bid}')

bid = {}
while True:
    name = input('Name?: ')
    bid_amt = int(input('Bid?: $'))
    bid[name] = bid_amt
    is_over = input('Anyone Else? "y" or "n" ')
    if is_over == 'y':
        os.system('clear')
        continue
    else:
        winner(bid)
        break


# winner = max(bid, key=lambda k: bid[k])
# print(f'The winner is {winner} with a bid of ${bid[winner]}')