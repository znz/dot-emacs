;; .emacs 高速化のために static を使って環境をチェックしているので、
;; 環境の変化があったときにもバイトコンパイルし直す必要がある。

(mapc
 (lambda (path)
   (when (file-directory-p path)
     (add-to-list 'load-path path)))
 '("~/.emacs.d/site-lisp/apel"
   "~/.emacs.d/site-lisp/emu"))

(eval-when-compile
  (unless (require 'static nil t)
    (error "need to install apel")))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
