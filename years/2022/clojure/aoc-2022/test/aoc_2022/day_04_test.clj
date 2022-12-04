(ns aoc-2022.day-04-test
  (:require [aoc-2022.day-04 :refer :all]
            [clojure.test :refer :all]))

(deftest day-04-test
  (testing "sample data"
    (is (= 2 (part1 "../../data/04-sample.txt")))
    (is (= 4 (part2 "../../data/04-sample.txt"))))
  (testing "puzzle data"
    (is (= 534 (part1 "../../data/04.txt")))
    (is (= 841 (part2 "../../data/04.txt")))))
