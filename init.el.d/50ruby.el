;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/inf-ruby.el")
;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/rdoc-mode.el")
;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/ruby-electric.el")
;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/ruby-mode.el")
;; (install-elisp "http://svn.ruby-lang.org/repos/ruby/trunk/misc/ruby-style.el")
(static-when (locate-library "ruby-mode")
  (autoload 'ruby-mode "ruby-mode"
    "Major mode for editing Ruby source files." t)
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
  (autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
  (autoload 'inf-ruby-keys "inf-ruby"
    "Set local key defs for inf-ruby in ruby-mode")
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (inf-ruby-keys))))

;; ruby-mode でも which-function-mode を有効にする。
(static-when (boundp 'which-func-modes)
  (add-to-list 'which-func-modes 'ruby-mode))

;; インデント
(setq ruby-deep-indent-paren-style nil)

;; (install-elisp-from-emacswiki "ruby-block.el")
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

(defun my-ruby-mode-hook-function ()
  (set (make-local-variable 'compile-command)
       (concat "ruby -cv " buffer-file-name)))
(add-hook 'ruby-mode-hook #'my-ruby-mode-hook-function)

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
