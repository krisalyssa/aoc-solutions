(ns aoc-2022.day-13-test
  (:require [aoc-2022.day-13 :refer :all]
            [clojure.data.json :as json]
            [clojure.test :refer :all]))

(deftest day-13-test
  (testing "compare-sequences"
    (is (= -1 (compare-sequences (json/read-str "[1,1,3,1,1]") (json/read-str "[1,1,5,1,1]"))))
    (is (= -1 (compare-sequences (json/read-str "[[1],[2,3,4]]") (json/read-str "[[1],4]"))))
    (is (= 1 (compare-sequences (json/read-str "[9]") (json/read-str "[[8,7,6]]"))))
    (is (= -1 (compare-sequences (json/read-str "[[4,4],4,4]") (json/read-str "[[4,4],4,4,4]"))))
    (is (= 1 (compare-sequences (json/read-str "[7,7,7,7]") (json/read-str "[7,7,7]"))))
    (is (= -1 (compare-sequences (json/read-str "[]") (json/read-str "[3]"))))
    (is (= 1 (compare-sequences (json/read-str "[[[]]]") (json/read-str "[[]]"))))
    (is (= 1 (compare-sequences (json/read-str "[1,[2,[3,[4,[5,6,7]]]],8,9]") (json/read-str "[1,[2,[3,[4,[5,6,0]]]],8,9]")))))

  (testing "sample data"
    (is (= 13 (part1 "../../data/13-sample.txt"))))
    ;; (is (= 29 (part2 "../../data/13-sample.txt"))))
  (testing "puzzle data"
    (is (= 5588 (part1 "../../data/13.txt")))))
    ;; (is (= 321 (part2 "../../data/13.txt")))))
