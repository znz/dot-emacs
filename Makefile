#!/usr/bin/make -f
# -*- coding: utf-8 -*-

default: emacs_symlink

.PHONY:: default emacs_symlink

DOT_EMACS_D_DIR = $(HOME)/.emacs.d
EMACS_D_DIR = .

emacs_symlink:: $(HOME)/.emacs.el
emacs_symlink:: $(DOT_EMACS_D_DIR)/init.el

ifeq ($(OS),Windows_NT)
$(HOME)/.emacs.el: $(EMACS_D_DIR)/emacs.el
	cp $< $@
else
$(HOME)/.emacs.el: $(EMACS_D_DIR)/emacs.el
	[ -L $@ -o ! -e $@ ]
	ln -sf $(CURDIR)/$< $@
endif

# 結合と*.elcの削除
$(DOT_EMACS_D_DIR)/init.el: $(EMACS_D_DIR)/init.el.d/[0-9][0-9]*.el
	sed '/^ *;;/d;/^$$/d' $^ > $@
	rm -f $@c
