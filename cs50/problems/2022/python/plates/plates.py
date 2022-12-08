def main():
    plate = input("Plate: ")
    if is_valid(plate):
        print("Valid")
    else:
        print("Invalid")


def is_valid(s):
    # Vanity plates may contain a maxium of 6 chars (letters or numbers)
    # and a minimum of 2 chars
    if len(s) < 2 or len(s) > 6:
        return False

    # All vanity plates must start with at least 2 letters
    if s[0].isalpha() == False or s[1].isalpha() == False:
        return False


    # Numbers cannot be used in the middle of a plate; they must come at the end.
    # For example, AAA222 would be OK but AAA22A would not be.
    # The first number used can not be '0'
    i = 0
    while i < len(s):
        if s[i].isalpha() == False:
            if s[i] == '0':
                return False
            elif not s[i:].isdigit():
                return False
            else:
                break
        i += 1

    # No periods, spaces, or punctuation marks allowed.
    for char in s:
        if char in ['.', ' ', '!', '?']:
            return False



    # If all pass the test, return True
    return True

main()