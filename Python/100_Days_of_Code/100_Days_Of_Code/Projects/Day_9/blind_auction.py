import os

from art import logo

print(logo)

bid_dict = {}
while True:
    name = input('What is your name?: ')
    bid = int(input('How much do you want to bid?: $'))
    bid_dict[name] = bid
    question = input('Anyone else want to bid? Type "yes" or "no" ')
    if question == 'yes':
        os.system('clear')
        continue
    else:
        break

#highest_bidder = max(bid_dict, key=bid_dict.get)
highest_amount = max(bid_dict, key=lambda k: bid_dict[k])
print(bid_dict)
print(f'The winner is {highest_amount} with a bid of ${bid_dict[highest_amount]}')

