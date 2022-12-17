(ns aoc-2022.day-15-test
  (:require [aoc-2022.day-15 :refer :all]
            [clojure.test :refer :all]))

(deftest day-15-test
  (testing "parse-one-line"
    (is (= {:sensor [2 18] :beacon [-2 15]} (parse-one-line "Sensor at x=2, y=18: closest beacon is at x=-2, y=15"))))
  (testing "crosses-row?"
    (is (crosses-row? 10 {:sensor [8 7], :beacon [2 10], :region {:x1 -1, :x2 17, :y1 -2, :y2 16}}))
    (is (not (crosses-row? 10 {:sensor [2 18], :beacon [-2 15], :region {:x1 -5, :x2 9, :y1 11, :y2 25}}))))
  (testing "project-on-row"
    (is (= (disj (set (range 2 (inc 14))) 2) (project-on-row 10 {:sensor [8 7], :beacon [2 10], :region {:x1 -1, :x2 17, :y1 -2, :y2 16}}))))

  (testing "sample data"
    (is (= 26 (time (part1 "../../data/15-sample.txt" 10)))))
;;     (is (= 2713310158 (part2 "../../data/15-sample.txt"))))
  (testing "puzzle data"
    (is (= 5564017 (time (part1 "../../data/15.txt" 2000000))))))
;;     (is (= 19309892877 (part2 "../../data/15.txt")))))
