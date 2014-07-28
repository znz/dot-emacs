(add-to-list 'my/favorite-packages 'go-mode)
(add-to-list 'my/favorite-packages 'go-eldoc)
(when (require 'go-mode nil t)
  ;; go get -u github.com/nsf/gocode
  (when (require 'go-eldoc nil t)
    (add-hook 'go-mode-hook 'go-eldoc-setup))

  ;; go get -u code.google.com/p/rog-go/exp/cmd/godef
  (add-hook
   'go-mode-hook
   (lambda ()
     (local-set-key (kbd "M-.") 'godef-jump)))


  (let* ((gopath (or (getenv "GOPATH")
		     (expand-file-name "~/g")))
	 (go/bin (concat gopath "/bin")))
    (when (file-directory-p gopath)
      (setenv "GOPATH" gopath)
      (my-add-to-path go/bin)))

  ;; go get -u code.google.com/p/go.tools/cmd/goimports
  (static-when (executable-find "goimports")
    (setq gofmt-command "goimports"))
  )
