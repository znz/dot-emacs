;; カーソル行頭時に C-kで行全体を削除
(setq kill-whole-line t)

;; kill ring に関する設定
(setq kill-ring-max 1000) ; default=60

;; 終了前に確認
(setq confirm-kill-emacs 'yes-or-no-p)
