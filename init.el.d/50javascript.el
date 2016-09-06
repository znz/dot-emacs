(add-to-list 'my/favorite-packages 'js2-mode)
(static-when (locate-library "js2-mode")
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
  (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
  (add-hook 'js2-jsx-mode-hook 'flycheck-mode)
  (defun my-js2-mode-hook ()
    (setq js2-basic-offset 2)
    (setq js-indent-level 2)
    (setq indent-tabs-mode nil))
  (add-hook 'js2-mode-hook 'my-js2-mode-hook))
