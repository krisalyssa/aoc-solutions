(ns aoc-2022.day-03-test
  (:require [aoc-2022.day-03 :refer :all]
            [clojure.test :refer :all]))

(deftest day-03-test
  (is (= 157 (part1 "../../data/03-sample.txt")))
  (is (= 70 (part2 "../../data/03-sample.txt"))))
