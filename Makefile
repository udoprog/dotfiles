export ROOT ?= $(CURDIR)
export PATH := $(ROOT)/bin:$(PATH)
export DISTRO := $(shell $(ROOT)/bin/detect-distro)
export BIN := $(HOME)/usr/bin
export REPO := $(HOME)/repo

all:
	@$(MAKE) --no-print-directory \
		-f $(ROOT)/utils/Makefile.build \
		target-file=$(ROOT)/dotfiles.mk
