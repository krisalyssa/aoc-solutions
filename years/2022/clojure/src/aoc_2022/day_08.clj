(ns aoc-2022.day-08
  (:gen-class))

(require ;; '[clojure.pprint :as pp]
 '[clojure.core.matrix :as matrix]
 '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn as-grid
  "Converts row data into a 2D matrix.
   Assumes that each item in the input list is a string of digits,
   and that each string has the same length."
  [rows]
  (matrix/matrix (map (fn [row] (map #(Integer/parseInt %) (str/split row #""))) rows)))

;; functions for counting visible trees

(defn is-visible-from-east?
  "Returns `true` if a tree is visible from the east (right side of the grid)."
  [grid row-num col-num]
  (let [[_row-count col-count] (matrix/shape grid)]
    (if (= col-num (dec col-count))
      true
      (let [this-val (matrix/mget grid row-num col-num)]
        (not-any? (fn [other-col-num] (>= (matrix/mget grid row-num other-col-num) this-val)) (range (inc col-num) col-count))))))

(defn is-visible-from-north?
  "Returns `true` if a tree is visible from the north (top side of the grid)."
  [grid row-num col-num]
  (if (= row-num 0)
    true
    (let [this-val (matrix/mget grid row-num col-num)]
      (not-any? (fn [other-row-num] (>= (matrix/mget grid other-row-num col-num) this-val)) (range 0 row-num)))))

(defn is-visible-from-south?
  "Returns `true` if a tree is visible from the south (bottom side of the grid)."
  [grid row-num col-num]
  (let [[row-count _col-count] (matrix/shape grid)]
    (if (= row-num (dec row-count))
      true
      (let [this-val (matrix/mget grid row-num col-num)]
        (not-any? (fn [other-row-num] (>= (matrix/mget grid other-row-num col-num) this-val)) (range (inc row-num) row-count))))))

(defn is-visible-from-west?
  "Returns `true` if a tree is visible from the west (left side of the grid)."
  [grid row-num col-num]
  (if (= col-num 0)
    true
    (let [this-val (matrix/mget grid row-num col-num)]
      (not-any? (fn [other-col-num] (>= (matrix/mget grid row-num other-col-num) this-val)) (range 0 col-num)))))

(defn is-visible?
  "Returns `true` if a tree is visible from one of the cardinal directions."
  [grid row-num col-num]
  (some (fn [f] (f grid row-num col-num)) (list is-visible-from-north? is-visible-from-east? is-visible-from-south? is-visible-from-west?)))

;; functions for measuring viewing distance

(defn viewing-distance-along-seq
  "Determines the viewing distance using the supplied sequence of coordinates.
   The viewing distance is the number of trees to the first one which has a height the same as or greater than the current height.
   The distance ends up being 0-based, so we need to increment it before returning it."
  [grid this-height direction-seq]
  (let [short-tree-seq (keep-indexed (fn [idx [other-row-num other-col-num]]
                                       (when (>= (matrix/mget grid other-row-num other-col-num) this-height) idx)) direction-seq)]
    (if (seq short-tree-seq)
      (inc (first short-tree-seq))
      (count direction-seq))))

(defn viewing-distance-to-east
  "Determines the viewing distance to the east (toward the right side of the grid)."
  [grid row-num col-num]
  (let [[_row-count col-count] (matrix/shape grid)
        this-height (matrix/mget grid row-num col-num)
        start-col-num (inc col-num)
        direction-seq (map (fn [other-col-num] (vector row-num other-col-num)) (range start-col-num col-count))]
    (if (= start-col-num col-count)
      0
      (viewing-distance-along-seq grid this-height direction-seq))))

(defn viewing-distance-to-north
  "Determines the viewing distance to the north (toward the top side of the grid)."
  [grid row-num col-num]
  (let [[_row-count _col-count] (matrix/shape grid)
        this-height (matrix/mget grid row-num col-num)
        start-row-num (dec row-num)
        direction-seq (map (fn [other-row-num] (vector other-row-num col-num)) (range start-row-num -1 -1))]
    (if (= start-row-num -1)
      0
      (viewing-distance-along-seq grid this-height direction-seq))))

(defn viewing-distance-to-south
  "Determines the viewing distance to the south (toward the bottom side of the grid)."
  [grid row-num col-num]
  (let [[row-count _col-count] (matrix/shape grid)
        this-height (matrix/mget grid row-num col-num)
        start-row-num (inc row-num)
        direction-seq (map (fn [other-row-num] (vector other-row-num col-num)) (range start-row-num row-count))]
    (if (= start-row-num row-count)
      0
      (viewing-distance-along-seq grid this-height direction-seq))))

(defn viewing-distance-to-west
  "Determines the viewing distance to the west (toward the left side of the grid)."
  [grid row-num col-num]
  (let [[_row-count _col-count] (matrix/shape grid)
        this-height (matrix/mget grid row-num col-num)
        start-col-num (dec col-num)
        direction-seq (map (fn [other-col-num] (vector row-num other-col-num)) (range start-col-num -1 -1))]
    (if (= start-col-num -1)
      0
      (viewing-distance-along-seq grid this-height direction-seq))))

(defn scenic-score
  "Calculates the scenic score for a tree.
   The scenic score is the product of the viewing distances in the cardinal directions from the tree."
  [grid row-num col-num]
  (apply * (map (fn [f] (f grid row-num col-num)) (list viewing-distance-to-north viewing-distance-to-east viewing-distance-to-south viewing-distance-to-west))))

(defn part1 [filename]
  (let [grid (as-grid (read-file filename))
        [row-count col-count] (matrix/shape grid)
        row-col-seq (for [row-num (range row-count) col-num (range col-count)] [row-num col-num])]
    (count (filter (fn [[row-num col-num]] (is-visible? grid row-num col-num)) row-col-seq))))

(defn part2 [filename]
  (let [grid (as-grid (read-file filename))
        [row-count col-count] (matrix/shape grid)
        row-col-seq (for [row-num (range row-count) col-num (range col-count)] [row-num col-num])]
    (apply max (map (fn [[row-num col-num]] (scenic-score grid row-num col-num)) row-col-seq))))

(defn -main []
  (printf "day 08 part 1: %d%n" (part1 "../data/08.txt"))
  (printf "day 08 part 2: %d%n" (part2 "../data/08.txt")))
