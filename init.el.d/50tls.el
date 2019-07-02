(static-when (file-exists-p "/etc/ssl/certs/ca-certificates.crt")
  ;; see doc string of tls-checktrust
  (setq tls-program
        '("gnutls-cli --x509cafile /etc/ssl/certs/ca-certificates.crt -p %p %h"
          "gnutls-cli --x509cafile /etc/ssl/certs/ca-certificates.crt -p %p %h --protocols ssl3"
          "openssl s_client -connect %h:%p -CAfile /etc/ssl/certs/ca-certificates.crt -no_ssl2 -ign_eof"))
  )
(setq elmo-network-use-gnutls nil)
