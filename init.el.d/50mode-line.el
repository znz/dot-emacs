;; 同一ファイル名のバッファ名を分かりやすくする。
(static-when (locate-library "uniquify")
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
  (setq uniquify-ignore-buffers-re "*[^*]+*")
  ;;(setq uniquify-min-dir-content 1)
  )

;; 重複する空白を削る。
(setq-default
 mode-line-format
 (mapcar
  (lambda (arg)
    (cond
     ((stringp arg)
      (if (string-match " +" arg)
          (replace-match " " nil nil arg)
        arg))
     (t arg)
     ))
  mode-line-format))

;; モードラインに時刻表示。M-x display-time-modeで切り替え。
(setq display-time-24hr-format t) ;; 24 時間表示
(setq display-time-day-and-date t) ;; 時刻の書式に日付を追加
;;(display-time)

(line-number-mode t) ;; カーソルが何行目かを表示
(column-number-mode t) ;; カーソルが何桁目かを表示

;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;; mode-line の " Encoded-kbd" を短くする
;(when (consp (assq 'encoded-kbd-mode minor-mode-alist))
;  (setcar (cdr (assq 'encoded-kbd-mode minor-mode-alist)) " Ek"))
;(when (consp (assq 'abbrev-mode minor-mode-alist))
;  (setcar (cdr (assq 'abbrev-mode minor-mode-alist)) " ab"))
;(when (consp (assq 'auto-fill-function minor-mode-alist))
;  (setcar (cdr (assq 'auto-fill-function minor-mode-alist)) " Fil"))
(defun my-shorten-minor-mode-name (mode-sym short-name &optional face)
  "minor-modeの名前を短くする。"
  (let ((cell (assq mode-sym minor-mode-alist)))
    (when (consp cell)
      (if face
          (setq short-name (propertize short-name 'face face))
        (setq short-name (concat " " short-name)))
      (setcar (cdr cell) short-name))
    ))

(dolist
    (m
     '(
       (abbrev-mode "省" (:foreground "green"))
       (auto-fill-function "詰" (:foreground "yellow"))
       (encoded-kbd-mode "鍵" (:foreground "blue"))
       ))
  (apply 'my-shorten-minor-mode-name m))
(eval-after-load "view"
  '(my-shorten-minor-mode-name
    'view-mode "見" '(:foreground "white" :background "DeepPink1")))
(eval-after-load "outline"
  '(my-shorten-minor-mode-name
    'outline-minor-mode "O" '(:foreground "blue")))
(eval-after-load "ruby-block"
  '(my-shorten-minor-mode-name 'ruby-block-mode "区"))

(put 'eldoc-minor-mode-string 'risky-local-variable t)
(setq eldoc-minor-mode-string
      (propertize "d" 'face '(:foreground "purple" :background "yellow")))

(put 'action-lock-lighter 'risky-local-variable t)
(setq action-lock-lighter (propertize "AL" 'face '(:foreground "red")))

(defun my-shorten-isearch-mode-name ()
  "isearch-modeのmode-lineでの名前を短くする。"
  ;(setcar (cdr (assq 'isearch-mode minor-mode-alist)) " Is")
  (put 'isearch-mode 'risky-local-variable t)
  (setq isearch-mode
        (propertize "探" 'face '(:foreground "blue" :background "white")))
  (force-mode-line-update))
(add-hook
 'isearch-mode-hook
 'my-shorten-isearch-mode-name)

(setq my-shorten-mode-name-list
      '(
        (emacs-lisp-mode "'" (:foreground "green" :background "white"))
        (lisp-interaction-mode "`" (:foreground "red" :background "white"))
        (perl-mode "pl" (:foreground "yellow" :background "white"))
        (python-mode "py" (:foreground "yellow" :background "white"))
        (ruby-mode "rb" (:foreground "red" :background "white"))
        (texinfo-mode "Texi")
        ))
(defun my-shorten-mode-name ()
  ;(make-local-variable 'my-original-mode-name)
  ;(setq my-original-mode-name mode-name)
  (let ((m (assq major-mode my-shorten-mode-name-list)))
    (when m
  (let* ((sym (car m))
         (face (caddr m))
         (name (cadr m)))
    (when (and face (fboundp 'propertize))
      (setq name (propertize name 'face face)))
    ;(message "original mode-name was %s" mode-name)
    (setq mode-name name)
      ))))
(dolist (m my-shorten-mode-name-list)
  (add-hook
   (intern (concat (symbol-name (car m)) "-hook"))
   'my-shorten-mode-name))

(setq-default mode-line-buffer-identification '("%b"))
(setq mode-line-frame-identification " ")

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
