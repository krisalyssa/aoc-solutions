(ns day-16
  (:gen-class))

(require '[clojure.pprint :as pp]
         '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn parse-one-line
  [line]
  (let [[_ valve flow-rate _ to-valves] (re-matches #"^Valve ([A-Z]{2}) has flow rate=(\d+); (tunnel leads to valve|tunnels lead to valves) (.+)$" line)]
    {:key valve :flow-rate (Integer/parseInt flow-rate) :to-valves (str/split to-valves #", ")}))

(defn parse-lines
  [lines]
  (->> lines
       (map parse-one-line)
       (reduce (fn [acc, record] (assoc acc (:valve record) record)) {})))

;; queue functions

(defn queue
  "Creates a queue (FIFO). Borrowed from https://admay.github.io/queues-in-clojure/"
  ([] (clojure.lang.PersistentQueue/EMPTY))
  ([coll]
   (reduce conj clojure.lang.PersistentQueue/EMPTY coll)))

(defn qpeek
  "Returns the element at the head of the queue without removing it."
  [q]
  (peek q))

(defn qpop
  "Removes the element at the head of the queue and returns the new queue."
  [q]
  (pop q))

(defn qpush
  "Pushes an item to the tail of the queue and returns the new queue."
  [q item]
  (conj q item))

;; graph functions

(defn graph
  "Creates a directed acyclic graph (DAG)."
  []
  {})

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
  "Performs a breadth-first search through a graph."
  [g start]
  (let [q (queue)
        q (qpush start)]))


;; note that "visited" in this context means a valve that has been turned on
;; stuck valves (i.e. with flow-rate 0) should not be considered for "next node"

;; visit AA
;;   flow-rate 0, nothing to do

;; (defn part1
;;   [filename]
;;   (->> filename))

;; (defn part2
;;   [filename]
;;   (->> filename))

;; (defn -main []
;;   (printf "day 16 part 1: %d%n" (part1 "../../data/16.txt"))
;;   (printf "day 16 part 2: %d%n" (part2 "../../data/16.txt")))
