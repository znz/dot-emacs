(static-when
    (and
     (fboundp 'flymake-mode))

  ;; (auto-install-from-emacswiki "flymake-cursor.el")
  (eval-after-load "flymake"
    '(require 'flymake-cursor nil t))

  (static-when t ;; from http://www.emacswiki.org/emacs/FlymakeRuby
    ;; Invoke ruby with '-c' to get syntax checking
    (defun flymake-ruby-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
             (local-file  (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
        (list (my-ruby-command) (list "-c" local-file))))

    ;; set in 50ruby.el
    ;;(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
    ;;(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

    (eval-after-load "flymake"
      '(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
      )

    (add-hook
     'ruby-mode-hook
     (lambda ()
       ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
       (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
           (flymake-mode))
       ))
    )
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
