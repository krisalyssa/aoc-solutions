(ns day-05
  (:gen-class))

(require ;; '[clojure.pprint :as pprint]
 '[clojure.string :as str])

;; common functions (used in multiple places)

(defn put-on-stack
  "Places one or more crates on the top of a stack and returns the new stack."
  [stack crates]
  (concat crates stack))

(defn take-from-stack
  "Removes one or more crates from the top of a stack and returns the removed crates
   and the new stack.
   Note: currently the number of crates to remove is hardcoded to 1.
   That needs to be passed in as a parameter."
  [n stack]
  (split-at n stack))

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn partition-file
  "Divides a sequence of lines at the first blank line."
  [s]
  (partition-by #(str/blank? %) s))

(defn split-stack-line
  "Splits a line representing a single layer into a sequence of crates (or open air above a stack).
   Each line is formatted like
   ```
       [A] [B]    [C]
   ```
   Each slot in the line for a stack is three characters, either a symbol (always an uppercase letter?)
   in square brackets or three whitespace characters. Slots are separated by single whitespace characters."
  [line]
  (partition 3 4 (str/split line #"")))

(defn parse-stack-line
  "Parses a string representing a single layer, returning a sequence of symbols representing crates or open air."
  [line]
  (map second (split-stack-line line)))

(defn parse-stack-lines
  "Parses the strings representing all layers in the stacks."
  [lines]
  (for [line lines]
    (parse-stack-line line)))

(defn extract-labels
  "Separates stack lines into a string of labels and a sequence of lines representing all layers in the stacks."
  [lines]
  (let [[labels & levels] (reverse lines)]
    [labels levels]))

(defn put-one-crate-on-stack
  "Places a crate on the top of a stack and returns the new stack.
   If the value of `crate` is whitespace, do nothing."
  [stack crate]
  (if (str/blank? crate)
    stack
    (cons crate stack)))

(defn initialize-stacks
  "Sets up the initial state of the stacks."
  [lines]
  (let [[labels levels] (extract-labels lines)
        stacks (reduce (fn [acc _] (cons '() acc)) '() labels)]
    (to-array (cons '() (reduce (fn [acc level] (map put-one-crate-on-stack acc level)) stacks levels)))))

(defn parse-instruction-line
  "Parses an instruction line into a sequence of (from-stack to-stack).
   Currently assumes only one crate is being moved."
  [line]
  (map #(Integer/parseInt %)
       (rest (re-matches #"move (\d+) from (\d+) to (\d+)" line)))) ;; (rest *) to lose the whole pattern match

;; functions which change behavior based on the selector

(defn expand-instruction
  "Expands instructions for moving crates into a sequence of instructions moving a single crate."
  [selector [count from to]]
  (if (= selector :cm9000)
    (for [_ (range count)] [1 from to])
    (list [count from to])))

(defn add-instruction-to-list
  "Adds instructions for a source line to the list and returns the new list.
   For the CrateMover 9000, source lines which indicate moving multiple crates need to be expanded
   into multiple instructions moving one crate each."
  [selector instruction-list instruction]
  (reduce (fn [acc item] (cons item acc)) instruction-list (expand-instruction selector instruction)))

(defn parse-instruction-lines
  "Parses the strings representing instructions for moving crates."
  [selector lines]
  (let [instruction (map parse-instruction-line lines)
        instruction-list '()]
    (reverse (reduce (fn [acc item] (add-instruction-to-list selector acc item)) instruction-list instruction))))

;; functions for the CrateMover 900x

(defn execute-one-instruction
  "Executes a single instruction for moving crates."
  [stacks [n from-idx to-idx]]
  (let [from-stack (aget stacks from-idx)
        [crates new-from-stack] (take-from-stack n from-stack)
        to-stack (aget stacks to-idx)]
    (aset stacks from-idx new-from-stack)
    (aset stacks to-idx (put-on-stack to-stack crates))
    stacks))

(defn execute
  "Executes a list of instructions for moving crates."
  [stacks instructions]
  (reduce (fn [acc item] (execute-one-instruction acc item)) stacks instructions))

;; functions to get the puzzle answers

(defn stack-tops
  "Returns a sequence of the crates at the top of each stack."
  [[_ & stacks]]
  (map first stacks))

(defn part1 [filename]
  (let [[stack-lines _ instruction-lines] (partition-file (read-file filename))
        stacks (initialize-stacks (parse-stack-lines stack-lines))
        instructions (parse-instruction-lines :cm9000 instruction-lines)
        final-state (execute stacks instructions)]
    (str/join (stack-tops final-state))))

(defn part2 [filename]
  (let [[stack-lines _ instruction-lines] (partition-file (read-file filename))
        stacks (initialize-stacks (parse-stack-lines stack-lines))
        instructions (parse-instruction-lines :cm9001 instruction-lines)
        final-state (execute stacks instructions)]
    (str/join (stack-tops final-state))))

(defn -main []
  (printf "day 05 part 1: %s%n" (part1 "../data/05.txt"))
  (printf "day 05 part 2: %s%n" (part2 "../data/05.txt")))
