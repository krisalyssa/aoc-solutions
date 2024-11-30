(ns day-04
  (:gen-class))

(require '[clojure.string :as str]
         '[clojure.set :as sets])

(defn read-file [filename]
  (str/split-lines
   (slurp filename)))

(defn make-section [s]
  (let [[start end] (map #(Integer/parseInt %) (str/split s #"-"))]
    (set (range start (inc end)))))

(defn sections [s]
  (map make-section (str/split s #",")))

(defn fully-contained? [s1 s2]
  (or (sets/subset? s1 s2) (sets/subset? s2 s1)))

(defn overlap? [s1 s2]
  (seq (sets/intersection s1 s2)))

(defn part1 [filename]
  (count (filter #(apply fully-contained? (sections %)) (read-file filename))))

(defn part2 [filename]
  (count (filter #(apply overlap? (sections %)) (read-file filename))))

(defn -main []
  (printf "day 04 part 1: %d%n" (part1 "../data/04.txt"))
  (printf "day 04 part 2: %d%n" (part2 "../data/04.txt")))
