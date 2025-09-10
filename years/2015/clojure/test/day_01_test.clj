(ns day-01-test
  (:require
   [clojure.test :refer [deftest is testing]]
   [day-01 :refer [part1 part2]]))

(deftest day-01-test
  (testing "part 1"
    (is (= 0 (part1 "(())")))
    (is (= 0 (part1 "()()")))
    (is (= 3 (part1 "(((")))
    (is (= 3 (part1 "(()(()(")))
    (is (= 3 (part1 "))(((((")))
    (is (= -1 (part1 "())")))
    (is (= -1 (part1 "))(")))
    (is (= -3 (part1 ")))")))
    (is (= -3 (part1 ")())())"))))
  (testing "part 2"
    (is (= 1 (part2 ")")))
    (is (= 5 (part2 "()())")))))
