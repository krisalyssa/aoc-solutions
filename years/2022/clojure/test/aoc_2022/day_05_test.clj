(ns aoc-2022.day-05-test
  (:require [aoc-2022.day-05 :refer :all]
            [clojure.test :refer :all]))

(deftest day-05-test
  (testing "sample data"
    (is (= "CMZ" (part1 "../data/05-sample.txt")))
    (is (= "MCD" (part2 "../data/05-sample.txt"))))
  (testing "puzzle data"
    (is (= "TLFGBZHCN" (part1 "../data/05.txt")))
    (is (= "QRQFHFWCL" (part2 "../data/05.txt")))))
