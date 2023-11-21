# Get user input
expression = input("Expression: ")

# Convert this into variables
x, y, z = expression.split(" ")

# Change type of variables x and z to float
new_x = float(x)
new_z = float(z)

# Get the result
if y == "+":
    result = new_x + new_z
if y == "-":
    result = new_x - new_z
if y == "*":
    result = new_x * new_z
if y == "/":
    result = new_x / new_z
print(round(result, 1))