(static-cond
 ((>= emacs-major-version 23)
  (setq line-move-visual t)
  (defalias 'my-previous-physical-line 'previous-line)
  (defalias 'my-next-physical-line 'next-line)
  (defalias 'my-previous-window-line 'previous-line)
  (defalias 'my-next-window-line 'next-line)
  (defadvice my-previous-physical-line (around force-physical-line activate)
    (let ((line-move-visual t))
      ad-do-it))
  (defadvice my-next-physical-line (around force-physical-line activate)
    (let ((line-move-visual t))
      ad-do-it))
  (defadvice my-previous-window-line (around force-window-line activate)
    (let ((line-move-visual t))
      ad-do-it))
  (defadvice my-next-window-line (around force-window-line activate)
    (let ((line-move-visual t))
      ad-do-it))
  )

 (t
  (defalias 'my-previous-physical-line 'previous-line)
  (defalias 'my-next-physical-line 'next-line)

  (defun my-previous-window-line (n)
    (interactive "p")
    (let ((cur-col
           (- (current-column)
              (save-excursion (vertical-motion 0) (current-column)))))
      (vertical-motion (- n))
      (move-to-column (+ (current-column) cur-col)))
    (run-hooks 'auto-line-hook)
    )

  (defun my-next-window-line (n)
    (interactive "p")
    (let ((cur-col
           (- (current-column)
              (save-excursion (vertical-motion 0) (current-column)))))
      (vertical-motion n)
      (move-to-column (+ (current-column) cur-col)))
    (run-hooks 'auto-line-hook)
    )
  ))

(global-set-key "\C-p" 'my-previous-window-line)
(global-set-key "\C-n" 'my-next-window-line)
(define-key my-prefix-map "\C-p" 'my-previous-physical-line)
(define-key my-prefix-map "\C-n" 'my-next-physical-line)
(global-set-key [up] 'my-previous-window-line)
(global-set-key [down] 'my-next-window-line)

(setq line-move-ignore-invisible t)

(static-when (locate-library "longlines")
  ;; M-x longlines-mode で見かけの改行が入る。
  (setq longlines-show-hard-newlines t)
  )

;; 行頭での C-a を M-m の挙動にする。
(defadvice move-beginning-of-line (around move-bol-or-bti activate)
  (if (bolp)
      (back-to-indentation)
    ad-do-it))
