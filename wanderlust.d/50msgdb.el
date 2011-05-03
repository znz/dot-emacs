(setq elmo-msgdb-default-type 'standard)

;; msgdb をロードした時に `elmo-msgdb-default-type' と
;; 異なった形式だった場合に自動的に変換する場合
(setq elmo-msgdb-convert-type 'auto)

;; サマリで s all した時に変換する場合
;(setq elmo-msgdb-convert-type 'sync)

;; `elmo-msgdb-overview-entity-get-extra-field' で参照したいフィールド。
;; 自動リファイルで参照したいフィールドも設定する。
(setq elmo-msgdb-extra-fields
      '("newsgroups"
        "content-type"
        "reply-to"
        "user-agent"
        "x-mailer"
        ;; ML
        "list-id"
        "list-post"
        "mailing-list"
        "x-mail-count"
        "x-ml-count"
        "x-ml-name"
        "x-sequence"
        ;; redmine
        "x-redmine-project"
        ))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
