#!env python
# code: language=python insertSpaces=true tabSize=4

import functools
import io
import json

delta = {"(": 1, ")": -1}

##
## day 01 part 1
##


def part1(data):
    return functools.reduce(lambda acc, line: follow_instructions(acc, line), data, 0)


##
## day 01 part 2
##


def part2(data):
    return None


def follow_instructions(start, line):
    return functools.reduce(lambda acc, c: acc + delta[c], line, start)


##
## main
##


def main():
    with io.open("../data/01.txt") as f:
        data = f.readlines()
        output = {"day_01": [part1(data), part2(data)]}
        print(json.dumps(output, indent=2))


##
## execution begins here
##

if __name__ == "__main__":
    main()
