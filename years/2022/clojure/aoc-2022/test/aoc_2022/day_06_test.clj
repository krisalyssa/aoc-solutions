(ns aoc-2022.day-06-test
  (:require [aoc-2022.day-06 :refer :all]
            [clojure.test :refer :all]))

(deftest day-06-test
  (testing "sample data"
    (testing "part1"
      (is (= 7 (scan-for-marker "mjqjpqmgbljsphdztnvjfqwrcgsmlb" 4)))
      (is (= 5 (scan-for-marker "bvwbjplbgvbhsrlpgdmjqwftvncz" 4)))
      (is (= 6 (scan-for-marker "nppdvjthqldpwncqszvftbrmjlhg" 4)))
      (is (= 10 (scan-for-marker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" 4)))
      (is (= 11 (scan-for-marker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" 4))))
    (testing "part2"
      (is (= 19 (scan-for-marker "mjqjpqmgbljsphdztnvjfqwrcgsmlb" 14)))
      (is (= 23 (scan-for-marker "bvwbjplbgvbhsrlpgdmjqwftvncz" 14)))
      (is (= 23 (scan-for-marker "nppdvjthqldpwncqszvftbrmjlhg" 14)))
      (is (= 29 (scan-for-marker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" 14)))
      (is (= 26 (scan-for-marker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" 14)))))
  (testing "puzzle data"
    (is (= 1109 (part1 "../../data/06.txt")))
    (is (= 3965 (part2 "../../data/06.txt")))))
