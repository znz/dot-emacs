;; http://dev.nozav.org/textile-mode.html
;; (auto-install-from-url "http://dev.nozav.org/scripts/textile-mode.el")
(static-when (locate-library "textile-mode")
  (require 'textile-mode)
  (add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))
  )
