(static-when (fboundp 'server-start)
  (require 'server)
  (if (and (fboundp 'server-running-p)
           (not (server-running-p)))
      (server-start)))
