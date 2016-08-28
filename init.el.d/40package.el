(defvar my/favorite-packages nil)
(when (require 'package nil t)
  ;; http://emacs-jp.github.io/packages/package-management/package-el.html

  ;; MELPA
  (add-to-list
   'package-archives
   '("melpa-stable" . "https://stable.melpa.org/packages/") t)

  ;; Marmalade
  (add-to-list
   'package-archives
   '("marmalade" . "https://marmalade-repo.org/packages/"))

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
