#!/usr/bin/make -f
# -*- coding: utf-8 -*-

default: init_files

.PHONY:: default emacs_symlink init_files clean allclean all update

DOT_EMACS_D_DIR = $(HOME)/.emacs.d
SRC_TOP_DIR = $(shell pwd)
RUBY = $(shell which ruby)
SITE_LISP_DIR = $(DOT_EMACS_D_DIR)/site-lisp
INFO_DIR = $(DOT_EMACS_D_DIR)/info

# Cocoa Emacs (MacPorts)
EMACS_APP = $(wildcard /Applications/MacPorts/Emacs.app)
ifneq "$(EMACS_APP)" ""
EMACS = $(EMACS_APP)/Contents/MacOS/Emacs
else
EMACS = $(shell which emacs)
endif


emacs_symlink:: $(HOME)/.emacs.el
init_files:: $(DOT_EMACS_D_DIR)
INIT_FILES += $(DOT_EMACS_D_DIR)/init.el
INIT_FILES += $(DOT_EMACS_D_DIR)/dot-mhc.el
INIT_FILES += $(DOT_EMACS_D_DIR)/dot-navi2ch.el
INIT_FILES += $(DOT_EMACS_D_DIR)/dot-wl.el
init_files:: $(INIT_FILES)
all:: init_files

ifeq ($(OS),Windows_NT)
$(HOME)/.emacs.el: $(SRC_TOP_DIR)/emacs.el
	cp $< $@
else
$(HOME)/.emacs.el: $(SRC_TOP_DIR)/emacs.el
	[ -L $@ -o ! -e $@ ]
	ln -sf $(CURDIR)/$< $@
endif

$(DOT_EMACS_D_DIR):
	mkdir $(DOT_EMACS_D_DIR)

# 結合と*.elcの削除
$(DOT_EMACS_D_DIR)/init.el: $(SRC_TOP_DIR)/init.el.d/[0-9][0-9]*.el
	sed '/^ *;;/d;/^$$/d' $^ > $@
	rm -f $@c
$(DOT_EMACS_D_DIR)/dot-%.el: $(SRC_TOP_DIR)/%.d/[0-9][0-9]*.el
	cat $^ > $@
	rm -f $@c
$(DOT_EMACS_D_DIR)/dot-wl.el: $(SRC_TOP_DIR)/wanderlust.d/[0-9][0-9]*.el
	cat $^ > $@
	rm -f $@c

