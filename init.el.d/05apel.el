;; .emacs 高速化のために static を使って環境をチェックしているので、
;; 環境の変化があったときにもバイトコンパイルし直す必要がある。
(eval-when-compile
  (unless (require 'static nil t)
    (error "need to install apel")))
(eval-and-compile
  (autoload 'exec-installed-p "path-util"))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
