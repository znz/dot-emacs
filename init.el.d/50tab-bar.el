(setq-default
  mode-line-format
  (append mode-line-format
          '((:eval
             (format "[%d]" (tab-bar--current-tab-index))
             ))
    ))
