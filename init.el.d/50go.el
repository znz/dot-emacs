(add-to-list 'my/favorite-packages 'go-mode)
(add-to-list 'my/favorite-packages 'go-eldoc)
(when (require 'go-mode nil t)
  ;; go get -u github.com/nsf/gocode
  (when (require 'go-eldoc nil t)
    (add-hook 'go-mode-hook 'go-eldoc-setup))

  ;; go get code.google.com/p/rog-go/exp/cmd/godef
  (add-hook
   'go-mode-hook
   (lambda ()
     (local-set-key (kbd "M-.") 'godef-jump)))

  (let* ((gopath (or (getenv "GOPATH")
		     (expand-file-name "~/g")))
	 (go/bin (concat gopath "/bin")))
    (when (file-directory-p gopath)
      (setenv "GOPATH" gopath)
      (add-to-list 'exec-path go/bin)))
  )
