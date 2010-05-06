#!/usr/bin/make -f
# -*- coding: utf-8 -*-

default: init_files

.PHONY:: default emacs_symlink init_files clean

DOT_EMACS_D_DIR = $(HOME)/.emacs.d
EMACS_D_DIR = $(shell pwd)

# Cocoa Emacs (MacPorts)
EMACS_APP = $(wildcard /Applications/MacPorts/Emacs.app)
ifneq "$(EMACS_APP)" ""
EMACS = $(EMACS_APP)/Contents/MacOS/Emacs
else
EMACS = $(shell which emacs)
endif

RUBY = ruby

emacs_symlink:: $(HOME)/.emacs.el
init_files:: $(DOT_EMACS_D_DIR)
init_files:: $(DOT_EMACS_D_DIR)/init.el
init_files:: $(DOT_EMACS_D_DIR)/dot-navi2ch.el
init_files:: $(DOT_EMACS_D_DIR)/dot-wl.el

ifeq ($(OS),Windows_NT)
$(HOME)/.emacs.el: $(EMACS_D_DIR)/emacs.el
	cp $< $@
else
$(HOME)/.emacs.el: $(EMACS_D_DIR)/emacs.el
	[ -L $@ -o ! -e $@ ]
	ln -sf $(CURDIR)/$< $@
endif

$(DOT_EMACS_D_DIR):
	mkdir $(DOT_EMACS_D_DIR)

# 結合と*.elcの削除
$(DOT_EMACS_D_DIR)/init.el: $(EMACS_D_DIR)/init.el.d/[0-9][0-9]*.el
	sed '/^ *;;/d;/^$$/d' $^ > $@
	rm -f $@c
$(DOT_EMACS_D_DIR)/dot-%.el: $(EMACS_D_DIR)/%.d/[0-9][0-9]*.el
	cat $^ > $@
	rm -f $@c
$(DOT_EMACS_D_DIR)/dot-wl.el: $(EMACS_D_DIR)/wanderlust.d/[0-9][0-9]*.el
	cat $^ > $@
	rm -f $@c

clean:
	rm -f $(DOT_EMACS_D_DIR)/*.elc

APEL_VERSION = 10.7
.PHONY:: install-apel
install-apel: apel-$(APEL_VERSION).tar.gz
	tar xvf apel-$(APEL_VERSION).tar.gz
	(cd apel-$(APEL_VERSION) && make EMACS=$(EMACS) && sudo make EMACS=$(EMACS) install)
	rm -rf apel-$(APEL_VERSION)

apel-$(APEL_VERSION).tar.gz:
	curl -O http://kanji.zinbun.kyoto-u.ac.jp/~tomo/lemi/dist/apel/apel-$(APEL_VERSION).tar.gz

.PHONY:: auto-install
AUTO_INSTALL_DIR = $(DOT_EMACS_D_DIR)/auto-install
auto-install:: $(AUTO_INSTALL_DIR)
$(AUTO_INSTALL_DIR):
	mkdir $(AUTO_INSTALL_DIR)

## see init.el.d/10install.el
auto-install:: $(AUTO_INSTALL_DIR)/auto-install.el
$(AUTO_INSTALL_DIR)/auto-install.el:
	wget -N http://www.emacswiki.org/emacs/download/auto-install.el -O $@

auto-install:: $(AUTO_INSTALL_DIR)/cp5022x.el
$(AUTO_INSTALL_DIR)/cp5022x.el:
	wget -N http://nijino.homelinux.net/emacs/cp5022x.el -O $@

SITE_LISP_DIR = $(DOT_EMACS_D_DIR)/site-lisp

.PHONY:: install-w3m
EMACS_W3M_DIR = $(EMACS_D_DIR)/../w3m
install-w3m: $(EMACS_W3M_DIR)
	cd $(EMACS_W3M_DIR) && autoreconf -f -i -s
	cd $(EMACS_W3M_DIR) && ./configure --prefix="$(DOT_EMACS_D_DIR)/prefix" --with-lispdir="$(SITE_LISP_DIR)/w3m" --with-icondir="$(DOT_EMACS_D_DIR)/icons/w3m" --infodir="$(DOT_EMACS_D_DIR)/info"
	cd $(EMACS_W3M_DIR) && make
	cd $(EMACS_W3M_DIR) && make install
	cd $(EMACS_W3M_DIR) && make install-icons
	cd $(EMACS_W3M_DIR) && git clean -f
	cd $(EMACS_W3M_DIR) && rm -r autom4te.cache
	cd $(EMACS_W3M_DIR) && git status
$(EMACS_W3M_DIR):
	mkdir -p $(EMACS_W3M_DIR)/CVS
	cd $(EMACS_W3M_DIR) && echo emacs-w3m > CVS/Repository
	cd $(EMACS_W3M_DIR) && echo :pserver:anonymous@cvs.namazu.org:/storage/cvsroot > CVS/Root
	cd $(EMACS_W3M_DIR) && git cvsimport -v

.PHONY:: install-wl
WL_DIR = $(EMACS_D_DIR)/../wanderlust
install-wl: $(WL_DIR)
	cd $(WL_DIR) && $(RUBY) -pli~ -e 'sub(/^;(.* wl-install-utils )/){$$1}' WL-CFG
	cd $(WL_DIR) && echo '(setq load-path (cons "~/.site-lisp/load-path/emacs-w3m" load-path))' >> WL-CFG
	cd $(WL_DIR) && make "EMACS=$(EMACS)" "LISPDIR=$(SITE_LISP_DIR)/wl" "INFODIR=$(DOT_EMACS_D_DIR)/info" "PIXMAPDIR=$(DOT_EMACS_D_DIR)/icons/wl" elc install-elc install-info
	cd $(WL_DIR) && git checkout WL-CFG
	cd $(WL_DIR) && git clean -f
	cd $(WL_DIR) && git status
$(WL_DIR):
	mkdir -p $(WL_DIR)/CVS
	cd $(WL_DIR) && echo wanderlust > CVS/Repository
	cd $(WL_DIR) && echo :pserver:anonymous@cvs.m17n.org:/cvs/root > CVS/Root
	cd $(WL_DIR) && git cvsimport -v
