;; (auto-install-from-url "https://github.com/m2ym/popwin-el/raw/master/popwin.el")

(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer))
