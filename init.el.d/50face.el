(defun my-describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (describe-face (get-char-property (point) 'face)))

;;; M-x list-face-display のサンプル文字列
(setq list-faces-sample-text
      "漢字ひらがなカタカナﾊﾝｶｸｶﾅabcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ")
