(ns day-11-test
  (:require
   [clojure.test :refer :all]
   [day-11 :refer :all]))

(deftest day-11-test
  (testing "sample data"
    (is (= 10605 (part1 "../data/11-sample.txt")))
    (is (= 2713310158 (part2 "../data/11-sample.txt"))))
  (testing "puzzle data"
    (is (= 66124 (part1 "../data/11.txt")))
    (is (= 19309892877 (part2 "../data/11.txt")))))
