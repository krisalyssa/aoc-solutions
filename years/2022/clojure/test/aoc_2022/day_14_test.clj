(ns aoc-2022.day-14-test
  (:require [aoc-2022.day-14 :refer :all]
            [clojure.test :refer :all]))

(deftest day-14-test
  (testing "sample data"
    (is (= 24 (time (part1 "../data/14-sample.txt"))))
    (is (= 93 (time (part2 "../data/14-sample.txt"))))))

;; The tests take a *long* time to run.
;; Don't enable them until the code is sped up.

  ;; (testing "puzzle data"
  ;;   (is (= 1406 (time (part1 "../data/14.txt"))))
  ;;   (is (= 20870 (time (part2 "../data/14.txt"))))))
