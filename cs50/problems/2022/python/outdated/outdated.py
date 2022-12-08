months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
]


# Loop forever
while True:
    # Get user input
    question = input('Date: ')

    try:
        # Split the date by space
        month, day, year = question.split('/')
        # Check if month is between 1-12 and day between 1-31
        if (int(month) > 0 and int(month) <= 12) and (int(day) > 0 and int(day) <= 31):
            break
    except:
        try:
            # Split the month by the space
            old_month, old_day, year = question.split(' ')
            # Check to verify the month is a char not a number or special char
            if not old_month.isalpha() == True:
                continue
            # Find the number of the month
            for i in range(len(months)):
                if old_month == months[i]:
                    month = i + 1
            # Check to see if the number in "old_day" ends with a comma so that we can remove it in the next line. If not re prompt.
            if not old_day.endswith(","):
                continue
            # Remove comma from day var
            day = old_day.replace(',', '')
            # Check if month is between 1-12 and day 1-31
            if (int(month) > 0 and int(month) <= 12) and (int(day) > 0 and int(day) <= 31):
                break

        except ValueError:
            print()
            pass

print(f'{year.strip()}-{int(month):02}-{int(day):02}')


