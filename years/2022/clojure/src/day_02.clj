(ns day-02
  (:gen-class))

(require '[clojure.string :as str])

(defn read-file [filename]
  (str/split-lines
   (slurp filename)))

(defn moves [s]
  (map #(str/split % #"\s+") s))

(defmulti score (fn [x] x))
(defmethod score ["A" "X"] [_] 4) ;; 1 + 3
(defmethod score ["A" "Y"] [_] 8) ;; 2 + 6
(defmethod score ["A" "Z"] [_] 3) ;; 3 + 0
(defmethod score ["B" "X"] [_] 1) ;; 1 + 0
(defmethod score ["B" "Y"] [_] 5) ;; 2 + 3
(defmethod score ["B" "Z"] [_] 9) ;; 3 + 6
(defmethod score ["C" "X"] [_] 7) ;; 1 + 6
(defmethod score ["C" "Y"] [_] 2) ;; 2 + 0
(defmethod score ["C" "Z"] [_] 6) ;; 3 + 3

(defn scores [filename]
  (map score (moves (read-file filename))))

(defmulti strategy (fn [x] x))
(defmethod strategy ["A" "X"] [_] "Z") ;; rock + ? = lose
(defmethod strategy ["A" "Y"] [_] "X") ;; rock + ? = draw
(defmethod strategy ["A" "Z"] [_] "Y") ;; rock + ? = win
(defmethod strategy ["B" "X"] [_] "X") ;; paper + ? = lose
(defmethod strategy ["B" "Y"] [_] "Y") ;; paper + ? = draw
(defmethod strategy ["B" "Z"] [_] "Z") ;; paper + ? = win
(defmethod strategy ["C" "X"] [_] "Y") ;; scissors + ? = lose
(defmethod strategy ["C" "Y"] [_] "Z") ;; scissors + ? = draw
(defmethod strategy ["C" "Z"] [_] "X") ;; scissors + ? = win

(defn pick-move [[opponent outcome]]
  [opponent (strategy [opponent outcome])])

(defn revised-scores [filename]
  (map #(score (pick-move %))
       (moves (read-file filename))))

(defn part1 [filename]
  (reduce + (scores filename)))

(defn part2 [filename]
  (reduce + (revised-scores filename)))

(defn -main []
  (printf "day 02 part 1: %d%n" (part1 "../data/02.txt"))
  (printf "day 02 part 2: %d%n" (part2 "../data/02.txt")))
