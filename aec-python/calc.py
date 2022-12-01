# calc.py

import argparse

parser = argparse.ArgumentParser(description = "CLI Calculator")

subparsers = parser.add_subparsers(help = "sub-command help", dest="command")

add = subparsers.add_parser("add", help = "Add integers")
add.add_argument("ints_to_sum", nargs=2, type=int)

sub = subparsers.add_parser("sub", help = "Subtract integers")
sub.add_argument("ints_to_sub", nargs=2, type=int)

def aec_subtract(ints_to_sub):
    our_sub = ints_to_sub[0] - ints_to_sub[1]
    if our_sub < 0:
        our_sub = 0
    print(f"the sum of values is {our_sub}")
    return(our_sub)

if __name__ == "__main__":
    args = parser.parse_args()

    if args.command == "add":
        our_sum = sum(args.ints_to_sum)
        print(f"the sum of values is {our_sum}")

    if args.command == 'sub':
        aec_subtract(args.ints_to_sub)