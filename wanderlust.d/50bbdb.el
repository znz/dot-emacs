;; BBDB
(static-when (and (locate-library "bbdb") (locate-library "bbdb-wl"))
  (require 'bbdb-wl)
  (setq bbdb-wl-ignore-folder-regexp
        "^[-$&@']\\|^\\+\\(draft\\|lost\\+found\\|outbox\\|queue\\|sent\\|trash\\)\\|^[%].*\\(info\\|junk\\|log\\|root\\|spam\\)")
  (setq bbdb-user-mail-names (regexp-opt wl-user-mail-address-list))
  (bbdb-wl-setup))
