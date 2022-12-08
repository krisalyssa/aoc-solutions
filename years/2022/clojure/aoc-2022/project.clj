(defproject aoc-2022 "0.1.0-SNAPSHOT"
  :description "Advent of Code 2022 in Clojure"
  :url "https://github.com/CraigCottingham/aoc/"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.11.1"] [net.mikera/core.matrix "0.63.0"]]
  :main ^:skip-aot aoc-2022.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})
