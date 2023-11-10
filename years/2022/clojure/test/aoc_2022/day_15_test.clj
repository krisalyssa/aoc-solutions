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
  (testing "slope-offset"
    (let [{slope :slope offset :offset} (slope-offset [[1 1] [3 3]])]
      (is (= 1 slope))
      (is (= 0 offset)))
    (let [{slope :slope offset :offset} (slope-offset [[0 4] [4 0]])]
      (is (= -1 slope))
      (is (= 4 offset))))
  (testing "orientation3"
    (is (= :clockwise (orientation3 [3 4] [3 1] [1 2])))
    (is (= :anticlockwise (orientation3 [1 4] [1 2] [3 1])))
    (is (= :collinear (orientation3 [1 1] [2 2] [4 4]))))
  (testing "point-on-segment?"
    (is (point-on-segment? [1 2] [3 4] [2 3]))
    (is (not (point-on-segment? [1 2] [3 4] [5 6]))))
  (testing "lines-intersect?"
    (is (lines-intersect? [[0 0] [4 4]] [[0 4] [4 0]]))
    (is (not (lines-intersect? [[0 0] [4 4]] [[1 0] [5 0]]))))

  (testing "sample data"
    (is (= 26 (time (part1 "../data/15-sample.txt" 10))))
    (is (= 56000011 (part2 "../data/15-sample.txt"))))
  (testing "puzzle data"
    (is (= 5564017 (time (part1 "../data/15.txt" 2000000))))
    (is (= 11558423398893 (part2 "../data/15.txt")))))
