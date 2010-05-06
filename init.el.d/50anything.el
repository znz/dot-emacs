;;(auto-install-batch "anything")

(static-when
    (and (<= 22 emacs-major-version)
         (locate-library "anything-config")
         (locate-library "anything"))
  (autoload 'anything "anything" nil t)
  (defvar my-anything-prefix-map (make-keymap)
    "anything起動用keymap")
  (define-key my-anything-prefix-map ";" 'anything)
  (define-key my-anything-prefix-map "B" 'descbinds-anything)
  (define-key my-anything-prefix-map "b" 'anything-for-buffers)
  (define-key my-anything-prefix-map "f" 'anything-for-files)
  (define-key my-anything-prefix-map "i" 'anything-imenu)
  (define-key my-anything-prefix-map "k" 'anything-show-kill-ring)
  (define-key my-anything-prefix-map "r" 'anything-resume)
  (define-key my-anything-prefix-map "y" 'anything-show-kill-ring)
  (define-key my-anything-prefix-map (kbd "C-g") 'keyboard-quit)
  (define-key my-anything-prefix-map (kbd "C-q") 'anything)
  (define-key my-prefix-map ";" my-anything-prefix-map)
  (define-key my-prefix-map (kbd "C-;") 'anything-execute-anything-command)
  (define-key my-prefix-map (kbd "C-a") 'anything)
  (define-key my-prefix-map (kbd "C-o") 'anything-occur)
  (define-key my-prefix-map (kbd "C-q") my-anything-prefix-map)

  (setq anything-sources
        '(
          anything-c-source-buffers+
          anything-c-source-file-name-history
          anything-c-source-files-in-current-dir+
          anything-c-source-complex-command-history
          ))

  (defun my-anything-config ()
    (require 'anything-config)
    (define-key anything-map (kbd "C-M-n") 'anything-next-source)
    (define-key anything-map (kbd "C-M-p") 'anything-previous-source)
    (define-key anything-map (kbd "C-t") 'anything-execute-persistent-action)
    )
  (eval-after-load "anything" '(my-anything-config))

  (static-when (locate-library "anything-grep")
    (autoload 'anything-grep "anything-grep" nil t)
    (define-key my-anything-prefix-map "g" 'anything-grep))

  (setq anything-c-adaptive-history-file
        (expand-file-name "anything-c-adaptive-history.el"
                          temporary-file-directory))

  (static-when (locate-library "descbinds-anything")
    ;; descbinds-anything を autoload にするため
    ;; descbinds-anything-install の内容をコピー
    (fset 'describe-bindings 'descbinds-anything)
    (autoload 'descbinds-anything "descbinds-anything" nil t))
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
