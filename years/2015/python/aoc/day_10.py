#!env python
# code: language=python insertSpaces=true tabSize=4

import io
import json

##
## day 10 part 1
##


def part1(data):
    return None


##
## day 10 part 2
##


def part2(data):
    return None


##
## main
##


def main():
    with io.open("../data/10.txt") as f:
        data = f.readlines()
        output = {"day_10": [part1(data), part2(data)]}
        print(json.dumps(output, indent=2))


##
## execution begins here
##

if __name__ == "__main__":
    main()
