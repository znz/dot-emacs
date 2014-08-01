(add-to-list 'my/favorite-packages 'flycheck)
(static-when (fboundp 'global-flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode))
