import random
# Split string method
names_string = input("Give me everybody's names, separated by a comma. ")
names = names_string.split(", ")

person = random.choice(names)
print(f'{person} is going to buy the meal today!')

######################## If you aren't using random.choice
import random
names_string = input("Give me everybody's names, separated by a comma. ")
names = names_string.split(", ")
#Get the total numbers of items in the list
num_items = len(names)
#Generate random numbers between 0 and the last index. Note the last idex is less than the total number of items this is why there is a -1. Indexes start a 0 the counter starts at 1
random_choice = random.randint(0, num_items -1)
person = names[radom choice]
print(f'{person} is going to buy the meal today!')