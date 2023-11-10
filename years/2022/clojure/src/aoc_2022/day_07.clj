(ns aoc-2022.day-07
  (:gen-class))

(require ;; '[clojure.pprint :as pp]
 '[clojure.string :as str]
 '[clojure.walk :as walk])

;; initialization functions

(defn read-file
  "Reads the file and returns it as a sequence of strings."
  [filename]
  (str/split-lines
   (slurp filename)))

;; functions for extracting parenthesized groups in a regex match

(defn first-group
  "Returns the value of the first parenthesized group in a regex match."
  [match]
  (-> match
      first
      (nth 1)))

(defn second-group
  "Returns the value of the second parenthesized group in a regex match."
  [match]
  (-> match
      first
      (nth 2)))

;; utility functions

(defn cons-end
  "cons an item onto the _end_ of a list."
  [cwd item]
  (reverse (cons item (reverse cwd))))

(defn add-entry
  "Adds an entry to the tree."
  [tree cwd k v]
  (update-in tree (cons-end cwd k) (fn [_] v)))

;; tree navigation functions

(defn go-up
  "Backs up one level in the directory path."
  [cwd]
  (case (count cwd)
    0 '()
    1 '()
    (butlast cwd)))

(defn go-down
  "Descends one level in the directory path."
  [cwd new-directory]
  (cons-end cwd new-directory))

;; load the device listing to a tree

(defn process-line
  "Handles a single line of the device listing."
  [cwd tree line]
  (condp (comp seq re-seq) line
    ;; trash line, do nothing
    #"\$\s+ls\b" :>> (fn [_] (vector cwd tree))

    ;; return to root
    #"\$\s+cd\s+/" :>> (fn [_] (vector '() tree))

    ;; go up a level
    #"\$\s+cd\s+\.\." :>> (fn [_] (vector (go-up cwd) tree))

    ;; go down into the subdirectory
    #"\$\s+cd\s+(\S+)" :>> #(vector (go-down cwd (first-group %)) tree)

    ;; entry for a directory
    #"\bdir\s+(\S+)" :>> #(vector cwd (add-entry tree cwd (first-group %) '{}))

    ;; entry for a file
    #"\b(\d+)\s+(\S+)" :>> #(vector cwd (add-entry tree cwd (second-group %) (Integer/parseInt (first-group %))))))

(defn read-listing
  "Reads a device listing into a tree."
  [lines]
  (reduce (fn [[cwd tree] line] (process-line cwd tree line)) '[() {}] lines))

(defn du-part1
  "Calculates sizes of directories, like `du -b`."
  [tree]
  (let [directories (atom '())]
    (walk/postwalk (fn [node]
                     (if (map? node)
                       (let [dir-size (apply + (vals node))]
                         (if (<= dir-size 100000)
                           (swap! directories (fn [current-value] (cons dir-size current-value)))
                           nil)
                         dir-size)
                       node)) tree)
    (apply + (deref directories))))

(defn du
  "Calculates sizes of directories, like `du -b`."
  [tree]
  (let [directories (atom '())]
    (walk/postwalk (fn [node]
                     (if (map? node)
                       (let [dir-size (apply + (vals node))]
                         ;; this should be evaluated only if the passed-in predicate is true
                         (swap! directories (fn [current-value] (cons dir-size current-value)))
                         ;; note that no such predicate is currently being passed in
                         ;; see du-part1 above for what that predicate should look like
                         dir-size)
                       node)) tree)
    (deref directories)))

(defn space-to-free
  "Calculates how much space needs to be freed up."
  [total-used]
  (let [free-space (- 70000000 total-used)]
    (if (< free-space 30000000)
      (- 30000000 free-space)
      0)))

(defn part1 [filename]
  (du-part1 (second (read-listing (read-file filename)))))

(defn part2 [filename]
  (let [sizes (du (second (read-listing (read-file filename))))
        total-used (first sizes)
        needed (space-to-free total-used)]
    (apply min (filter (fn [size] (>= size needed)) sizes))))

(defn -main []
  (printf "day 07 part 1: %d%n" (part1 "../data/07.txt"))
  (printf "day 07 part 2: %d%n" (part2 "../data/07.txt")))
