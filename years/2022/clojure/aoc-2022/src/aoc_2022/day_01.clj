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

;; part 1
;; (sum-top 1 (map #(reduce + %) (parse-lists "../../data/01-sample.txt")))
(sum-top 1 (map #(reduce + %) (parse-lists "../../data/01.txt")))

;; part 2
;; (sum-top 3 (map #(reduce + %) (parse-lists "../../data/01-sample.txt")))
(sum-top 3 (map #(reduce + %) (parse-lists "../../data/01.txt")))
