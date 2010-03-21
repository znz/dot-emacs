(static-cond
 ((>= emacs-major-version 23)
  (global-set-key "\C-p" 'previous-line)
  (global-set-key "\C-n" 'next-line)
  (setq line-move-visual nil)
  (defun previous-window-line (n)
    (interactive "p")
    (let ((line-move-visual t))
      (previous-line n)))
  (defun next-window-line (n)
    (interactive "p")
    (let ((line-move-visual t))
      (next-line n)))
  (global-set-key [up] 'previous-window-line)
  (global-set-key [down] 'next-window-line)
  )

 (t
  ;;(global-set-key "\C-p" 'previous-window-line)
  ;;(global-set-key "\C-n" 'next-window-line)
  (global-set-key [up] 'previous-window-line)
  (global-set-key [down] 'next-window-line)

  (defun previous-window-line (n)
    (interactive "p")
    (let ((cur-col
           (- (current-column)
              (save-excursion (vertical-motion 0) (current-column)))))
      (vertical-motion (- n))
      (move-to-column (+ (current-column) cur-col)))
    (run-hooks 'auto-line-hook)
    )

  (defun next-window-line (n)
    (interactive "p")
    (let ((cur-col
           (- (current-column)
              (save-excursion (vertical-motion 0) (current-column)))))
      (vertical-motion n)
      (move-to-column (+ (current-column) cur-col)))
    (run-hooks 'auto-line-hook)
    )
  ))

(setq line-move-ignore-invisible t)

(static-when (locate-library "longlines")
  ;; M-x longlines-mode で見かけの改行が入る。
  (setq longlines-show-hard-newlines t)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
