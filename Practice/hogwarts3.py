## used len to be able to use range bc range only looks for ints len shows you the
## length of a list so on line 5 i wanted to show the list in order but make it
## Human readable (starting at 1 rather than 0)

students = ["Hermoine", "Harry", "Ron"]

for i in range(len(students)):
    print(i + 1, students[i])