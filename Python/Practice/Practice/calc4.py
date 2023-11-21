# This is the round man page - round(number[, ndigits])
# Using Floats

x = float(input("What's x? "))
y = float(input("What's y? "))

z = round(x / y, 2)
# Introduction commas i.e. 1,000,000 - {z:,}

print(f"{z:,}")

#print(z)
