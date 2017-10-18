(add-to-list 'my/favorite-packages 'flycheck)
(static-when (fboundp 'global-flycheck-mode)
  (with-eval-after-load 'flycheck
    (custom-set-variables '(flycheck-keymap-prefix (kbd "C-c f"))))
  (add-hook 'after-init-hook #'global-flycheck-mode))
