;; (auto-install-from-url "http://svn.ruby-lang.org/repos/ruby/trunk/misc/inf-ruby.el")
;; (auto-install-from-url "http://svn.ruby-lang.org/repos/ruby/trunk/misc/rdoc-mode.el")
;; (auto-install-from-url "http://svn.ruby-lang.org/repos/ruby/trunk/misc/ruby-electric.el")
;; (auto-install-from-url "http://svn.ruby-lang.org/repos/ruby/trunk/misc/ruby-mode.el")
;; (auto-install-from-url "http://svn.ruby-lang.org/repos/ruby/trunk/misc/ruby-style.el")
(static-when (locate-library "ruby-mode")
  (autoload 'ruby-mode "ruby-mode"
    "Major mode for editing Ruby source files." t)
  (eval-when-compile (require 'ruby-mode))

  (defun my-ruby-command ()
    (cond
     ((file-exists-p "~/.rbenv/shims/ruby")
      "~/.rbenv/shims/ruby")
     (nil "ruby")))

  (setq
   my-ruby-file-name-patterns
   '("\\.rb\\'"
     "\\.rake\\'"
     "\\.ru\\'"
     "\\(Cap\\|Gem\\|Guard\\|Rake\\)file\\'"
     ))
  (mapc
   (lambda (pattern)
     (add-to-list 'auto-mode-alist `(,pattern . ruby-mode)))
   my-ruby-file-name-patterns)
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

  (eval-after-load "flymake"
    '(mapc
      (lambda (pattern)
        (add-to-list 'flymake-allowed-file-name-masks `(,pattern flymake-ruby-init)))
      my-ruby-file-name-patterns))

  (static-when (locate-library "inf-ruby")
    (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
    (autoload 'inf-ruby-keys "inf-ruby"
      "Set local key defs for inf-ruby in ruby-mode")
    (add-hook 'ruby-mode-hook
              #'(lambda ()
                  (inf-ruby-keys))))
  )

;; ruby-mode でも which-function-mode を有効にする。
;;(static-when (boundp 'which-func-modes)
;;  (add-to-list 'which-func-modes 'ruby-mode))

;; インデント
(setq ruby-deep-indent-paren-style nil)

;; (auto-install-from-emacswiki "ruby-block.el")
(static-when (locate-library "ruby-block")
  (autoload 'ruby-block-mode "ruby-block")
  ;; ミニバッファに表示
  ;(setq ruby-block-highlight-toggle 'minibuffer)
  ;; オーバレイする
  ;(setq ruby-block-highlight-toggle 'overlay)
  ;; ミニバッファに表示し, かつ, オーバレイする.
  (setq ruby-block-highlight-toggle t)
  (add-hook 'ruby-mode-hook
            (lambda () (ruby-block-mode t))))

(let
  ((rcodetools-path
     (car
       (last
         (file-expand-wildcards "~/.rbenv/versions/*/lib/ruby/gems/*/gems/rcodetools-*")))))
  (when rcodetools-path
    (add-to-list 'load-path rcodetools-path)
    (require 'rcodetools)
    ))

(defun my-ruby-mode-hook-function ()
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (set (make-local-variable 'compile-command)
       (concat "ruby -cv " buffer-file-name)))
(add-hook 'ruby-mode-hook #'my-ruby-mode-hook-function)
