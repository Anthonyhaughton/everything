# Using a loop to clean up the code from previous. So I don't need to use print x5


students = {
    "Hermione": "Gryffindor",
    "Harry": "Gryffindor",
    "Ron": "Gryffindor",
    "Draco": "Slytherin",
    }


# We are also using the key on line 16 to index into the dict to pull which house they attend. students[student]
# Changed default sep property to add a comma to clean up output

for student in students:
    print(student, students[student], sep=", ")