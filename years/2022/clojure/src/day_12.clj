(ns day-12
  (:gen-class))

(require '[clojure.core.matrix :as matrix]
         '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn make-cell
  "Returns a new cell.
   This function should initialize everything in the cell except for the :x and :y values."
  [value]
  {:value value :visited false})

(defn as-grid
  "Converts row data into a 2D matrix.
   Assumes that each item in the input list is a string of digits,
   and that each string has the same length."
  [rows]
  (matrix/matrix (map (fn [row] (map (fn [c] (make-cell (case c "S" :start "E" :end (first (.getBytes c))))) (str/split row #""))) rows)))

;; queue functions

(defn queue
  "Creates a queue (FIFO). Borrowed from https://admay.github.io/queues-in-clojure/"
  ([] (clojure.lang.PersistentQueue/EMPTY))
  ([coll]
   (reduce conj clojure.lang.PersistentQueue/EMPTY coll)))

;; graph functions

(defn get-cell
  "Gets the cell at the given coordinates."
  [m [y x]]
  (-> (matrix/mget m y x)
      (assoc :y y)
      (assoc :x x)))

(defn mfind
  "Returns the first cell for which the predicate returns true."
  [m pred]
  (let [[rows cols] (matrix/shape m)]
    (loop [y 0 x 0]
      (if (= y rows)
        nil
        (if (= x cols)
          (recur (inc y) 0)
          (let [cell (get-cell m [y x])]
            (if (pred cell)
              cell
              (recur y (inc x)))))))))

(defn get-height
  "Gets the height value for the given cell."
  [cell]
  (let [value (:value cell)]
    (case value
      :start 97
      :end 122
      value)))

(defn is-start?
  "Returns `true` if the cell is the start cell."
  [cell]
  (= :start (:value cell)))

(defn is-end?
  "Returns `true` if the cell is the end cell."
  [cell]
  (= :end (:value cell)))

(defn is-lowest-elevation?
  "Returns `true` if the cell is at the lowest possible elevation."
  [cell]
  (= 97 (get-height cell)))

(defn valid-coord?
  "Returns `true` if the coordinate is valid for the grid."
  [m [y x]]
  (and (>= y 0) (< y (matrix/row-count m)) (>= x 0) (< x (matrix/column-count m))))

(defn not-too-high?
  "Returns true if we can climb up to the cell from here."
  [here there]
  (let [here-height (get-height here)
        there-height (get-height there)]
    (>= here-height (dec there-height))))

(defn not-too-low?
  "Returns true if we can climb up to here from the cell there."
  [there here]
  (let [here-height (get-height here)
        there-height (get-height there)]
    (>= here-height (dec there-height))))

(defn not-visited?
  "Returns true if the cell hasn't been visited yet."
  [cell]
  (= (:visited cell) false))

(defn neighbors-of
  "Returns the neighbors of the cell which haven't been visited and can be climbed to."
  [graph cell climbable-pred]
  (let [y (:y cell)
        x (:x cell)
        this cell
        up [(dec y) x]
        down [(inc y) x]
        left [y (dec x)]
        right [y (inc x)]]
    (as-> (set '()) neighbors
      (if (valid-coord? graph up)
        (let [that (get-cell graph up)]
          (if (and (climbable-pred this that) (not-visited? that))
            (conj neighbors that)
            neighbors))
        neighbors)
      (if (valid-coord? graph down)
        (let [that (get-cell graph down)]
          (if (and (climbable-pred this that) (not-visited? that))
            (conj neighbors that)
            neighbors))
        neighbors)
      (if (valid-coord? graph left)
        (let [that (get-cell graph left)]
          (if (and (climbable-pred this that) (not-visited? that))
            (conj neighbors that)
            neighbors))
        neighbors)
      (if (valid-coord? graph right)
        (let [that (get-cell graph right)]
          (if (and (climbable-pred this that) (not-visited? that))
            (conj neighbors that)
            neighbors))
        neighbors))))

(defn unvisit-all
  "Clears all of the `:visited` flags in the graph.
   Not strictly necessary, since we're likely working with a fresh graph."
  [graph]
  (matrix/emap (fn [c] (assoc c :visited false)) graph))

(defn visit
  "Marks the cell as visited."
  [graph cell]
  (matrix/mset graph (:y cell) (:x cell) (assoc cell :visited true)))

(defn make-queue-entry
  "Returns an entry for the queue.
   Contains coordinates for a cell and the path leading to it."
  [state that path-so-far]
  (let [entry {:y (:y that) :x (:x that) :path (cons that path-so-far)}
        graph (visit (:graph state) that)
        q (conj (:queue state) entry)]
    (-> state
        (assoc :graph graph)
        (assoc :queue q))))

;;  procedure BFS (G, root) is
;;      let Q be a queue
;;      label root as explored
;;      Q.enqueue (root)
;;      while Q is not empty do
;;          v := Q.dequeue ()
;;          if v is the goal then
;;              return v
;;          for all edges from v to w in G.adjacentEdges (v) do
;;              if w is not labeled as explored then
;;                  label w as explored
;;                  w.parent := v
;;                  Q.enqueue (w)

(defn bfs
  "Finds the shortest path through the map from S to E using a breadth-first search."
  [graph start end-pred climbable-pred]
  (let [graph (unvisit-all graph)
        graph (visit graph start)
        start {:y (:y start) :x (:x start) :path (list start)}
        initial-state {:graph graph :queue (queue (list start))}]
    (loop [state initial-state
           candidate start]
      (let [this (get-cell (:graph state) [(:y candidate) (:x candidate)])]
        (if (end-pred this)
          (:path candidate)
          (let [new-state (reduce (fn [acc n] (make-queue-entry acc n (:path candidate))) state (neighbors-of (:graph state) this climbable-pred))
                new-queue (pop (:queue new-state))]
            (recur (assoc new-state :queue new-queue) (peek new-queue))))))))

(defn part1 [filename]
  (let [graph (as-grid (read-file filename))
        start (mfind graph is-start?)]
    (dec (count (bfs graph start is-end? not-too-high?)))))

(defn part2 [filename]
  (let [graph (as-grid (read-file filename))
        start (mfind graph is-end?)]
    (dec (count (bfs graph start is-lowest-elevation? not-too-low?)))))

(defn -main []
  (printf "day 12 part 1: %d%n" (part1 "../data/12.txt"))
  (printf "day 12 part 2: %d%n" (part2 "../data/12.txt")))
