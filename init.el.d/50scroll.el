;;; Emacs: カーソルを動かさずにスクロール
(defun my-scroll-down-1 ()
  "カーソルを動かさずにスクロール"
  (interactive)
  (scroll-down 1))
(defun my-scroll-up-1 ()
  "カーソルを動かさずにスクロール"
  (interactive)
  (scroll-up 1))
(put 'my-scroll-down-1 'unscrollable t)
(put 'my-scroll-up-1 'unscrollable t)
(define-key global-map "\M-p" 'my-scroll-down-1)
(define-key global-map "\M-n" 'my-scroll-up-1)

(setq next-screen-context-lines 10) ;; 画面スクロールで重複表示される行数

;; 1行ずつスクロールするようにする。
;; http://pc2.2ch.net/test/read.cgi/software/1056601345/463
(setq scroll-conservatively 35)
(setq scroll-margin 2)
(setq scroll-step 1)

;; ansi-term の最下行で文字を入力した時に一瞬スクロールするのを止める。
(add-hook
 'term-mode-hook
 (lambda ()
   (setq-local scroll-margin 0)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
