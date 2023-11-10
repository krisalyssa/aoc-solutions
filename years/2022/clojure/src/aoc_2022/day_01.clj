(ns aoc-2022.day-01
  (:gen-class))

(require '[clojure.string :as str])

(defn parse-seq [s]
  (map #(Integer/parseInt %) s))

(defn parse-lists [filename]
  (map #(parse-seq %)
       (remove #(str/blank? (first %))
               (partition-by #(str/blank? %)
                             (str/split-lines
                              (slurp filename))))))

(defn sum-top [n s]
  (reduce + (take n (sort > s))))

(defn part1 [filename]
  (sum-top 1 (map #(reduce + %) (parse-lists filename))))

(defn part2 [filename]
  (sum-top 3 (map #(reduce + %) (parse-lists filename))))

(defn -main []
  (printf "day 01 part 1: %d%n" (part1 "../data/01.txt"))
  (printf "day 01 part 2: %d%n" (part2 "../data/01.txt")))