(ns aoc-2022.day-11
  (:gen-class))

(require ;; '[clojure.pprint :as pp]
 '[clojure.string :as str])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

(defn partition-lines
  "Partitions the list of lines into monkey0-sized pieces."
  [lines]
  (partition 7 7 [""] lines))

(defn initialize-monkey
  "Sets up a brand-new monkey."
  []
  {:inspections 0})

(defn parse-monkey-divisor
  "Gets the factor by which the worry level of an item is diminished after the monkey inspects it."
  [line]
  (let [[_ id] (re-matches #"^\s*Test: divisible by (\d+)$" line)]
    (Integer/parseInt id)))

(defn parse-monkey-id
  "Gets the ID for the monkey."
  [line]
  (let [[_ id] (re-matches #"^Monkey (\d+):$" line)]
    (Integer/parseInt id)))

(defn parse-monkey-items
  "Gets the items the monkey is initially holding."
  [line]
  (let [[_ items] (re-matches #"^\s*Starting items: (.+)$" line)]
    (as-> items value
      (str/split value #", ")
      (vec (map #(Integer/parseInt %) value)))))

(defn parse-monkey-rule
  "Gets the rule applied to the worry level of an item as the monkey inspects it."
  [line]
  (let [[_ operation] (re-matches #"^\s*Operation: new = (.+)$" line)
        [a operator b] (str/split operation #" ")
        a (if (= a "old") :old (Integer/parseInt a))
        b (if (= b "old") :old (Integer/parseInt b))
        operator (condp = operator
                   "*" *
                   "+" +
                   "unrecognized operator")]
    [operator a b]))

(defn parse-monkey-target
  "Gets the target of the monkey's throw."
  [line]
  (let [[_ _ id] (re-matches #"^\s*If (true|false): throw to monkey (\d+)$" line)]
    (Integer/parseInt id)))

(defn parse-one-monkey
  "Turns monkey-sized collections of lines into a monkey-shaped structure."
  [lines]
  (let [id (parse-monkey-id (nth lines 0))
        items (parse-monkey-items (nth lines 1))
        rule (parse-monkey-rule (nth lines 2))
        divisor (parse-monkey-divisor (nth lines 3))
        on-true (parse-monkey-target (nth lines 4))
        on-false (parse-monkey-target (nth lines 5))]
    (-> (initialize-monkey)
        (assoc :id id)
        (assoc :items items)
        (assoc :rule rule)
        (assoc :divisor divisor)
        (assoc :on-true on-true)
        (assoc :on-false on-false))))

(defn parse-monkeys
  "Parses monkey-sized collections of lines into a collection of monkey-shaped structures."
  [blocks]
  (reduce (fn [acc block] (let [monkey (parse-one-monkey block)] (assoc acc (:id monkey) monkey))) '{} blocks))

(defn inspect-and-throw
  "Inspects an item and throws it."
  [worry-reducer monkeys this-id]
  (let [this-monkey (monkeys this-id)
        items (:items this-monkey)
        this-monkey (assoc this-monkey :items (rest items))
        this-monkey (update this-monkey :inspections inc)
        item (first items)
        rule (map (fn [token] (if (= token :old) item token)) (:rule this-monkey))
        item (apply (first rule) (rest rule))
        item (worry-reducer item)
        divisor (:divisor this-monkey)
        other-id (if (= 0 (rem item divisor)) (:on-true this-monkey) (:on-false this-monkey))
        other-monkey (monkeys other-id)
        other-monkey (update other-monkey :items (fn [old] (reverse (cons item (reverse old)))))]
    (-> monkeys
        (assoc this-id this-monkey)
        (assoc other-id other-monkey))))

(defn run-one-turn
  "Runs one turn for one monkey."
  [worry-reducer monkeys id]
  (let [monkey (monkeys id)]
    (if (empty? (:items monkey))
      monkeys
      (recur worry-reducer (inspect-and-throw worry-reducer monkeys id) id))))

(defn run-one-round
  "Runs one round (one turn for each monkey)."
  [worry-reducer monkeys]
  (reduce (partial run-one-turn worry-reducer) monkeys (sort (keys monkeys))))

(defn run-n-rounds
  "Runs multiple rounds."
  [worry-reducer monkeys n]
  (reduce (fn [monkeys _] (run-one-round worry-reducer monkeys)) monkeys (range n)))

(defn part1 [filename]
  (as-> filename value
    (read-file value)
    (partition-lines value)
    (parse-monkeys value)
    (run-n-rounds (fn [v] (quot v 3)) value 20)
    (map :inspections (vals value))
    (sort value)
    (take-last 2 value)
    (apply * value)))

;; (defn part2 [filename]
;;   (let [state (execute-part-2 (read-file filename))
;;         crt (reverse (get state :crt))
;;         lines (partition 40 crt)]
;;     (doseq [line lines] (println line))))

(defn -main []
  (printf "day 11 part 1: %d%n" (part1 "../../data/11.txt")))
  ;; (printf "day 11 part 2: %d%n" (part2 "../../data/11.txt")))
