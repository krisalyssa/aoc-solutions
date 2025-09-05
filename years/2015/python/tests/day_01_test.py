#!env python
# code: language=python insertSpaces=true tabSize=4

import unittest

from aoc.day_01 import follow_instructions, part1


class TestDay01(unittest.TestCase):
    def test_follow_instructions(self):
        self.assertEqual(follow_instructions(0, "(())"), 0)
        self.assertEqual(follow_instructions(0, "((("), 3)

    def test_part1(self):
        self.assertEqual(part1(["(())"]), 0)
        self.assertEqual(part1(["()()"]), 0)
        self.assertEqual(part1(["((("]), 3)
        self.assertEqual(part1(["(()(()("]), 3)
        self.assertEqual(part1(["))((((("]), 3)
        self.assertEqual(part1(["())"]), -1)
        self.assertEqual(part1(["))("]), -1)
        self.assertEqual(part1([")))"]), -3)
        self.assertEqual(part1([")())())"]), -3)

    # def test_part2(self):
    #     self.fail("implement test for part2")


if __name__ == "__main__":
    unittest.main()
