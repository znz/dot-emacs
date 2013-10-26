(static-when (locate-library "elscreen")
  (setq elscreen-display-tab nil)

  ;; emacs22 以降にある。
  (defun-maybe booleanp (object)
    "Return non-nil if OBJECT is one of the two canonical boolean values: t or nil."
    (memq object '(nil t)))

  (require 'elscreen)
  (static-when (locate-library "elscreen-color-theme")
    (eval-after-load "color-theme"
      '(load "elscreen-color-theme")))
  (static-when (locate-library "elscreen-dired")
    (load "elscreen-dired"))
  ;;(static-when (locate-library "elscreen-dnd")
  ;;  (when window-system
  ;;    (load "elscreen-dnd")))
  (static-when (locate-library "elscreen-gf")
    (load "elscreen-gf"))
  (static-when (locate-library "elscreen-goby")
    (eval-after-load "goby"
      '(load "elscreen-goby")))
  (static-when (locate-library "elscreen-howm")
    (eval-after-load "howm"
      '(load "elscreen-howm")))
  (static-when (locate-library "elscreen-server")
    (load "elscreen-server"))
  (static-when (locate-library "elscreen-speedbar")
    (eval-after-load "speedbar"
      '(load "elscreen-speedbar")))
  (static-when (locate-library "elscreen-w3m")
    (eval-after-load "w3m"
      '(load "elscreen-w3m")))
  (static-when (locate-library "elscreen-wl")
    (eval-after-load "wl"
      '(load "elscreen-wl")))
  (static-when (locate-library "elscreen-mew")
    (eval-after-load "mew"
      '(load "elscreen-mew")))

  ;; C-z C-z で直前のスクリーンに移動する。
  (define-key elscreen-map "\C-z" 'elscreen-toggle)

  ;; elscreen: From Emacs 24.3: Symbol's value as variable is void: last-command-char
  ;; http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=705436
  ;; のパッチから GNU Emacs 用の対処方法を取り出して advice に変更。
  (defadvice elscreen-jump (around elscreen-last-command-char-event activate)
    (let ((last-command-char last-command-event))
      ad-do-it))

  (add-to-list
   'elscreen-mode-to-nickname-alist
   '("^riece-" . "Riece"))
  (elscreen-rebuild-mode-to-nickname-alist)

  (elscreen-start)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
