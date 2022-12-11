(ns aoc-2022.day-10-test
  (:require [aoc-2022.day-10 :refer :all]
            [clojure.test :refer :all]))

(deftest day-10-test
  (testing "sample data"
    (is (= 13140 (part1 "../../data/10-sample.txt"))))
;;     (is (= 1 (part2 "../../data/10-sample.txt")))
  (testing "puzzle data"
    (is (= 14160 (part1 "../../data/10.txt")))))
;;     (is (= 2445 (part2 "../../data/10.txt")))))
