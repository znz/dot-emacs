(let ((dir "~/s/github.com/zk-phi/sky-color-clock"))
  (when (file-directory-p dir)
    (add-to-list 'load-path dir)))
(when (require 'sky-color-clock nil t)
  (sky-color-clock-initialize 34.8)
  (push '(:eval (sky-color-clock)) (default-value 'mode-line-format))
  (setq sky-color-clock-enable-emoji-icon nil)
  (setq sky-color-clock-format "%d(%a)")
  )
