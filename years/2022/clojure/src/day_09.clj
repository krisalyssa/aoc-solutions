(ns day-09
  (:gen-class))

(require '[clojure.pprint :as pp]
         '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn initialize-state
  "Set up the initial state."
  [knot-count]
  {:visited (set '()) :knots (repeat knot-count {:x 0 :y 0})})

;; utility functions

(defn relative-position
  "returns the position of one knot relative to another."
  [head tail]
  [(- (get tail :x) (get head :x)) (- (get tail :y) (get head :y))])

;; functions related to fixing up a knot's position

;; The head knot moves according to the instructions supplied.
;; Each successive knot moves as necessary to fixup its position
;; relative to the one before it.

(defmulti get-fixup-move
  "Returns a vector that will move the tail back to a valid position."
  (fn [head tail] [(relative-position head tail)]))

;;  . . . . .
;;  . . . . .
;;  . . # . .  ;; knots overlap
;;  . . . . .
;;  . . . . .
(defmethod get-fixup-move [[0 0]] [_ _] [0 0])

;;  . . . . .
;;  . T T T .
;;  . T H T .  ;; T is in 3x3 neighborhood of H
;;  . T T T .
;;  . . . . .
(defmethod get-fixup-move [[1 0]] [_ _] [0 0])
(defmethod get-fixup-move [[1 -1]] [_ _] [0 0])
(defmethod get-fixup-move [[0 -1]] [_ _] [0 0])
(defmethod get-fixup-move [[-1 -1]] [_ _] [0 0])
(defmethod get-fixup-move [[-1 0]] [_ _] [0 0])
(defmethod get-fixup-move [[-1 1]] [_ _] [0 0])
(defmethod get-fixup-move [[0 1]] [_ _] [0 0])
(defmethod get-fixup-move [[1 1]] [_ _] [0 0])

;;  . . . . .
;;  . . . . .
;;  . . H . T
;;  . . . . .
;;  . . . . .
(defmethod get-fixup-move [[2 0]] [_ _] [-1 0])

;;  . . . . .
;;  . . . . .
;;  . . H . .
;;  . . . . T
;;  . . . T T
(defmethod get-fixup-move [[2 -1]] [_ _] [-1 1])
(defmethod get-fixup-move [[2 -2]] [_ _] [-1 1])
(defmethod get-fixup-move [[1 -2]] [_ _] [-1 1])

;;  . . . . .
;;  . . . . .
;;  . . H . .
;;  . . . . .
;;  . . T . .
(defmethod get-fixup-move [[0 -2]] [_ _] [0 1])

;;  . . . . .
;;  . . . . .
;;  . . H . .
;;  T . . . .
;;  T T . . .
(defmethod get-fixup-move [[-1 -2]] [_ _] [1 1])
(defmethod get-fixup-move [[-2 -2]] [_ _] [1 1])
(defmethod get-fixup-move [[-2 -1]] [_ _] [1 1])

;;  . . . . .
;;  . . . . .
;;  T . H . .
;;  . . . . .
;;  . . . . .
(defmethod get-fixup-move [[-2 0]] [_ _] [1 0])

;;  T T . . .
;;  T . . . .
;;  . . H . .
;;  . . . . .
;;  . . . . .
(defmethod get-fixup-move [[-2 1]] [_ _] [1 -1])
(defmethod get-fixup-move [[-2 2]] [_ _] [1 -1])
(defmethod get-fixup-move [[-1 2]] [_ _] [1 -1])

;;  . . T . .
;;  . . . . .
;;  . . H . .
;;  . . . . .
;;  . . . . .
(defmethod get-fixup-move [[0 2]] [_ _] [0 -1])

;;  . . . T T
;;  . . . . T
;;  . . H . .
;;  . . . . .
;;  . . . . .
(defmethod get-fixup-move [[1 2]] [_ _] [-1 -1])
(defmethod get-fixup-move [[2 2]] [_ _] [-1 -1])
(defmethod get-fixup-move [[2 1]] [_ _] [-1 -1])

(defn move-knot-by-direction
  "Moves a knot one step in the indicated direction."
  [knot direction]
  (case direction
    :up (update knot :y (fn [y] (inc y)))
    :down (update knot :y (fn [y] (dec y)))
    :left (update knot :x (fn [x] (dec x)))
    :right (update knot :x (fn [x] (inc x)))))

(defn move-knot-by-vector
  "Moves a knot by applying a vector."
  [knot [move-x move-y]]
  (-> knot
      (update :x (fn [x] (+ x move-x)))
      (update :y (fn [y] (+ y move-y)))))

(defn fixup-one-knot
  "Move a knot so it's in a valid position."
  [head tail]
  (move-knot-by-vector tail (get-fixup-move head tail)))

(defn fixup-knots
  "Apply fixups to an entire rope."
  [knots]
  (let [head (first knots) fixup-state {:head head :knot-list (list head)}]
    (reverse
     (get
      (reduce (fn [state, knot]
                (let [new-knot (fixup-one-knot (get state :head) knot)]
                  (-> state
                      (update :head (fn [_] new-knot))
                      (update :knot-list (fn [old-list] (cons new-knot old-list)))))) fixup-state (rest knots))
      :knot-list))))

(defn visit
  "Mark the location of the knot as visited."
  [state knot]
  (let [x (get knot :x) y (get knot :y)]
    (update state :visited (fn [v] (conj v [x y])))))

;; execute the list of instructions

(defn execute-one-step
  "Executes a single step in the instructions."
  [state direction]
  (let [knots (get state :knots)
        head (move-knot-by-direction (first knots) direction)
        new-knots (fixup-knots (cons head (rest knots)))]
    (-> state
        (visit (last new-knots))
        (update :knots (fn [_] new-knots)))))

(defn execute-one-line
  "Executes one line in the instructions."
  [state line]
  (let [[dir-str count-str] (rest (re-matches #"([DLRU])\s+(\d+)" line))
        direction (case dir-str
                    "D" :down
                    "L" :left
                    "R" :right
                    "U" :up)]
    (reduce (fn [acc _] (execute-one-step acc direction)) state (range (Integer/parseInt count-str)))))

(defn part1 [filename]
  (let [instructions (read-file filename)
        state (initialize-state 2)]
    (-> (reduce (fn [acc line] (execute-one-line acc line)) state instructions)
        (get :visited)
        count)))

(defn part2 [filename]
  (let [instructions (read-file filename)
        state (initialize-state 10)]
    (-> (reduce (fn [acc line] (execute-one-line acc line)) state instructions)
        (get :visited)
        count)))

(defn -main []
  (printf "day 09 part 1: %d%n" (part1 "../data/09.txt"))
  (printf "day 09 part 2: %d%n" (part2 "../data/09.txt")))
