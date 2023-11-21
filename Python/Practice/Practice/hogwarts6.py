# Making a dict within a list. This list contains 3 keys (name house and patronus)


students = [
    {"name": "Hermione", "house": "Gryffindor", "patronus": "Otter"},
    {"name": "Harry", "house": "Gryffindor", "patronus": "Stag"},
    {"name": "Ron", "house": "Gryffindor", "patronus": "Jack Russel terrier"},
    {"name": "Darco", "house": "Slytherin", "patronus": None}
]


# We can chose whichever keys we want to print here
for student in students:
    print(student["name"], student["house"], student["patronus"], sep=", ")