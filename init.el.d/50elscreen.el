(static-when (locate-library "elscreen")
  (setq elscreen-display-tab nil)

  ;; emacs22 以降にある。
  (defun-maybe booleanp (object)
    "Return non-nil if OBJECT is one of the two canonical boolean values: t or nil."
    (memq object '(nil t)))

  (load "elscreen")
  (eval-after-load "color-theme"
    '(load "elscreen-color-theme"))
  (load "elscreen-dired")
  ;;(when window-system
  ;;  (load "elscreen-dnd"))
  (load "elscreen-gf")
  (eval-after-load "goby"
    '(load "elscreen-goby"))
  (eval-after-load "howm"
    '(load "elscreen-howm"))
  (load "elscreen-server")
  (eval-after-load "speedbnar"
    '(load "elscreen-speedbar"))
  (eval-after-load "w3m"
    '(load "elscreen-w3m"))
  (eval-after-load "wl"
    '(load "elscreen-wl"))

  (static-when (locate-library "elscreen-mew")
    (eval-after-load "mew"
      '(load "elscreen-mew")))

  ;; C-z C-z で直前のスクリーンに移動する。
  (define-key elscreen-map "\C-z" 'elscreen-toggle)

  (add-to-list
   'elscreen-mode-to-nickname-alist
   '("^riece-" . "Riece"))
  (elscreen-rebuild-mode-to-nickname-alist)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
