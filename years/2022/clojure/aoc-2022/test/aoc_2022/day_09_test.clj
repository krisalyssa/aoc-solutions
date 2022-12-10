(ns aoc-2022.day-09-test
  (:require [aoc-2022.day-09 :refer :all]
            [clojure.test :refer :all]))

(deftest day-09-test
  (testing "sample data"
    (is (= 13 (part1 "../../data/09-sample.txt"))))
;;     (is (= 8 (part2 "../../data/09-sample.txt"))))
  (testing "puzzle data"
    (is (= 5902 (part1 "../../data/09.txt")))))
;;     (is (= 332640 (part2 "../../data/09.txt")))))
