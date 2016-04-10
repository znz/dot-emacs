;; file-name-historyなどの数
(setq history-length 1000)

;; http://homepage3.nifty.com/akima/soft/meadow_20.html#SEC293
;; 20.2.5 ヒストリから重複を削除 (2003/01/21)
;; history から重複したのを消す
(eval-when-compile (require 'cl))
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
;;(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)
