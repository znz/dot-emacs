#!/usr/bin/make -f
# -*- coding: utf-8 -*-

default: init_files

.PHONY:: default emacs_symlink init_files clean

DOT_EMACS_D_DIR = $(HOME)/.emacs.d
EMACS_D_DIR = .

# Cocoa Emacs (MacPorts)
EMACS_APP = $(wildcard /Applications/MacPorts/Emacs.app)
ifneq "$(EMACS_APP)" ""
EMACS = $(EMACS_APP)/Contents/MacOS/Emacs
else
EMACS = $(shell which emacs)
endif

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
install-apel: apel-$(APEL_VERSION).tar.gz
	tar xvf apel-$(APEL_VERSION).tar.gz
	(cd apel-$(APEL_VERSION) && make EMACS=$(EMACS) && sudo make EMACS=$(EMACS) install)
	rm -rf apel-$(APEL_VERSION)

apel-$(APEL_VERSION).tar.gz:
	curl -O http://kanji.zinbun.kyoto-u.ac.jp/~tomo/lemi/dist/apel/apel-$(APEL_VERSION).tar.gz
