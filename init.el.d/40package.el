(defvar my/favorite-packages nil)
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

  (defvar my/favorite-packages nil
    "my-install-packagesでインストールするパッケージ")

  (defun my-install-packages ()
    "my/favorite-packagesをインストールする。"
    (interactive)
    (package-refresh-contents)
    (dolist (package my/favorite-packages)
      (unless (package-installed-p package)
        (package-install package)))
    )
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
