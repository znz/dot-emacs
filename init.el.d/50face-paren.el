(static-when (locate-library "font-lock")
  ;;; http://0xcc.net/misc/permstr.html#pale-parens
  ;;; http://www.namazu.org/~satoru/unimag/10/
  ;; 小括弧 () の色を定義
  (defvar paren-face 'paren-face)
  (make-face 'paren-face)
  (set-face-foreground 'paren-face "#88aaff")

  ;; 中括弧 {} の色を定義
  (defvar brace-face 'brace-face)
  (make-face 'brace-face)
  (set-face-foreground 'brace-face "#ffaa88")

  ;; 大括弧 [] の色を定義
  (defvar bracket-face 'bracket-face)
  (make-face 'bracket-face)
  (set-face-foreground 'bracket-face "#aaaa00")

  ;; lisp-mode の色設定に追加
  (setq lisp-font-lock-keywords-2
        (append '(("[()]" . paren-face))
                lisp-font-lock-keywords-2))

  ;; c-mode の色設定に追加
  (setq c-font-lock-keywords-3
        (append '(("[()]" . paren-face))
                '(("[{}]" . brace-face))
                '(("[][]" . bracket-face))
                c-font-lock-keywords-3))

  (eval-after-load "ruby-mode"
    '(setq ruby-font-lock-keywords
           (append '(("[()]" . paren-face))
                   '(("[{}]" . brace-face))
                   '(("[][]" . bracket-face))
                   ruby-font-lock-keywords)))
  )

;; 対応する括弧をハイライト
(static-when (functionp 'show-paren-mode)
  (show-paren-mode 1))
(static-when (fboundp 'paren-set-mode) ; XEmacs
  (paren-set-mode 'paren))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
