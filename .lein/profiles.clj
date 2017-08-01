{:user {:plugins [[cider/cider-nrepl "0.14.0"]
                  [proto-repl "0.3.1"]
                  [venantius/ultra   "0.5.1"]
                  [lein-midje        "3.2.1"]
                  [lein-kibit        "0.1.3"]
                  [jonase/eastwood   "0.2.3"]]

        :deploy-repositories
          [["snapshots" {:url           "s3://kona-repo/maven/snapshots/"
                         :creds :gpg
                         :sign-releases false}]
           ["releases" {:url           "s3://kona-repo/maven/releases/"
                        :creds :gpg
                        :sign-releases false}]]

        :jvm-opts ["-Xmx3g"]

        :repl-options {:prompt (fn [ns] (str "[" ns "](\u001b[36mλ\u001b[0m)> "))}

        :ultra {:color-scheme :solarized_dark
                :stacktraces false}

        :eastwood {:exclude-linters [:local-shadows-var :unlimited-use]}
}}



;;{:user {:plugins [[cider/cider-nrepl "0.11.0"]
;;                  [venantius/ultra "0.4.1"]
;;                  [lein-midje "3.1.3"]
;;                  [lein-kibit "0.1.2"]
;;                  [lein-bikeshed "0.3.0"]
;;                  [jonase/eastwood "0.2.3"]
;;                  [venantius/yagni "0.1.4"]
;;                  [lein-cljfmt "0.5.0"]
;;                  ]
;;
;;        :dependencies [[cljfmt "0.5.0"]
;;                       [jonase/eastwood "0.2.3" :exclusions [org.clojure/clojure]]]
;;
;;        :repl-options {:prompt (fn [ns] (str "[" ns "](\u001b[36mλ\u001b[0m)> "))
;;                       :init (require 'cljfmt.core)}
;;
;;        :ultra {:color-scheme :solarized_dark
;;                :stacktraces false}
;;
;;        :eastwood {:exclude-linters [:local-shadows-var]}
;;}}
