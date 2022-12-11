(ns aoc-2022.day-10
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
  "Sets up the state at the start of a program."
  []
  {:x 1 :cycle 1 :signal-strength 0 :strengths '()})

(defn transcode
  "Converts any multi-cycle instruction into a sequence of single-cycle instructions."
  [instruction]
  (cond
    (= "noop" instruction) '("noop")
    (re-find #"^addx\b" instruction) (cons "noop" (list instruction))))

(defn get-cycle
  "Returns the cycle number from the state."
  [state]
  (get state :cycle))

(defn get-x
  "Returns the value of the X register."
  [state]
  (get state :x))

(defn update-signal-strength
  "Calculates the signal strength and updates it in state."
  [state]
  (let [cycle (get-cycle state) x (get-x state)]
    (update state :signal-strength (fn [_] (* cycle x)))))

(defn execute-one-instruction
  "Executes a single instruction, updating the state as appropriate."
  [state instruction]
  (let [temp-state (update-signal-strength state)]
    ;; (printf "%3d  %4d  %s%n" (get-cycle state) (get-x state) instruction)
    (cond
      (= "noop" instruction) temp-state
      (re-find #"^addx\b" instruction) (update temp-state :x (fn [old] (+ old (Integer/parseInt (second (re-matches #"^addx\s+(.+)" instruction)))))))))

(defn execute-block
  "Executes a block of instructions."
  [state block]
  (let [state-at-end-of-block (reduce (fn [state instruction]
                                        (-> state
                                            (execute-one-instruction instruction)
                                            (update :cycle inc))) state block)
        strength (get state-at-end-of-block :signal-strength)]
    (update state-at-end-of-block :strengths (fn [old] (cons strength old)))))

(defn execute
  "Executes a stream of instructions."
  [instructions]
  (let [start-state (initialize-state)
        transcoded-instructions (flatten (map transcode instructions))
        [first-block rest-instructions] (split-at 20 transcoded-instructions)
        rest-blocks (partition 40 rest-instructions)
        blocks (cons first-block rest-blocks)]
    (reduce (fn [state block] (execute-block state block)) start-state blocks)))

(defn part1 [filename]
  (let [final-state (execute (read-file filename))]
    (apply + (get final-state :strengths))))

;; (defn part2 [filename]
;;   (let [instructions (read-file filename)
;;         state (initialize-state 10)]
;;     (-> (reduce (fn [acc line] (execute-one-line acc line)) state instructions)
;;         (get :visited)
;;         count)))

(defn -main []
  (printf "day 10 part 1: %d%n" (part1 "../../data/10.txt")))
  ;; (printf "day 10 part 2: %d%n" (part2 "../../data/10.txt")))
