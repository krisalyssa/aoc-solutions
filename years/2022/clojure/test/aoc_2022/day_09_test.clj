(ns aoc-2022.day-09-test
  (:require [aoc-2022.day-09 :refer :all]
            [clojure.test :refer :all]))

(deftest day-09-test
  (testing "sample data"
    (is (= 13 (part1 "../data/09-sample-1.txt")))
    (is (= 1 (part2 "../data/09-sample-1.txt")))
    (is (= 36 (part2 "../data/09-sample-2.txt"))))
  (testing "puzzle data"
    (is (= 5902 (part1 "../data/09.txt")))
    (is (= 2445 (part2 "../data/09.txt")))))
