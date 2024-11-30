(ns day-01-test
  (:require
   [clojure.test :refer :all]
   [day-01 :refer :all]))

(deftest day-01-test
  (testing "sample data"
    (is (= 24000 (part1 "../data/01-sample.txt")))
    (is (= 45000 (part2 "../data/01-sample.txt"))))
  (testing "puzzle data"
    (is (= 67027 (part1 "../data/01.txt")))
    (is (= 197291 (part2 "../data/01.txt")))))
