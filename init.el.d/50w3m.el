(static-when (locate-library "w3m-load")
  (require 'w3m-load)
  (setq w3m-init-file "~/.emacs.d/dot-emacs-w3m")
  (eval-after-load "w3m" '(my-byte-compile-file w3m-init-file))

  (setq w3m-type "w3m")

  ;;(unless (featurep 'meadow)
  ;;  (setq browse-url-browser-function 'w3m-browse-url))
  )
