(ns aoc-2022.day-15
  (:gen-class))

(require '[clojure.pprint :as pp]
         '[clojure.string :as str]
         '[clojure.math.combinatorics :as combo]
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

(defn part1
  [filename row-num]
  (->> filename
       (read-file)
       (parse-sensors)
       (calculate-regions)
       (filter (partial crosses-row? row-num))
       (collect-projections-on-row row-num)
       (count)))

;; For part 2, the brute force problem space is prohibitively large (4000000^2 or 1.6x10^13 points), so we'll need to get smart.
;; Is it possible to rotate the entire grid 45°? That would allow us to reduce the search space from 4000000 x 4000000 to
;; something substantially smaller.
;; Then again, there are only 24 sensors. Any beacon not detected will be bounded by the regions of four sensors (one for each
;; side). Each region will have one side that intersects with two other regions, for a total of eight intersections.
;; _But_ four of them will be doubled, _and_ they will be one coordinate away from the target beacon in each of the
;; cardinal directions.
;; 24 combinations 4 at a time is 10626 combinations to test. *That* is a smaller problem space.
;;
;; I think it may be even simpler than I originally thought. Try this one:
;;   1. Get the line segments for the sides of all of the regions.
;;   2. Divide them into two groups: those with positive slopes and those with negative slopes.
;;   3. Iterate all combinations of positively-sloped line segments, two at a a time. Look for pairs with one location between them.
;;   4. Do the same for the negatively-sloped line segments.
;;   5. Iterate all pairs of pairs to get the points that fall between four regions.
;;   6. Iterate all of those points to see which one doesn't fall within any region.
;;
;; The problem space is bigger than I thought it would be, but still much smaller than a brute force approach would require.
;; I was expecting the sample data to have a small handful of intersecting pairs of lines, but in fact there are
;; a maximum of (68 * 62 = 4216) intersecting pairs.

(defn region-borders
  "Returns line segments representing the borders of a region."
  [record]
  (let [{[sensor-x sensor-y] :sensor {x1 :x1 y1 :y1 x2 :x2 y2 :y2} :region} record
        top [sensor-x y1]
        bottom [sensor-x y2]
        left [x1 sensor-y]
        right [x2 sensor-y]]
    [[top right] [right bottom] [bottom left] [left top]]))

(defn slope-offset
  "Calculates the slope and offset of a line."
  [[[px py] [qx qy]]]
  (let [slope (/ (- qy py) (- qx px))]
    {:slope slope :offset (- py (* slope px))}))

(defn orientation3
  "Determines the orientation of an ordered triplet of points."
  [[px py] [qx qy] [rx ry]]
  (let [delta (- (* (- qy py) (- rx qx)) (* (- qx px) (- ry qy)))]
    (cond
      (< delta 0) :anticlockwise
      (> delta 0) :clockwise
      :else :collinear)))

(defn point-on-segment?
  "Returns true if the point lies on the segment."
  [[px py] [qx qy] [rx ry]]
  (and (<= rx (max px qx)) (>= rx (min px qx)) (<= ry (max py qy)) (>= ry (min py qy))))

(defn lines-intersect?
  "Returns true if two lines intersect."
  [[line1p1 line1p2] [line2p1 line2p2]]
  (let [o1 (orientation3 line1p1 line1p2 line2p1)
        o2 (orientation3 line1p1 line1p2 line2p2)
        o3 (orientation3 line2p1 line2p2 line1p1)
        o4 (orientation3 line2p1 line2p2 line1p2)]
    (cond
      (and (not= o1 o2) (not= o3 o4)) true
      (and (= :collinear o1) (point-on-segment? line1p1 line1p2 line2p1)) true
      (and (= :collinear o2) (point-on-segment? line1p1 line1p2 line2p2)) true
      (and (= :collinear o3) (point-on-segment? line2p1 line2p2 line1p1)) true
      (and (= :collinear o4) (point-on-segment? line2p1 line2p2 line1p2)) true
      :else false)))

(defn extract-lines
  "Flattens the list one level.
   Maybe two. I need to read the code closer."
  [regions]
  (loop [all-lines '() region-list regions]
    (if (empty? region-list)
      all-lines
      (recur (loop [lines all-lines region-lines (first region-list)]
               (if (empty? region-lines)
                 lines
                 (recur (cons (first region-lines) lines) (rest region-lines)))) (rest region-list)))))

(defn separate-by-slope
  "Partitions a list of line segments by slope.
   Fortunately, there are only two slopes, so we don't have to get fancy."
  [lines]
  {1 (filter (fn [line] (= 1 (:slope (slope-offset line)))) lines)
   -1 (filter (fn [line] (= -1 (:slope (slope-offset line)))) lines)})

(defn filter-close-pairs
  "Returns all pairs of lines that have one blank location space between them."
  [lines]
  (filter (fn [[line1 line2]]
            (let [{offset1 :offset} (slope-offset line1)
                  {offset2 :offset} (slope-offset line2)]
              (= 2 (abs (- offset1 offset2)))))
          (combo/permuted-combinations lines 2)))

(defn filter-all-close-pairs
  "Returns all close pairs of lines for both slopes."
  [lines-by-slope]
  (as-> lines-by-slope lines
    (assoc lines 1 (filter-close-pairs (get lines 1)))
    (assoc lines -1 (filter-close-pairs (get lines -1)))))

(defn pairs-intersect?
  "Returns `true` if the line segments intersect to form a rectangle."
  [pair-up pair-down]
  (and (lines-intersect? (first pair-up) (first pair-down))
       (lines-intersect? (first pair-up) (second pair-down))
       (lines-intersect? (second pair-up) (first pair-down))
       (lines-intersect? (second pair-up) (second pair-down))))

(defn intersection-of
  "Gets the intersection point of two lines."
  [line1 line2]
  (let [{slope1 :slope offset1 :offset} (slope-offset line1)
        {slope2 :slope offset2 :offset} (slope-offset line2)
        x (/ (- offset2 offset1) (- slope1 slope2))
        y (+ (* slope1 x) offset1)]
    [x y]))

(defn bounded-single-point
  "If the rectangle formed by the four points bounds a single (fifth) point, returns it, otherwise returns `nil`."
  [[p1 p2 p3 p4]]
  (let [min-x (apply min (map first [p1 p2 p3 p4]))
        max-x (apply max (map first [p1 p2 p3 p4]))
        min-y (apply min (map second [p1 p2 p3 p4]))
        max-y (apply max (map second [p1 p2 p3 p4]))]
    (if (and (= 2 (- max-x min-x)) (= 2 (- max-y min-y)))
      [(dec max-x) (dec max-y)]
      nil)))

(defn uniq
  "Returns only the unique items in the list."
  [items]
  (into '() (set items)))

(defn point-in-region?
  "Returns `true` if the point falls within the region."
  [[x y] region]
  (let [center-x (/ (+ (:x2 region) (:x1 region)) 2)
        center-y (/ (+ (:y2 region) (:y1 region)) 2)]
    (and (>= x (+ (:x1 region) (abs (- center-y y))))
         (<= x (- (:x2 region) (abs (- center-y y))))
         (>= y (+ (:y1 region) (abs (- center-x x))))
         (<= y (- (:y2 region) (abs (- center-x x)))))))

(defn part2
  [filename]
  (let [records (->> filename
                     (read-file)
                     (parse-sensors)
                     (calculate-regions))
        regions (map :region records)
        lines-by-slope
        (->> records
             (map region-borders)
             (extract-lines)
             (separate-by-slope)
             (filter-all-close-pairs))
        all-bounded-regions (for [pair-up (get lines-by-slope 1) pair-down (get lines-by-slope -1) :when (pairs-intersect? pair-up pair-down)]
                              (for [line-up pair-up line-down pair-down] (intersection-of line-up line-down)))
        candidates (uniq (map bounded-single-point all-bounded-regions))
        successful (filter (fn [p] (not (some (partial point-in-region? p) regions))) candidates)]
    (if (= 1 (count successful))
      (+ (* (first (first successful)) 4000000) (second (first successful)))
      (do (println "too many candidates") 0))))

(defn -main []
  (printf "day 15 part 1: %d%n" (part1 "../data/15.txt" 2000000))
  (printf "day 15 part 2: %d%n" (part2 "../data/15.txt")))
