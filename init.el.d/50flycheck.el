(add-to-list 'my/favorite-packages 'flycheck)
(static-when (fboundp 'global-flycheck-mode)
  (with-eval-after-load 'flycheck
    (flycheck-define-checker textlint
      "A linter for prose."
      :command ("textlint" "--format" "unix"
                 ;; "--rule" "no-mix-dearu-desumasu" "--rule" "max-ten" "--rule" "spellcheck-tech-word"
                 source-inplace)
      :error-patterns
      ((warning line-start (file-name) ":" line ":" column ": "
         (id (one-or-more (not (any " "))))
         (message (one-or-more not-newline)
           (zero-or-more "\n" (any " ") (one-or-more not-newline)))
         line-end))
      :modes (text-mode markdown-mode gfm-mode))
    (add-to-list 'flycheck-checkers 'textlint)
    (custom-set-variables '(flycheck-keymap-prefix (kbd "C-c f"))))
  (setq flycheck-command-wrapper-function
    (lambda (command)
      (cond
        ((memq major-mode '(ruby-mode))
          (if
            (or
              (locate-dominating-file default-directory "Gemfile.lock")
              (locate-dominating-file default-directory "gems.locked"))
            (append '("bundle" "exec") command)
            command))
        ((memq major-mode '(js-mode js2-mode))
          (append '("npx") command))
        (t command))))
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; eslint must be in exec-path
;; see https://github.com/flycheck/flycheck/issues/1428

(add-to-list 'my/favorite-packages 'add-node-modules-path)
(with-eval-after-load 'js
  (add-hook 'js-mode-hook #'add-node-modules-path))
(with-eval-after-load 'js2-mode
  (add-hook 'js2-mode-hook #'add-node-modules-path))
(with-eval-after-load 'markdown-mode
  (add-hook 'gfm-mode-hook #'add-node-modules-path)
  (add-hook 'markdown-mode-hook #'add-node-modules-path))
