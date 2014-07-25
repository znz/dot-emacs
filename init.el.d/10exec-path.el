(defun my-add-to-path (path)
  (when (file-directory-p path)
    (setenv "PATH" (concat path ":" (getenv "PATH")))
    (add-to-list 'exec-path path)))
(mapc #'my-add-to-path
 (file-expand-wildcards "/opt/local/*bin") ; MacPorts
 )
(my-add-to-path "/usr/local/bin") ; Homebrew
(my-add-to-path (expand-file-name "~/homebrew/bin")) ; Homebrew
;; rbenv
(my-add-to-path (expand-file-name "~/.rbenv/bin"))
(my-add-to-path (expand-file-name "~/.rbenv/shims"))
(my-add-to-path (expand-file-name "/opt/rbenv/bin"))
(my-add-to-path (expand-file-name "/opt/rbenv/shims"))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
