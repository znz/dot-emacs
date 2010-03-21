(static-when t
  ;; C-q を 2 ストロークキーの prefix として使う。
  (global-unset-key "\C-q")
  (setq my-prefix-map (make-keymap))
  (global-set-key "\C-q" my-prefix-map)
  (global-set-key "\C-qq" 'quoted-insert) ; emacs-origin C-q

  ;; C-z の代わりに \C-qa を使う。
  ;;(elscreen-set-prefix-key "\C-qa")
  ;; C-z の他に \C-qa も使えるようにする。
  (eval-after-load "elscreen"
    '(define-key my-prefix-map "a" elscreen-map))

  (define-key my-prefix-map (kbd "C-g") 'keyboard-quit)
  (define-key my-prefix-map "/" 'hippie-expand)
  (define-key my-prefix-map "\M-/" 'dabbrev-expand)

  (define-key my-prefix-map "\C-i"
    (lambda () (interactive) (insert-and-inherit "\t")))
  (define-key my-prefix-map " "
    (lambda () (interactive) (insert-and-inherit " ")))

  (define-key my-prefix-map "c" 'compile)

  (define-key my-prefix-map "f"
    (lambda () (interactive)
      (unless (file-exists-p "~/.aspell.conf")
        (error "~/.aspell.conf should be 'lang en_US'"))
      (flyspell-mode 1)
      (flyspell-buffer)))
  (define-key my-prefix-map "F"
    (lambda () (interactive)
      (flyspell-mode -1)))

  (define-key my-prefix-map "v" 'toggle-read-only)

  (defun delete-line (&optional arg)
    (interactive "P")
    (let (kill-ring kill-ring-yank-pointer)
      (kill-line arg)))
  (define-key my-prefix-map "\C-k" 'delete-line)

  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
