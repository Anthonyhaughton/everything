student_heights = input("Input a list of student heights ").split()
for n in range(0, len(student_heights)):
   student_heights[n] = int(student_heights[n])

total_height = 0
for height in student_heights:
  total_height += height

student_count = 0
for student in student_heights:
  student_count += 1

total = round(total_height / student_count)
print(total)
