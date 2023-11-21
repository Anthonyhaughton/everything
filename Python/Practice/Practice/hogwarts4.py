# Using Curly Braces for dicts. Instead of having two list that are supposed to match eachother ie students = and houses = we can just
# Make a dict to assign the value(student) to the key(house)

# We can drop down lines inbetween the braces to make the code more readable.

students = {
    "Hermione": "Gryffindor",
    "Harry": "Gryffindor",
    "Ron": "Gryffindor",
    "Draco": "Slytherin",
    }

# When using list you would have to specify a number [0,1,2] that you wanted to pull from that list.
# But for dicts you can actually use the name to index.

print(students["Hermione"])
print(students["Harry"])
print(students["Ron"])
print(students["Draco"])