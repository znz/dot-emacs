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
(when (and (not (featurep 'xemacs))
           (>= emacs-major-version 22)
           (not wl-highlight-x-face-function))
  ;; http://gist.github.com/283328
  ;; git clone git://gist.github.com/283328.git ~/.emacs.d/gravatar-el
  (add-to-list 'load-path "~/.emacs.d/gravatar-el")
  (when (require 'wl-gravatar nil t)
    (setq gravatar-directory "~/.cache/emacs-gravatar/")
    (setq gravatar-unregistered-icon 'identicon)
    (setq wl-gravatar-retrieve-once t)
    (setq wl-highlight-x-face-function 'wl-gravatar-insert)))

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
