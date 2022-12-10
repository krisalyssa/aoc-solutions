(ns aoc-2022.day-09
  (:gen-class))

(require ;; '[clojure.pprint :as pp]
 '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn initialize-state
  "Set up the initial state."
  []
  {:visited (set '()) :h {:x 0 :y 0} :t {:x 0 :y 0}})

;; utility functions

(defn relative-position
  "returns the position of `t` relative to `h`."
  [h t]
  [(- (get t :x) (get h :x)) (- (get t :y) (get h :y))])

;; functions related to moving the head and tail positions

;; There are 36 possible state changes with each move -- 9 starting positions (T relative to H)
;; and 4 directions H can go.
;; Assume H is at [0 0]. Then T can be at [{-1,0,1} {-1,0,1}], where X and Y increase right and up respectively.
;; The four directions should be self-explanatory.

(defmulti get-tail-move
  "Moves T according to its location relative to H, and the direction H is moving."
  (fn [h t dir] [(relative-position h t) dir]))

;;  . . .
;;  . H .
;;  T . .
(defmethod get-tail-move [[-1 -1] :up] [_ _ _] [1 1])
(defmethod get-tail-move [[-1 -1] :down] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 -1] :left] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 -1] :right] [_ _ _] [1 1])

;;  . . .
;;  . H .
;;  . T .
(defmethod get-tail-move [[0 -1] :up] [_ _ _] [0 1])
(defmethod get-tail-move [[0 -1] :down] [_ _ _] [0 0])
(defmethod get-tail-move [[0 -1] :left] [_ _ _] [0 0])
(defmethod get-tail-move [[0 -1] :right] [_ _ _] [0 0])

;;  . . .
;;  . H .
;;  . . T
(defmethod get-tail-move [[1 -1] :up] [_ _ _] [-1 1])
(defmethod get-tail-move [[1 -1] :down] [_ _ _] [0 0])
(defmethod get-tail-move [[1 -1] :left] [_ _ _] [-1 1])
(defmethod get-tail-move [[1 -1] :right] [_ _ _] [0 0])

;;  . . .
;;  T H .
;;  . . .
(defmethod get-tail-move [[-1 0] :up] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 0] :down] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 0] :left] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 0] :right] [_ _ _] [1 0])

;;  . . .
;;  . # .
;;  . . .
(defmethod get-tail-move [[0 0] :up] [_ _ _] [0 0])
(defmethod get-tail-move [[0 0] :down] [_ _ _] [0 0])
(defmethod get-tail-move [[0 0] :left] [_ _ _] [0 0])
(defmethod get-tail-move [[0 0] :right] [_ _ _] [0 0])

;;  . . .
;;  . H T
;;  . . .
(defmethod get-tail-move [[1 0] :up] [_ _ _] [0 0])
(defmethod get-tail-move [[1 0] :down] [_ _ _] [0 0])
(defmethod get-tail-move [[1 0] :left] [_ _ _] [-1 0])
(defmethod get-tail-move [[1 0] :right] [_ _ _] [0 0])

;;  T . .
;;  . H .
;;  . . .
(defmethod get-tail-move [[-1 1] :up] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 1] :down] [_ _ _] [1 -1])
(defmethod get-tail-move [[-1 1] :left] [_ _ _] [0 0])
(defmethod get-tail-move [[-1 1] :right] [_ _ _] [1 -1])

;;  . T .
;;  . H .
;;  . . .
(defmethod get-tail-move [[0 1] :up] [_ _ _] [0 0])
(defmethod get-tail-move [[0 1] :down] [_ _ _] [0 -1])
(defmethod get-tail-move [[0 1] :left] [_ _ _] [0 0])
(defmethod get-tail-move [[0 1] :right] [_ _ _] [0 0])

;;  . . T
;;  . H .
;;  . . .
(defmethod get-tail-move [[1 1] :up] [_ _ _] [0 0])
(defmethod get-tail-move [[1 1] :down] [_ _ _] [-1 -1])
(defmethod get-tail-move [[1 1] :left] [_ _ _] [-1 -1])
(defmethod get-tail-move [[1 1] :right] [_ _ _] [0 0])

(defn move-head
  "Moves H one step in the indicated direction."
  [h direction]
  (case direction
    :up (update h :y (fn [y] (inc y)))
    :down (update h :y (fn [y] (dec y)))
    :left (update h :x (fn [x] (dec x)))
    :right (update h :x (fn [x] (inc x)))))

(defn move-tail
  "Moves T in response to H's position."
  [t [move-x move-y]]
  (-> t
      (update :x (fn [x] (+ x move-x)))
      (update :y (fn [y] (+ y move-y)))))

(defn visit
  "Mark the tail location as visited."
  [state]
  (let [x (get-in state [:t :x]) y (get-in state [:t :y])]
    (update state :visited (fn [v] (conj v [x y])))))

;; execute the list of instructions

(defn execute-one-step
  "Executes a single step in the instuctions."
  [state direction]
  (let [h (get state :h)
        t (get state :t)
        tail-move (get-tail-move h t direction)]
    (-> state
        (update :h (fn [v] (move-head v direction)))
        (update :t (fn [v] (move-tail v tail-move)))
        visit)))

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
        state (initialize-state)]
    (-> (reduce (fn [acc line] (execute-one-line acc line)) state instructions)
        (get :visited)
        count)))

;; (defn part2 [filename]
;;   (let [grid (as-grid (read-file filename))
;;         [row-count col-count] (matrix/shape grid)
;;         row-col-seq (for [row-num (range row-count) col-num (range col-count)] [row-num col-num])]
;;     (apply max (map (fn [[row-num col-num]] (scenic-score grid row-num col-num)) row-col-seq))))

(defn -main []
  (printf "day 09 part 1: %d%n" (part1 "../../data/09.txt")))
  ;; (printf "day 09 part 2: %d%n" (part2 "../../data/09.txt")))
