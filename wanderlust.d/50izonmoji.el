(when (require 'izonmoji-mode nil t)
  (add-hook 'wl-message-redisplay-hook 'izonmoji-mode-on))
