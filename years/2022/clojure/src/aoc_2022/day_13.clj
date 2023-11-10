(ns aoc-2022.day-13
  (:gen-class))

(require '[clojure.pprint :as pp]
         '[clojure.data.json :as json]
         '[clojure.string :as str])

;; initialization functions

(defn partition-lines
  "Splits the sequence at blank lines."
  [lines]
  (->> lines
       (partition-by #(str/blank? %))
       (remove #(str/blank? (first %)))))

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn to-json
  "Converts input strings to JSON data."
  [pairs]
  (map #(map json/read-str %) pairs))

;; compare sequences, possibly nested with more sequences

(defn compare-sequences
  "Compares two sequences according to these rules.
   - If both values are integers, the lower integer should come first.
     If the left integer is lower than the right integer, the inputs are in the right order.
     If the left integer is higher than the right integer, the inputs are not in the right order.
     Otherwise, the inputs are the same integer; continue checking the next part of the input.
   - If both values are lists, compare the first value of each list, then the second value, and so on.
     If the left list runs out of items first, the inputs are in the right order.
     If the right list runs out of items first, the inputs are not in the right order.
     If the lists are the same length and no comparison makes a decision about the order, continue checking the next part of the input.
   - If exactly one value is an integer, convert the integer to a list which contains that integer as its only value,
     then retry the comparison. For example, if comparing [0,0,0] and 2, convert the right value to [2] (a list containing 2);
     the result is then found by instead comparing [0,0,0] and [2]."
  [left-input right-input]
  (loop [left left-input right right-input]
    (cond
      (and (not (sequential? left)) (not (sequential? right))) (compare left right)
      (not (sequential? left)) (recur [left] right)
      (not (sequential? right)) (recur left [right])
      (and (empty? left) (empty? right)) 0
      (empty? left) -1
      (empty? right) 1
      :else (let [head-comparison (compare-sequences (first left) (first right))]
              (if (not (= 0 head-comparison))
                head-comparison
                (recur (rest left) (rest right)))))))

;; utility functions

(defn add-divider-packets
  "Adds the divider packets."
  [packets]
  (->> packets
       (cons [[2]])
       (cons [[6]])))

(defn add-indexes
  "Adds 1-based indexes to a sequence of packets."
  [packets]
  (map (fn [idx val] [idx val]) (iterate inc 1) packets))

(defn extract-indexes
  "Gets just the indexes from the packets."
  [packets]
  (map (fn [[idx _]] idx) packets))

(defn flatten-one-level
  "Un-pairs the pairs of packets."
  [packets]
  (reduce (fn [acc [left right]] (cons left (cons right acc))) '() packets))

(defn filter-divider-packets
  "Gets just the divider packets."
  [packets]
  (filter (fn [[_ p]] (or (= p [[2]]) (= p [[6]]))) packets))

(defn part1 [filename]
  (->> (to-json (partition-lines (read-file filename)))
       (add-indexes)
       (filter (fn [[_ p]] (> 1 (compare-sequences (first p) (second p)))))
       (extract-indexes)
       (apply +)))

(defn part2 [filename]
  (->> (to-json (partition-lines (read-file filename)))
       (flatten-one-level)
       (add-divider-packets)
       (sort compare-sequences)
       (add-indexes)
       (filter-divider-packets)
       (extract-indexes)
       (apply *)))

(defn -main []
  (printf "day 13 part 1: %d%n" (part1 "../data/13.txt"))
  (printf "day 13 part 2: %d%n" (part2 "../data/13.txt")))