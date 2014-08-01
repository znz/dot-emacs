;;; .save.. ってなファイルを作らない
;;(setq auto-save-list-file-name nil)
;;(setq auto-save-list-file-prefix nil)

(setq auto-save-list-file-prefix
      (expand-file-name "auto-save/" temporary-file-directory))
(make-directory auto-save-list-file-prefix t)

;; 何文字毎に自動保存するか
(setq auto-save-interval 180)
