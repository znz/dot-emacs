;; 行末の不要なスペースを強調表示する
(setq-default show-trailing-whitespace t)

;; calendar-mode では表示しない
(add-hook 'calendar-mode-hook
          (lambda () (setq show-trailing-whitespace nil)))
