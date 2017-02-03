;; .emacs 高速化のために static を使って環境をチェックしているので、
;; 環境の変化があったときにもバイトコンパイルし直す必要がある。

(mapc
 (lambda (path)
   (when (file-directory-p path)
     (add-to-list 'load-path path)))
 '("~/.emacs.d/site-lisp/apel"
   "~/.emacs.d/site-lisp/emu"))

(eval-when-compile
  (unless (require 'static nil t)
    ;; license of program from static.el is GPL-2+, see ../licenses/GPL-2
    ;; import from static.el after here
    (put 'static-if 'lisp-indent-function 2)
    (defmacro static-if (cond then &rest else)
      "Like `if', but evaluate COND at compile time."
      (if (eval cond)
          then
        (` (progn  (,@ else)))))

    (put 'static-when 'lisp-indent-function 1)
    (defmacro static-when (cond &rest body)
      "Like `when', but evaluate COND at compile time."
      (if (eval cond)
          (` (progn (,@ body)))))

    (put 'static-unless 'lisp-indent-function 1)
    (defmacro static-unless (cond &rest body)
      "Like `unless', but evaluate COND at compile time."
      (if (eval cond)
          nil
        (` (progn (,@ body)))))

    (defmacro static-cond (&rest clauses)
      "Like `cond', but evaluate CONDITION part of each clause at compile time."
      (while (and clauses
                  (not (eval (car (car clauses)))))
        (setq clauses (cdr clauses)))
      (if clauses
          (cons 'progn (cdr (car clauses)))))
    ;; import from static.el before here
    ))
