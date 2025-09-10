import gleeunit

import day_01

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn day_01_part_1_test() {
  assert day_01.part_1(["(())"]) == 0
  assert day_01.part_1(["()()"]) == 0
  assert day_01.part_1(["((("]) == 3
  assert day_01.part_1(["(()(()("]) == 3
  assert day_01.part_1(["))((((("]) == 3
  assert day_01.part_1(["())"]) == -1
  assert day_01.part_1(["))("]) == -1
  assert day_01.part_1([")))"]) == -3
  assert day_01.part_1([")())())"]) == -3
}

pub fn day_01_part_2_test() {
  assert day_01.part_2([")"]) == 1
  assert day_01.part_2(["()())"]) == 5
}
