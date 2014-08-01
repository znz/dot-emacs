(static-when (locate-library "tramp")
  (setq tramp-auto-save-directory
        (expand-file-name "tramp" temporary-file-directory))
  (setq tramp-persistency-file-name
        (expand-file-name "tramp-connection-history.el"
                          temporary-file-directory))
  ;; バックアップファイルを作らない。
  (add-to-list 'backup-directory-alist
               (cons tramp-file-name-regexp nil))
  (static-when (featurep 'meadow)
    ;; http://www.unix-fan.com/celt/blog/20040501.html を参考にした。
    (modify-coding-system-alist 'process "plink" my-tramp-pscp-coding-system)
    (modify-coding-system-alist 'process "pscp" my-tramp-pscp-coding-system)
    (setq tramp-completion-without-shell-p t)
    (setq tramp-default-method "pscp"))
  (static-unless (featurep 'meadow)
    (setq tramp-default-method "sshx"))

  (defun my-tramp-setup ()
    (setq
     tramp-methods
     (cons
      '("tmp"
        (tramp-connection-function tramp-open-connection-telnet)
        (tramp-rsh-program nil)
        (tramp-rcp-program nil)
        (tramp-remote-sh "/bin/sh")
        (tramp-rsh-args nil)
        (tramp-rcp-args nil)
        (tramp-rcp-keep-date-arg nil)
        (tramp-su-program nil)
        (tramp-su-args nil)
        (tramp-encoding-command "tramp_mimencode")
        (tramp-decoding-command "tramp_mimedecode")
        (tramp-encoding-function base64-encode-region)
        (tramp-decoding-function base64-decode-region)
        (tramp-telnet-program "telnet")
        (tramp-telnet-args nil))
      tramp-methods))
    ;; emacs23以降にはないし、emacs22でもうまくいかなかったのでコメントアウト。
    ;; (add-to-list
    ;;  'tramp-multi-connection-function-alist
    ;;  '("sshx" tramp-multi-connect-rlogin
    ;;    "ssh %h -e none -t -t -l %u /bin/sh%n"))
    )

  ;; eval-after-loadなのでquote必須
  (eval-after-load "tramp" '(my-tramp-setup))

  (setq tramp-perl-encode
        "%s -e '
sub encode_base64 ($);
  my $buf;
  while(read(STDIN, $buf, 60*57)) { print encode_base64($buf) }
  sub encode_base64 ($) {
    my $res = \"\";
    my $eol = \"\n\";
    pos($_[0]) = 0;                          # ensure start at the beginning
    while ($_[0] =~ /(.{1,45})/gs) {
        $res .= substr(pack(\"u\", $1), 1);
        chop($res);
    }
    $res =~ tr|` -_|AA-Za-z0-9+/|;               # `# help emacs
    # fix padding at the end
    my $padding = (3 - length($_[0]) %% 3) %% 3;
    $res =~ s/.{$padding}$/\"=\" x $padding/e if $padding;
    # break encoded string into lines of no more than 76 characters each
    if (length $eol) {
        $res =~ s/(.{1,76})/$1$eol/g;
    }
    $res;}'")
  (setq tramp-perl-decode
        "%s -e '
sub decode_base64 ($);
  my $buf;
  while(read(STDIN, $buf, 60*57)) { print decode_base64($buf) }
  sub decode_base64 ($) {
    local($^W) = 0; # unpack(\"u\",...) gives bogus warning in 5.00[123]

    my $str = shift;
    my $res = \"\";

    $str =~ tr|A-Za-z0-9+=/||cd;            # remove non-base64 chars
    if (length($str) %% 4) {
        warn(\"Length of base64 data not a multiple of 4\")
    }
    $str =~ s/=+$//;                        # remove padding
    $str =~ tr|A-Za-z0-9+/| -_|;            # convert to uuencoded format
    while ($str =~ /(.{1,60})/gs) {
        my $len = chr(32 + length($1)*3/4); # compute length byte
        $res .= unpack(\"u\", $len . $1 );    # uudecode
    }
    $res;}'")

  ;; telnetでなぜか"$ $ "になるのでその対策。
  (setq tramp-shell-prompt-pattern
        (concat
         "^\\("
         "[^#$%>\n]*[#$%>][ \015]*"
         "\\(\e\\[[0-9;]*[a-zA-Z][ \015]*\\)*"
         "\\)+"
         )
        )

  (require 'tramp))
