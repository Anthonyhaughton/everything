def main():
    # Get input from user
    answer = input('What time is it? ')
    # Call the convert func
    time = convert(answer)
    # Breakfast time 7:00 - 8:00
    if time >= 7 and time <= 8:
        print('breakfast time')
    # Lunch time 12:00 - 13:00
    elif time >= 12 and time <= 13:
        print('lunch time')
    # Dinner time 18:00 -19:00
    elif time >= 18 and time <= 19:
        print('dinner time')
    # If it is not time to eat display nothing
    else:
        print()

def convert(time):
    # Get hour and minute
    hour, minute = time.split(':')
    # Convert time into a float number
    new_minute = float(minute) / 60
    # Return the result to the main func
    return float(hour) + new_minute



if __name__ == "__main__":
    main()