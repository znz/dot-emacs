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

  (defun my-base64-decode (beg end)
    "選択したリージョンをbase64-decode-stringして別バッファで表示する。"
    (interactive "r")
    (let ((encoded (buffer-substring-no-properties beg end)))
      (with-output-to-temp-buffer "*my-base64-decode*"
        (princ
         (decode-coding-string
          (base64-decode-string encoded)
          'undecided)) )))
  (define-key my-prefix-map "b" 'my-base64-decode)

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

  (defun my-set-variable-tab-width (arg)
    "(set-variable tab-width arg)"
    (interactive "p")
    (set-variable 'tab-width arg)
    (redraw-display))
  (define-key my-prefix-map "t" 'my-set-variable-tab-width)

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
