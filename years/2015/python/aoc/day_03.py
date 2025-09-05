#!env python
# code: language=python insertSpaces=true tabSize=4

import io
import json

##
## day 03 part 1
##


def part1(data):
    return None


##
## day 03 part 2
##


def part2(data):
    return None


##
## main
##


def main():
    with io.open("../data/03.txt") as f:
        data = f.readlines()
        output = {"day_03": [part1(data), part2(data)]}
        print(json.dumps(output, indent=2))


##
## execution begins here
##

if __name__ == "__main__":
    main()
