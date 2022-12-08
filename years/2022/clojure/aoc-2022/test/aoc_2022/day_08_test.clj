(ns aoc-2022.day-08-test
  (:require [aoc-2022.day-08 :refer :all]
            [clojure.test :refer :all]))

(deftest day-08-test
  (testing "sample data"
    (is (= 21 (part1 "../../data/08-sample.txt"))))
    ;; (is (= 24933642 (part2 "../../data/08-sample.txt"))))
  (testing "puzzle data"
    (is (= 1859 (part1 "../../data/08.txt")))))
  ;;   (is (= 272298 (part2 "../../data/08.txt")))))
