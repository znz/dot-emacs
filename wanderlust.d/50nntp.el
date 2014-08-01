(setq elmo-nntp-group-coding-system 'utf-8)

(setq elmo-nntp-default-server "localhost")
(setq elmo-nntp-default-user nil)
(setq elmo-nntp-default-port 119)

;; .folders の記述例:
;; -gmane.comp.lang.ruby.devel@news.gmane.org
;; -gmane.comp.lang.ruby.japanese@news.gmane.org

(setq wl-nntp-posting-config-alist
      (list
       '(",?gmane\\." . "news.gmane.org")
       '(",?ring\\." . "news.ring.gr.jp")
       ))
