(add-to-list 'my/favorite-packages 'evil-numbers)
(when (require 'evil-numbers nil t)
  (global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)
  )
