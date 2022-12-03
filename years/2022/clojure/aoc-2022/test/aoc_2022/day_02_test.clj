(ns aoc-2022.day-02-test
  (:require [aoc-2022.day-02 :refer :all]
            [clojure.test :refer :all]))

(deftest day-02-test
  (is (= 15 (part1 "../../data/02-sample.txt")))
  (is (= 12 (part2 "../../data/02-sample.txt"))))
