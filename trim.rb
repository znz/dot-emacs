#!/usr/bin/env ruby
trail = <<'ELISP'

;;; Local Variables:
;;; mode: emacs-lisp
;;; coding: utf-8
;;; indent-tabs-mode: nil
;;; End:
ELISP
re = /#{Regexp.quote(trail)}\z/
ARGV.each do |el|
  elisp = File.read(el)
  if re =~ elisp
    elisp.sub!(re, '')
    File.write(el, elisp)
  end
end