clean::
	rm -f $(DOT_EMACS_D_DIR)/*.elc
allclean:: clean
	rm -f $(INIT_FILES)
	rm -rf $(INFO_DIR)

APEL_VERSION = 10.8
.PHONY:: install-apel uninstall-apel
install-apel: $(SITE_LISP_DIR)/apel
$(SITE_LISP_DIR)/apel: apel
	(cd apel && make install EMACS=$(EMACS) LISPDIR=$(SITE_LISP_DIR) VERSION_SPECIFIC_LISPDIR=$(SITE_LISP_DIR))
	(cd apel && git clean -dfx)
apel:
	git clone git://github.com/wanderlust/apel.git
uninstall-apel:
	rm -rf $(SITE_LISP_DIR)/apel $(SITE_LISP_DIR)/emu
all:: install-apel
allclean:: uninstall-apel

#FLIM_VERSION = 1.14.9
FLIM_VERSION = 1.14
.PHONY:: install-flim uninstall-flim
install-flim: $(SITE_LISP_DIR)/flim
ifeq "$(FLIM_VERSION)" "1.14"
$(SITE_LISP_DIR)/flim: flim-1.14
	cd flim-1.14 && make install EMACS=$(EMACS) LISPDIR=$(SITE_LISP_DIR)
flim-1.14:
	cvs -z9 -d :pserver:anonymous@cvs.m17n.org:/cvs/root checkout -r flim-1_14 -d flim-1.14 flim
update-flim:
	cd flim-1.14 && cvs -qz9 update -dP
update:: update-flim
else
$(SITE_LISP_DIR)/flim: flim-$(FLIM_VERSION).tar.gz
	tar xvf flim-$(FLIM_VERSION).tar.gz
	(cd flim-$(FLIM_VERSION) && make install EMACS=$(EMACS) LISPDIR=$(SITE_LISP_DIR))
	rm -rf flim-$(FLIM_VERSION)
flim-$(FLIM_VERSION).tar.gz:
	curl -O http://kanji.zinbun.kyoto-u.ac.jp/~tomo/lemi/dist/flim/flim-1.14/flim-$(FLIM_VERSION).tar.gz
endif
uninstall-flim:
	rm -rf $(SITE_LISP_DIR)/flim
all:: install-flim
allclean:: uninstall-flim

#SEMI_VERSION = 1.14.6
SEMI_VERSION = 1.14
.PHONY:: install-semi uninstall-semi
install-semi: $(SITE_LISP_DIR)/semi
ifeq "$(SEMI_VERSION)" "1.14"
$(SITE_LISP_DIR)/semi: semi-1.14
	cd semi-1.14 && make install EMACS=$(EMACS) LISPDIR=$(SITE_LISP_DIR)
semi-1.14:
	cvs -z9 -d :pserver:anonymous@cvs.m17n.org:/cvs/root checkout -r semi-1_14 -d semi-1.14 semi
update-semi:
	cd semi-1.14 && cvs -qz9 update -dP
update:: update-semi
else
$(SITE_LISP_DIR)/semi: semi-$(SEMI_VERSION).tar.gz
	tar xvf semi-$(SEMI_VERSION).tar.gz
	(cd semi-$(SEMI_VERSION) && ln -snf $(SITE_LISP_DIR)/flim)
	(cd semi-$(SEMI_VERSION) && make install EMACS=$(EMACS) LISPDIR=$(SITE_LISP_DIR))
	rm -rf semi-$(SEMI_VERSION)
semi-$(SEMI_VERSION).tar.gz:
	curl -O http://www.kanji.zinbun.kyoto-u.ac.jp/~tomo/lemi/dist/semi/semi-1.14-for-flim-1.14/semi-$(SEMI_VERSION).tar.gz
endif
uninstall-semi:
	rm -rf $(SITE_LISP_DIR)/semi
all:: install-semi
allclean:: uninstall-semi


.PHONY:: install-auto-install uninstall-auto-install
AUTO_INSTALL_DIR = $(DOT_EMACS_D_DIR)/auto-install
install-auto-install:: $(AUTO_INSTALL_DIR)
$(AUTO_INSTALL_DIR):
	mkdir $(AUTO_INSTALL_DIR)

## see init.el.d/10install.el
install-auto-install:: $(AUTO_INSTALL_DIR)/auto-install.el
$(AUTO_INSTALL_DIR)/auto-install.el:
	curl http://www.emacswiki.org/emacs/download/auto-install.el -o $@
install-auto-install:: $(AUTO_INSTALL_DIR)/cp5022x.el
$(AUTO_INSTALL_DIR)/cp5022x.el:
	curl http://nijino.homelinux.net/emacs/cp5022x.el -o $@
uninstall-auto-install:
	rm -f $(AUTO_INSTALL_DIR)/auto-install.el $(AUTO_INSTALL_DIR)/cp5022x.el
all:: install-auto-install
allclean:: uninstall-auto-install


.PHONY:: install-skk uninstall-skk
SKK_DIR = $(SRC_TOP_DIR)/skk
install-skk: $(SITE_LISP_DIR)/skk
$(SITE_LISP_DIR)/skk: $(SKK_DIR)
	cd $(SKK_DIR)/main && echo '(setq APEL_DIR "$(SITE_LISP_DIR)/apel")' >> SKK-CFG
	cd $(SKK_DIR)/main && echo '(setq EMU_DIR "$(SITE_LISP_DIR)/emu")' >> SKK-CFG
	cd $(SKK_DIR)/main && echo '(setq SKK_DATADIR "$(DOT_EMACS_D_DIR)/etc/skk")' >> SKK-CFG
	cd $(SKK_DIR)/main && echo '(setq SKK_INFODIR "$(INFO_DIR)")' >> SKK-CFG
	cd $(SKK_DIR)/main && echo '(setq SKK_LISPDIR "$(SITE_LISP_DIR)/skk")' >> SKK-CFG
	cd $(SKK_DIR)/main && make what-where EMACS=$(EMACS)
	cd $(SKK_DIR)/main && make install EMACS=$(EMACS)
	cd $(SKK_DIR)/main && git clean -f
	cd $(SKK_DIR)/main && git checkout SKK-CFG
$(SKK_DIR):
	mkdir -p $(SKK_DIR)/CVS
	cd $(SKK_DIR) && echo skk > CVS/Repository
	echo enter guest as password
	cvs -d :pserver:guest@openlab.jp:/circus/cvsroot login
	cd $(SKK_DIR) && echo :pserver:guest@openlab.jp:/circus/cvsroot > CVS/Root
	cd $(SKK_DIR) && git cvsimport -v
update-skk:
	cd $(SKK_DIR) && git cvsimport -v
uninstall-skk:
	rm -rf $(SITE_LISP_DIR)/skk
	rm -rf $(DOT_EMACS_D_DIR)/etc/skk
all:: install-skk
allclean:: uninstall-skk
update:: update-skk

.PHONY:: install-w3m uninstall-w3m
EMACS_W3M_DIR = $(SRC_TOP_DIR)/w3m
install-w3m: $(SITE_LISP_DIR)/w3m
$(SITE_LISP_DIR)/w3m: $(EMACS_W3M_DIR)
	cd $(EMACS_W3M_DIR) && autoreconf -f -i -s
	cd $(EMACS_W3M_DIR) && ./configure --prefix="$(DOT_EMACS_D_DIR)/prefix" --with-lispdir="$(SITE_LISP_DIR)/w3m" --with-icondir="$(DOT_EMACS_D_DIR)/icons/w3m" --infodir="$(INFO_DIR)"
	cd $(EMACS_W3M_DIR) && make what-where EMACS=$(EMACS)
	cd $(EMACS_W3M_DIR) && make EMACS=$(EMACS)
	cd $(EMACS_W3M_DIR) && make install EMACS=$(EMACS)
	cd $(EMACS_W3M_DIR) && make install-icons EMACS=$(EMACS)
	cd $(EMACS_W3M_DIR) && git clean -f
	cd $(EMACS_W3M_DIR) && rm -r autom4te.cache
	cd $(EMACS_W3M_DIR) && git status
$(EMACS_W3M_DIR):
	mkdir -p $(EMACS_W3M_DIR)/CVS
	cd $(EMACS_W3M_DIR) && echo emacs-w3m > CVS/Repository
	cd $(EMACS_W3M_DIR) && echo :pserver:anonymous@cvs.namazu.org:/storage/cvsroot > CVS/Root
	cd $(EMACS_W3M_DIR) && git cvsimport -v
update-w3m:
	cd $(EMACS_W3M_DIR) && git cvsimport -v
uninstall-w3m:
	rm -rf $(SITE_LISP_DIR)/w3m
	rm -rf $(DOT_EMACS_D_DIR)/icons/w3m
all:: install-w3m
allclean:: uninstall-w3m
update:: update-w3m

.PHONY:: install-wl uninstall-wl
WL_DIR = $(SRC_TOP_DIR)/wl
install-wl: $(SITE_LISP_DIR)/wl
$(SITE_LISP_DIR)/wl: $(WL_DIR)
	cd $(WL_DIR) && $(RUBY) -pli~ -e 'sub(/^;(.* wl-install-utils )/){$$1}' WL-CFG
	@: 'w3m を加える。(flimやsemiも)'
	cd $(WL_DIR) && echo '(setq load-path (append (file-expand-wildcards "~/.emacs.d/site-lisp/*") load-path))' >> WL-CFG
	cd $(WL_DIR) && make "EMACS=$(EMACS)" "LISPDIR=$(SITE_LISP_DIR)" "INFODIR=$(INFO_DIR)" "PIXMAPDIR=$(DOT_EMACS_D_DIR)/icons/wl" elc install-elc install-info
	cd $(WL_DIR) && git checkout WL-CFG
	cd $(WL_DIR) && git clean -f
	cd $(WL_DIR) && git status
$(WL_DIR):
	mkdir -p $(WL_DIR)/CVS
	cd $(WL_DIR) && echo wanderlust > CVS/Repository
	cd $(WL_DIR) && echo :pserver:anonymous@cvs.m17n.org:/cvs/root > CVS/Root
	cd $(WL_DIR) && git cvsimport -v
update-wl:
	cd $(WL_DIR) && git cvsimport -v
uninstall-wl:
	rm -rf $(SITE_LISP_DIR)/wl
	rm -rf $(DOT_EMACS_D_DIR)/icons/wl
all:: install-wl
allclean:: uninstall-wl
update:: update-wl

.PHONY:: install-mhc uninstall-mhc
MHC_DIR = $(SRC_TOP_DIR)/mhc
install-mhc: $(SITE_LISP_DIR)/mhc
$(SITE_LISP_DIR)/mhc: $(MHC_DIR)
	cd $(MHC_DIR) && $(RUBY) configure.rb --with-ruby="$(RUBY)" --with-emacs="$(EMACS)" --with-lispdir="$(SITE_LISP_DIR)/mhc" --disable-palm --with-wl --with-icondir="$(DOT_EMACS_D_DIR)/icons/mhc" || echo "ignore error: $$?"
	cd $(MHC_DIR) && $(RUBY) make.rb
	cd $(MHC_DIR) && $(RUBY) make.rb install
	cd $(MHC_DIR) && cp samples/DOT.schedule.sample.jp $(DOT_EMACS_D_DIR)/DOT.schedule.sample.jp
	cd $(MHC_DIR) && git clean -f
	cd $(MHC_DIR) && git status
$(MHC_DIR):
	git clone git://github.com/yoshinari-nomura/mhc.git $(MHC_DIR)
update-mhc:
	cd $(MHC_DIR) && git pull
uninstall-mhc:
	rm -rf $(SITE_LISP_DIR)/mhc
	rm -rf $(DOT_EMACS_D_DIR)/icons/mhc
all:: install-mhc
allclean:: uninstall-mhc
update:: update-mhc

.PHONY:: install-wl-gravatar-el uninstall-wl-gravatar-el
WL_GRAVATAR_EL_DIR = $(SITE_LISP_DIR)/gravatar-el
install-wl-gravatar-el: $(WL_GRAVATAR_EL_DIR)
$(WL_GRAVATAR_EL_DIR):
	git clone git://gist.github.com/283328.git $(WL_GRAVATAR_EL_DIR)
update-wl-gravatar-el:
	cd $(WL_GRAVATAR_EL_DIR) && git pull
uninstall-wl-gravatar-el:
	rm -rf $(WL_GRAVATAR_EL_DIR)
all:: install-wl-gravatar-el
allclean:: uninstall-wl-gravatar-el
update:: update-wl-gravatar-el

.PHONY:: install-org-mode uninstall-org-mode
ORG_MODE_DIR = $(SRC_TOP_DIR)/org-mode
install-org-mode: $(SITE_LISP_DIR)/org-mode install-ditaa.jar
$(SITE_LISP_DIR)/org-mode: $(ORG_MODE_DIR)
	cd $(ORG_MODE_DIR) && make lispdir=$(SITE_LISP_DIR)/org-mode infodir=$(INFO_DIR)
	cd $(ORG_MODE_DIR) && make lispdir=$(SITE_LISP_DIR)/org-mode infodir=$(INFO_DIR) install
install-ditaa.jar: $(SITE_LISP_DIR)/org-mode/ditaa.jar
$(SITE_LISP_DIR)/org-mode/ditaa.jar: $(ORG_MODE_DIR)/contrib/scripts/ditaa.jar
	cd $(ORG_MODE_DIR) && cp -pv contrib/scripts/ditaa.jar $(SITE_LISP_DIR)/org-mode/
$(ORG_MODE_DIR):
	git clone git://repo.or.cz/org-mode.git $(ORG_MODE_DIR)
update-org-mode:
	cd $(ORG_MODE_DIR) && git pull
uninstall-org-mode:
	rm -rf $(SITE_LISP_DIR)/org-mode
all:: install-org-mode
allclean:: uninstall-org-mode
update:: update-org-mode

.PHONY:: install-remember-el uninstall-remember-el
REMEMBER_EL_DIR = $(SRC_TOP_DIR)/remember-el
install-remember-el: $(SITE_LISP_DIR)/remember-el
$(SITE_LISP_DIR)/remember-el: $(REMEMBER_EL_DIR)
	cd $(REMEMBER_EL_DIR) && make ELISPDIR=$(SITE_LISP_DIR)/remember-el INFODIR=$(INFO_DIR)
	cd $(REMEMBER_EL_DIR) && make ELISPDIR=$(SITE_LISP_DIR)/remember-el INFODIR=$(INFO_DIR) install
$(REMEMBER_EL_DIR):
	git clone git://repo.or.cz/remember-el.git $(REMEMBER_EL_DIR)
uninstall-remember-el:
	rm -rf $(SITE_LISP_DIR)/remember-el
all:: install-remember-el
allclean:: uninstall-remember-el

.PHONY:: install-elscreen uninstall-elscreen
ELSCREEN_VERSION = 1.4.6
install-elscreen: $(SITE_LISP_DIR)/elscreen/elscreen.el
$(SITE_LISP_DIR)/elscreen/elscreen.el: elscreen-$(ELSCREEN_VERSION).tar.gz
	tar xvf elscreen-$(ELSCREEN_VERSION).tar.gz
	mkdir -p $(SITE_LISP_DIR)/elscreen
	cp -p elscreen-$(ELSCREEN_VERSION)/elscreen.el $(SITE_LISP_DIR)/elscreen
	rm -rf elscreen-$(ELSCREEN_VERSION)
elscreen-$(ELSCREEN_VERSION).tar.gz:
	curl -O ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/elscreen-$(ELSCREEN_VERSION).tar.gz
uninstall-elscreen:
	rm -rf $(SITE_LISP_DIR)/elscreen
all:: install-elscreen
allclean:: uninstall-elscreen

.PHONY:: install-elscreen-wl
ELSCREEN_WL_VERSION = 0.8.0
install-elscreen-wl: $(SITE_LISP_DIR)/elscreen/elscreen-wl.el
$(SITE_LISP_DIR)/elscreen/elscreen-wl.el: elscreen-wl-$(ELSCREEN_WL_VERSION).tar.gz
	tar xvf elscreen-wl-$(ELSCREEN_WL_VERSION).tar.gz
	mkdir -p $(SITE_LISP_DIR)/elscreen
	cp -p elscreen-wl-$(ELSCREEN_WL_VERSION)/elscreen-wl.el $(SITE_LISP_DIR)/elscreen
	rm -rf elscreen-wl-$(ELSCREEN_WL_VERSION)
elscreen-wl-$(ELSCREEN_WL_VERSION).tar.gz:
	curl -O ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/elscreen-wl-$(ELSCREEN_WL_VERSION).tar.gz
all:: install-elscreen-wl


echo:
	@echo CURDIR=$(CURDIR)
	@echo HOME=$(HOME)
	@echo OS=$(OS)
	@echo
	@echo DOT_EMACS_D_DIR=$(DOT_EMACS_D_DIR)
	@echo INIT_FILES=$(INIT_FILES)
	@echo SRC_TOP_DIR=$(SRC_TOP_DIR)
	@echo RUBY=$(RUBY)
	@echo EMACS_APP=$(EMACS_APP)
	@echo EMACS=$(EMACS)
	@echo SITE_LISP_DIR=$(SITE_LISP_DIR)
	@echo INFO_DIR=$(INFO_DIR)
	@echo APEL_VERSION=$(APEL_VERSION)
	@echo FLIM_VERSION=$(FLIM_VERSION)
	@echo SEMI_VERSION=$(SEMI_VERSION)
	@echo AUTO_INSTALL_DIR=$(AUTO_INSTALL_DIR)
	@echo SKK_DIR=$(SKK_DIR)
	@echo EMACS_W3M_DIR=$(EMACS_W3M_DIR)
	@echo WL_DIR=$(WL_DIR)
	@echo MHC_DIR=$(MHC_DIR)
	@echo WL_GRAVATAR_EL_DIR=$(WL_GRAVATAR_EL_DIR)
	@echo ORG_MODE_DIR=$(ORG_MODE_DIR)
	@echo REMEMBER_EL_DIR=$(REMEMBER_EL_DIR)
	@echo ELSCREEN_VERSION=$(ELSCREEN_VERSION)
	@echo ELSCREEN_WL_VERSION=$(ELSCREEN_WL_VERSION)
