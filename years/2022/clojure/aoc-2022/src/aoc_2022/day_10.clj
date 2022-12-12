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
  {:x 1 :cycle 1 :signal-strength 0 :strengths '() :crt '()})

;; utility functions

(defn get-cycle
  "Returns the cycle number from the state."
  [state]
  (get state :cycle))

(defn get-x
  "Returns the value of the X register."
  [state]
  (get state :x))

;; signal strength

(defn update-signal-strength
  "Calculates the signal strength and updates it in state."
  [state]
  (let [cycle (get-cycle state) x (get-x state)]
    (update state :signal-strength (fn [_] (* cycle x)))))

;; display rendering

(defn get-pixel
  "Returns the character which should be added to the display."
  [state]
  (let [crt-idx (dec (get state :cycle))
        pixel-column (mod crt-idx 40)
        sprite-column (get-x state)]
    (cond
      (and (>= pixel-column (dec sprite-column)) (<= pixel-column (inc sprite-column))) "*"
      :else " ")))

(defn write-pixel
  "Writes a pixel to the display."
  [state]
  (update state :crt (fn [old] (cons (get-pixel state) old))))

;; executing the instruction stream

(defn transcode
  "Converts any multi-cycle instruction into a sequence of single-cycle instructions."
  [instruction]
  (cond
    (= "noop" instruction) '("noop")
    (re-find #"^addx\b" instruction) (cons "noop" (list instruction))))

(defn execute-addx
  "Execute an 'addx' instruction."
  [state value]
  (update state :x (fn [old] (+ old value))))

(defn execute-noop
  "Execute a 'noop' instruction."
  [state]
  state)

(defn dispatch
  "Executes a single instruction, updating the state as appropriate."
  [state instruction]
  (cond
    (= "noop" instruction) (execute-noop state)
    (re-find #"^addx\b" instruction) (execute-addx state (Integer/parseInt (second (re-matches #"^addx\s+(.+)" instruction))))))

(defn execute-one-instruction
  "Executes a single instruction."
  [state instruction]
  (-> state
      (update-signal-strength)
      (write-pixel)
      (dispatch instruction)))

(defn execute-block
  "Executes a block of instructions."
  [state block]
  (let [state-at-end-of-block (reduce (fn [state instruction]
                                        (-> state
                                            (execute-one-instruction instruction)
                                            (update :cycle inc))) state block)
        strength (get state-at-end-of-block :signal-strength)]
    (update state-at-end-of-block :strengths (fn [old] (cons strength old)))))

;; FIXME The only difference between execute-part-1 and execute-part-2
;; is the length of the first block. Either the blocks should be composed
;; in the part-* functions and passed in, or the signal strength should be
;; sampled during cycle 20 of each block (instead of at the end).

(defn execute-part-1
  "Executes a stream of instructions."
  [instructions]
  (let [start-state (initialize-state)
        transcoded-instructions (flatten (map transcode instructions))
        [first-block rest-instructions] (split-at 20 transcoded-instructions)
        rest-blocks (partition 40 rest-instructions)
        blocks (cons first-block rest-blocks)]
    (reduce (fn [state block] (execute-block state block)) start-state blocks)))

(defn execute-part-2
  "Executes a stream of instructions."
  [instructions]
  (let [start-state (initialize-state)
        transcoded-instructions (flatten (map transcode instructions))
        blocks (partition 40 transcoded-instructions)]
    (reduce (fn [state block] (execute-block state block)) start-state blocks)))

(defn part1 [filename]
  (let [final-state (execute-part-1 (read-file filename))]
    (apply + (get final-state :strengths))))

(defn part2 [filename]
  (let [state (execute-part-2 (read-file filename))
        crt (reverse (get state :crt))
        lines (partition 40 crt)]
    (doseq [line lines] (println line))))

(defn -main []
  (printf "day 10 part 1: %d%n" (part1 "../../data/10.txt"))
  (printf "day 10 part 2: %d%n" (part2 "../../data/10.txt")))
