(ns aoc-2022.day-06
  (:gen-class))

(require ;; '[clojure.pprint :as pp]
 '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a single string."
  [filename]
  (str/trim-newline (slurp filename)))

(defn is-marker?
  "Checks if the string is a start-of-packet marker."
  [s]
  (= (count (set (str/split s #""))) (count s)))

(defn scan-for-marker
  "Scans a string for the start-of-packet marker.
   Packets are indicated by four consecutive characters, none of which are repeated.
   So
       abcd
   would be a start-of-packet marker, but
       abca
   would not be."
  [buffer marker-length]
  (loop [remaining buffer
         idx marker-length]
    (let [candidate (subs remaining 0 marker-length)]
      (if (is-marker? candidate)
        idx
        (if (<= (count remaining) marker-length)
          0
          (recur (subs remaining 1) (inc idx)))))))

(defn part1 [filename]
  (scan-for-marker (read-file filename) 4))

(defn part2 [filename]
  (scan-for-marker (read-file filename) 14))

(defn -main []
  (printf "day 06 part 1: %d%n" (part1 "../data/06.txt"))
  (printf "day 06 part 2: %d%n" (part2 "../data/06.txt")))
