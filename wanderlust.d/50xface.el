;; X-Face を表示する
(when window-system
  (cond ((and (featurep 'xemacs)        ; for XEmacs
              (module-installed-p 'x-face))
         (autoload 'x-face-xmas-wl-display-x-face "x-face")
         (setq wl-highlight-x-face-function 'x-face-xmas-wl-display-x-face))

        ;; for Emacs21
        ((and (not (featurep 'xemacs))
              (>= emacs-major-version 21)
              (module-installed-p 'x-face-e21))
         (autoload 'x-face-decode-message-header "x-face-e21")
         (setq wl-highlight-x-face-function 'x-face-decode-message-header))

        ;; for Emacs 19.34, Emacs 20.x
        ((module-installed-p 'x-face-mule)
         ;; x-face-mule distributed with bitmap-mule 8.0 or later
         (autoload 'x-face-decode-message-header "x-face-mule")
         (setq wl-highlight-x-face-function 'x-face-decode-message-header))
        ))

;; for Emacs 22 or later
(static-when
    (and (not (featurep 'xemacs))
         (>= emacs-major-version 22)
         ;;(not wl-highlight-x-face-function)
         )
  ;; http://gist.github.com/283328
  ;;(shell-command-to-string "git clone git://gist.github.com/283328.git ~/.emacs.d/site-lisp/gravatar-el")
  ;;(byte-compile-file "~/.emacs.d/site-lisp/gravatar-el/gravatar.el")
  ;;(byte-compile-file "~/.emacs.d/site-lisp/gravatar-el/wl-gravatar.el")
  (add-to-list 'load-path "~/.emacs.d/site-lisp/gravatar-el")
  (when (require 'wl-gravatar nil t)
    ;; 古いキャッシュを消す。
    (defvar my-gravatar-old-threshold 7
      "何日以上古くなっていると消すか")
    (defadvice gravatar-retrieve (before delete-old-cache activate)
      (let (delete-by-moving-to-trash
            (path (ad-get-arg 0)))
        (when (and (file-exists-p path)
                   (<= my-gravatar-old-threshold
                       (time-to-number-of-days
                        (time-since
                         (nth 6 (file-attributes path))))))
          (delete-file path))))
    ;; ファイルの取得に失敗して空だったら消す。
    (defadvice gravatar-retrieve (after delete-empty-cache activate)
      (let (delete-by-moving-to-trash
            (path (ad-get-arg 0)))
        (when (and (file-exists-p path)
                   (zerop (nth 7 (file-attributes path))))
          (delete-file path))))
    (static-cond
     ((executable-find "wget")) ; ok
     ((executable-find "curl")
      (setq gravatar-retrieval-program "curl -s -o '%s' '%s'"))
     (t (error "download program not found")))
    (setq gravatar-directory "~/.cache/emacs-gravatar/")
    (setq gravatar-unregistered-icon 'identicon)
    (setq wl-gravatar-retrieve-once t)
    (setq wl-highlight-x-face-function 'wl-gravatar-insert)))
