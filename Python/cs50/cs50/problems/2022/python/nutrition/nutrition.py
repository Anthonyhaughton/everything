# Create dict
fruits = {
    'apple': 130, 'avocado': 50, 'banana': 110, 'cantaloupe': 50,
    'grapefruit': 60, 'grapes': 90, 'honeydew melon': 50, 'kiwifruit': 90,
    'lemon': 15, 'lime': 20, 'nectarine': 60, 'orange': 80,
    'peach': 60, 'pear': 100, 'pinapple': 50, 'plums': 70,
    'strawberries': 50, 'sweet cherries': 100, 'tangerine': 50, 'watermelon': 80
}
# Create a while loop and set a var to True so that the loop only breaks when the condition is met else continue looping.
# This will help get users to input valid fruit.
end = True
while end:
    # Get user input
    item = input('Item: ').lower()
    # Loop through fruits dict
    #for key in fruits:
        # Print the fruits calories
    if item in fruits:
        print(f'Calories: {fruits[item]}')
        end = False
    else:
        continue


