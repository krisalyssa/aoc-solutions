(ns aoc-2022.day-14-test
  (:require [aoc-2022.day-14 :refer :all]
            [clojure.test :refer :all]))

(deftest day-14-test
  (testing "sample data"
    (is (= 24 (time (part1 "../../data/14-sample.txt")))))
;;     (is (= 140 (part2 "../../data/14-sample.txt"))))
  (testing "puzzle data"
    (is (= 1406 (time (part1 "../../data/14.txt"))))))
;;     (is (= 23958 (part2 "../../data/14.txt")))))
