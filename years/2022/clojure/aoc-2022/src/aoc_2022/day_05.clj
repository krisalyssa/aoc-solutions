(ns aoc-2022.day-05
  (:gen-class))

(require ;; '[clojure.pprint :as pprint]
 '[clojure.string :as str])

(defn read-file [filename]
  (str/split-lines
   (slurp filename)))

(defn partition-file [s]
  (partition-by #(str/blank? %) s))

(defn split-stack-line [line]
  (partition 3 4 (str/split line #"")))

(defn parse-stack-line [line]
  (map second (split-stack-line line)))

(defn parse-stacks [lines]
  (for [line lines]
    (parse-stack-line line)))

(defn extract-labels [lines]
  (let [[labels & levels] (reverse lines)]
    [labels levels]))

(defn push-to-stack [stack crate]
  (if (str/blank? crate)
    stack
    (cons crate stack)))

(defn build-stacks [lines]
  (let [[labels levels] (extract-labels lines)
        stacks (reduce (fn [acc _] (cons '() acc)) '() labels)]
    (to-array (cons '() (reduce (fn [acc level] (map push-to-stack acc level)) stacks levels)))))

(defn parse-instruction-line [line]
  (map #(Integer/parseInt %) (rest (re-matches #"move (\d+) from (\d+) to (\d+)" line))))

(defn expand-instruction [[count from to]]
  (for [_ (range count)] [from to]))

(defn push-instruction [instruction-list instruction]
  (reduce (fn [acc item] (cons item acc)) instruction-list (expand-instruction instruction)))

(defn parse-instructions [lines]
  (let [instruction (map parse-instruction-line lines)
        instruction-list '()]
    (reverse (reduce (fn [acc item] (push-instruction acc item)) instruction-list instruction))))

(defn execute-one-instruction [stacks [from-idx to-idx]]
  (let [from-stack (aget stacks from-idx)
        crate (first from-stack)
        to-stack (aget stacks to-idx)]
    (aset stacks from-idx (rest from-stack))
    (aset stacks to-idx (cons crate to-stack))
    stacks))

(defn execute [stacks instructions]
  (reduce (fn [acc item] (execute-one-instruction acc item)) stacks instructions))

(defn stack-tops [[_ & stacks]]
  (map first stacks))

(defn part1 [filename]
  (let [[stack-lines _ instruction-lines] (partition-file (read-file filename))
        stacks (build-stacks (parse-stacks stack-lines))
        instructions (parse-instructions instruction-lines)
        final-state (execute stacks instructions)]
    (str/join (stack-tops final-state))))

;; (defn part2 [filename]
;;   (count (filter #(apply overlap? (sections %)) (read-file filename))))

(defn -main []
  (printf "day 05 part 1: %s%n" (part1 "../../data/05.txt")))
  ;; (printf "day 04 part 2: %d%n" (part2 "../../data/04.txt")))
