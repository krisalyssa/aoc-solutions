(ns aoc-2022.day-10-test
  (:require [aoc-2022.day-10 :refer :all]
            [clojure.test :refer :all]))

;; part 2 renders "pixels" to a virtual screen, which isn't easy to test
;; without including th entire screen output

(deftest day-10-test
  (testing "sample data"
    (is (= 13140 (part1 "../data/10-sample.txt"))))
  (testing "puzzle data"
    (is (= 14160 (part1 "../data/10.txt")))))
