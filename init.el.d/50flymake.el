(static-when
    (and
     (fboundp 'flymake-mode))

  ;; (auto-install-from-emacswiki "flymake-cursor.el")
  (eval-after-load "flymake"
    '(require 'flymake-cursor nil t))

  (static-when t ;; from http://www.emacswiki.org/emacs/FlymakeRuby
    (defun flymake-create-temp-intemp (file-name prefix)
      "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
      (unless (stringp file-name)
        (error "Invalid file-name"))
      (or prefix
          (setq prefix "flymake"))
      (let* ((name (concat
                    (file-name-nondirectory
                     (file-name-sans-extension file-name))
                    "_" prefix))
             (ext  (concat "." (file-name-extension file-name)))
             (temp-name (make-temp-file name nil ext))
             )
        (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
        temp-name))

    ;; Invoke ruby with '-c' to get syntax checking
    (defun flymake-ruby-init ()
      (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-intemp)))
        (list (my-ruby-command) (list "-c" temp-file) (file-name-directory temp-file))
        ))

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
