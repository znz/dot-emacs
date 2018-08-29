(defun my-add-to-path (path)
  (when (file-directory-p path)
    (setenv "PATH" (concat path ":" (getenv "PATH")))
    (add-to-list 'exec-path path)))
(mapc #'my-add-to-path
 (file-expand-wildcards "/opt/local/*bin") ; MacPorts
 )
(my-add-to-path "/usr/local/bin") ; Homebrew
(my-add-to-path (expand-file-name "~/homebrew/bin")) ; Homebrew
;; rbenv
(my-add-to-path (expand-file-name "~/.rbenv/bin"))
(my-add-to-path (expand-file-name "~/.rbenv/shims"))
(my-add-to-path (expand-file-name "/opt/rbenv/bin"))
(my-add-to-path (expand-file-name "/opt/rbenv/shims"))
;; anyenv
(my-add-to-path (expand-file-name "~/.anyenv/bin"))
(mapc #'my-add-to-path
  (mapcar #'expand-file-name
    (file-expand-wildcards "~/.anyenv/envs/*/bin")
    ))
(mapc #'my-add-to-path
  (mapcar #'expand-file-name
    (file-expand-wildcards "~/.anyenv/envs/*/shims")
    ))
