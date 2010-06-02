;; 「Symbol's value as variable is void: warning-suppress-types」対策
(static-when (string= emacs-version "23.2.1")
  (unless (boundp 'warning-suppress-types)
    (setq warning-suppress-types nil)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
