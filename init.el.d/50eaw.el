;; https://github.com/hamano/locale-eaw
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(when (require 'eaw nil t)
  (eaw-fullwidth))
