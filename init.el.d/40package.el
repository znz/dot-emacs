(when (require 'package nil t)
  ;; http://emacs-jp.github.io/packages/package-management/package-el.html

  ;; MELPA
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/"))

  ;; Marmalade
  (add-to-list
   'package-archives
   '("marmalade" . "http://marmalade-repo.org/packages/"))

  (package-initialize)
  )
