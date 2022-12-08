# import random imports all the contents within so we have to do random.choice
# but if we wanted to clean it up we could use "from" to pick and choose what we
# want

from random import choice

coin = choice(["heads", "tails"])
print(coin)