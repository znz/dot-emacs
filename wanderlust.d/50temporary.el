(let ((dir (getenv "XDG_RUNTIME_DIR")))
  (when (and dir (file-directory-p dir))
    (setq wl-temporary-file-directory dir)))
