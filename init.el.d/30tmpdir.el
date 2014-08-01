;; $HOME/tmp/$USER が無ければ作成。
;; (getenv "HOME")がnilの場合も考慮して ~/tmpdir/ ではなく /tmp/ 以下にしている。

(let ((xdg-cache-home (getenv "XDG_CACHE_HOME"))
      (home (getenv "HOME")))
  (cond
   (xdg-cache-home
    (setq temporary-file-directory
          (expand-file-name  "emacs" xdg-cache-home)))
   (home
    (setq temporary-file-directory
          (expand-file-name ".cache/emacs" home)))
   ))
(make-directory temporary-file-directory t)
