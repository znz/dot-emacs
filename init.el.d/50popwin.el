;; (auto-install-from-url "https://github.com/m2ym/popwin-el/raw/master/popwin.el")

(static-when (locate-library "popwin")
  (require 'popwin)
  (popwin-mode 1))
