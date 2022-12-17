(ns aoc-2022.day-15
  (:gen-class))

(require '[clojure.pprint :as pp]
         '[clojure.string :as str]
         '[clojure.set :as sets])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn parse-one-line
  "Parses a single line of input."
  [line]
  (let [[_ sensor-x sensor-y beacon-x beacon-y] (re-matches #"Sensor at x=([-+0-9]+), y=([-+0-9]+): closest beacon is at x=([-+0-9]+), y=([-+0-9]+)" line)
        sensor-x (Integer/parseInt sensor-x)
        sensor-y (Integer/parseInt sensor-y)
        beacon-x (Integer/parseInt beacon-x)
        beacon-y (Integer/parseInt beacon-y)]
    {:sensor [sensor-x sensor-y] :beacon [beacon-x beacon-y]}))

(defn parse-sensors
  "Parses the input lines."
  [lines]
  (map parse-one-line lines))

;; functions for calculate regions

(defn calculate-one-region
  "Determines the region for one sensor."
  [record]
  (let [sensor (:sensor record)
        sensor-x (first sensor)
        sensor-y (second sensor)
        beacon (:beacon record)
        beacon-x (first beacon)
        beacon-y (second beacon)
        dx (abs (- sensor-x beacon-x))
        dy (abs (- sensor-y beacon-y))
        axis-length (+ dx dy)
        region {:x1 (- sensor-x axis-length) :x2 (+ sensor-x axis-length) :y1 (- sensor-y axis-length) :y2 (+ sensor-y axis-length)}]
    (assoc record :region region)))

(defn calculate-regions
  "Determines regions for the sensors."
  [sensors]
  (map calculate-one-region sensors))

;; functions for getting intersections of regions and a row

(defn crosses-row?
  "Returns true if the sensor's region intersects the given row."
  [row-num record]
  (or (and (<= row-num (:y1 (:region record)))
           (>= row-num (:y2 (:region record))))
      (and (>= row-num (:y1 (:region record)))
           (<= row-num (:y2 (:region record))))))

(defn project-on-row
  "Gets the points in the projection of one sensor's region on the given row."
  [row-num record]
  (let [{[sensor-x sensor-y] :sensor [beacon-x beacon-y] :beacon {x1 :x1 y1 :y1 x2 :x2 y2 :y2} :region} record
        dx1 (- row-num y1)
        dx2 (- y2 row-num)
        projection
        (into (set '())
              (case (compare row-num sensor-y)
                -1 (range (- sensor-x dx1) (+ sensor-x (inc dx1)))
                0 (range x1 (inc x2))
                1 (range (- sensor-x dx2) (+ sensor-x (inc dx2)))))]

    ;; remove the beacon's location if it's in the set
    (if (= row-num beacon-y)
      (disj projection beacon-x)
      projection)))

(defn collect-projections-on-row
  "Gets the union of all points in all sensors which intersect the given row."
  [row-num records]
  (->> records
       (map (partial project-on-row row-num))
       (apply sets/union)))

;; For any given sensor, we know that there's a diagonal region (a square rotated 45°) centered on the sensor's location
;; with vertexes in the four cardinal directions at a distance equal to the Manhattan distance between the sensor and
;; its detected beacon.

;; For part 1, we're only interested in the sensors whose regions intersect row 20000 (or row 10 in the sample data).
;; So we can throw out any sensors for whom the top and bottom vertexes are on the same side of the row.
;; Of the remaining sensors, generate the line segments for the intersections of the sensors with the row and union them.
;; The number of points in the union is the answer.

(defn part1 [filename row-num]
  (->> filename
       (read-file)
       (parse-sensors)
       (calculate-regions)
       (filter (partial crosses-row? row-num))
       (collect-projections-on-row row-num)
       (count)))

;; (defn part1 [filename]
;;   (let [lines (read-file filename)
;;         blocks (partition-lines lines)]
;;     (as-> blocks value
;;       (parse-monkeys value)
;;       (run-n-rounds (fn [v] (quot v 3)) value 20)
;;       (map :inspections (vals value))
;;       (sort value)
;;       (take-last 2 value)
;;       (apply * value))))

;; (defn part2 [filename]
;;   (let [lines (read-file filename)
;;         blocks (partition-lines lines)]
;;     (as-> blocks value
;;       (parse-monkeys value)
;;       (run-n-rounds identity value 10000)
;;       (map :inspections (vals value))
;;       (sort value)
;;       (take-last 2 value)
;;       (apply * value))))

(defn -main []
  (printf "day 15 part 1: %d%n" (part1 "../../data/15.txt" 2000000)))
;;   (printf "day 15 part 2: %d%n" (part2 "../../data/15.txt")))
