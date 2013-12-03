;; 行末の不要なスペースを強調表示する
(setq-default show-trailing-whitespace t)

;; calendar-mode では表示しない
(add-hook 'calendar-mode-hook
          (lambda () (setq show-trailing-whitespace nil)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
