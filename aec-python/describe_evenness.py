def is_even(x):
    if x % 2 == 0:
        return True
    else:
        return False

def is_odd(x):
    if x % 2 != 0:
        return True
    else:
        return False


def describe_evenness(x):
    if is_even(x):
        print("It's even")
    elif is_odd(x):
        print("It's odd!")
    else:
        print("It's neither even nor odd")