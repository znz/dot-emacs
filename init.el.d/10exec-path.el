(defun my-add-to-path (path)
  (when (file-directory-p path)
    (setenv "PATH" (concat path ":" (getenv "PATH")))
    (add-to-list 'exec-path path)))
(mapc #'my-add-to-path
 (file-expand-wildcards "/opt/local/*bin") ; MacPorts
 )
(my-add-to-path "/usr/local/bin") ; Homebrew

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
