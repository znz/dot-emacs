;; http://www.rubyist.net/~rubikitch/computer/irbsh/
(static-when
    (and (locate-library "irbsh")
         (require 'inf-ruby nil t)
         (string-match
          "true"
          (shell-command-to-string
           (concat "echo 'p $LOADED_FEATURES.any?{|f|/irbsh/=~f}'|"
                   ruby-program-name)
           )))
  (autoload 'irbsh "irbsh" "irbsh - IRB.extend ShellUtilities" t)
  (autoload 'irbsh-oneliner-with-completion "irbsh" "irbsh oneliner" t)
  (autoload 'irbsh-toggle "irbsh-toggle"
    "Toggles between the *irbsh*1 buffer and whatever buffer you are editing." t)
  (autoload 'irbsh-toggle-cd "irbsh-toggle"
    "Pops up a irbsh-buffer and insert a \"cd <file-dir>\" command." t)
  )

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
