(ns day-01
  (:gen-class))

(require '[clojure.data.json :as json])
(require '[clojure.string :as str])

(defn read-file-as-one-string
  "Reads the file and returns it as a single string."
  [filename]
  (str/trim-newline (slurp filename)))

;; (defn read-file-as-string-list
;;   "Reads the file and returns it as a list of strings."
;;   [filename]
;;   (str/split-lines
;;    (slurp filename)))

;; https://stackoverflow.com/a/4831170 :-)
(defn find-basement [needle haystack]
  (keep-indexed #(when (= %2 needle) %1) haystack))

(defn move [floor instruction]
  (case instruction
    "(" (+ floor 1)
    ")" (- floor 1)))

(defn part1 [data]
  (reduce move 0 (str/split data #"")))

(defn part2 [data]
  (first (find-basement -1 (reductions move 0 (str/split data #"")))))

(defn -main []
  (printf "%s%n" (json/write-str {:day_01 [(part1 (read-file-as-one-string "../data/01.txt")) (part2 (read-file-as-one-string "../data/01.txt"))]} :indent true)))
