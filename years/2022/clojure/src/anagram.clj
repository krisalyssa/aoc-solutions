(ns anagram
  (:gen-class))

(require '[clojure.math.combinatorics :as combo]
         '[clojure.string :as str])

(defn anagram
  "Show all permutations of the letters."
  [letters size]
  (let [prefix ""
        after nil
        before "MEMOIR"
        words (for [perm (sort (map str/join (combo/permuted-combinations (str/split letters #"") size)))]
                (let [candidate (str/join (vector prefix perm))]
                  (cond
                    (and (not (nil? after)) (>= 0 (compare candidate after))) nil
                    (and (not (nil? before)) (<= 0 (compare candidate before))) nil
                    :else candidate)))]
    (doseq [word (remove nil? words)] (println word))))

;; (anagram "EGITTNG" 5)
