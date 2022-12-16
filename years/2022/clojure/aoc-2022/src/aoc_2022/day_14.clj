(ns aoc-2022.day-14
  (:gen-class))

(require '[clojure.pprint :as pp]
         '[clojure.string :as str])

;; initialization functions

(defn parse-point
  "Parse a single point."
  [line]
  (->> line
       (re-matches #"^\s*(\d+)\s*,\s*(\d+)\s*$")
       (rest)
       (map #(Integer/parseInt %))))

(defn parse-line
  "Parse a single line into a sequence of points."
  [line]
  (as-> line s
    (str/split s #"\s*->\s*")
    (map parse-point s)))

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

;; utility functions

(defn min-max
  "Apply a function to the indicated element in a sequence."
  [cave f n]
  (as-> cave value
    (map (fn [p] (nth p (dec n))) value)
    (apply f value)))

(defn min-x
  "Find the smallest x value."
  [s]
  (min-max s min 1))

(defn max-x
  "Find the largest x value."
  [s]
  (min-max s max 1))

(defn min-y
  "Find the smallest x value."
  [s]
  (min-max s min 2))

(defn max-y
  "Find the largest x value."
  [cave]
  (min-max cave max 2))

(defn draw-one-segment
  "Create points for one segment."
  [cave [[x1 y1] [x2 y2]]]
  (let [[x1 x2] (sort (vector x1 x2))
        [y1 y2] (sort (vector y1 y2))
        cave (-> cave
                 (conj [x1 y1])
                 (conj [x2 y2]))]
    (cond
      (= x1 x2) (reduce (fn [acc y] (conj acc [x1 y])) cave (range y1 (inc y2)))
      (= y1 y2) (reduce (fn [acc x] (conj acc [x y1])) cave (range x1 (inc x2)))
      :else cave)))

(defn draw-one-path
  "Create points for one path."
  [cave path]
  (reduce draw-one-segment cave (partition 2 1 path)))

(defn draw-paths
  "Create points for all of the paths."
  [cave paths]
  (reduce draw-one-path cave paths))

(defn add-sand
  "Adds a unit of sand to the cave map."
  [cave [x y]]
  (conj cave [x y]))

(defn get-sand-move
  "Gets the next location a unit of sand can move to.
   If the next location is off the bottom of the map (max Y plus 3), returns :freefall.
   If all possible next locations are blocked, returns :stop."
  [cave [x y]]
  (let [down [x (inc y)]
        down-and-left [(dec x) (inc y)]
        down-and-right [(inc x) (inc y)]]
    (cond
      (get cave [x y]) :stop
      (< (max-y cave) (second down)) :freefall
      (not (get cave down)) down
      (not (get cave down-and-left)) down-and-left
      (not (get cave down-and-right)) down-and-right
      :else :drop)))

(defn drop-sand
  "Drops a unit of sand into the cave."
  [cave]
  (loop [position [500 0]]
    (let [next-position (get-sand-move cave position)]
      (case next-position
        :stop :stop
        :drop (add-sand cave position)
        :freefall :stop
        (recur next-position)))))

(defn render-cave
  [cave]
  (let [x-min (min-x cave)
        x-max (max-x cave)
        y-max (max-y cave)]
    (loop [x x-min y 0]
      (let [value (get cave [x y])]
        (cond
          (> y y-max) (println "")
          (> x x-max) (do (println "") (recur x-min (inc y)))
          (and (= x 500) (= y 0)) (do (printf "+") (recur (inc x) y))
          (nil? value) (do (printf ".") (recur (inc x) y))
          :else  (do (printf "#") (recur (inc x) y)))))))

(defn part1 [filename]
  (let [paths (map parse-line (read-file filename))
        initial-cave (draw-paths (set '()) paths)]
    (loop [cave initial-cave units 1]
      (let [new-cave (drop-sand cave)]
        (if (= :stop new-cave)
          (dec units)
          (recur new-cave (inc units)))))))

(defn part2 [filename]
  (let [paths (map parse-line (read-file filename))
        initial-cave (draw-paths (set '()) paths)
        floor-y (+ 2 (max-y initial-cave))
        initial-cave (draw-one-path initial-cave [[(dec (- 500 floor-y)) floor-y] [(inc (+ 500 floor-y)) floor-y]])]
    (loop [cave initial-cave units 1]
      (let [new-cave (drop-sand cave)]
        (if (= :stop new-cave)
          (do (newline) (dec units))
          (if (> units 30000)
            (printf "%nstopping after %d units%n" (dec units))
            (recur new-cave (inc units))))))))

(defn -main []
  (printf "day 14 part 1: %d%n" (part1 "../../data/14.txt"))
  (printf "day 14 part 2: %d%n" (part2 "../../data/14.txt")))