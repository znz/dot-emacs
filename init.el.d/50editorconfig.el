(static-when (executable-find "editorconfig")
  (add-to-list 'my/favorite-packages 'editorconfig)
  (when (require 'editorconfig nil t)
    (when (consp (assq 'editorconfig-mode minor-mode-alist))
      (setcar (cdr (assq 'editorconfig-mode minor-mode-alist))
        (propertize "EC" 'face '(:foreground "yellow"))))
    (editorconfig-mode 1))
  )
