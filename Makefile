export ROOT ?= $(CURDIR)
export PATH := $(ROOT)/bin:$(PATH)
export DISTRO := $(shell $(ROOT)/bin/detect-distro)
export BIN := $(HOME)/usr/bin
export REPO := $(HOME)/repo

M ?= $(ROOT)/dotfiles.mk

all:
	@$(MAKE) --no-print-directory \
		-C $(shell dirname $(M)) \
		-f $(ROOT)/utils/Makefile.build \
		target-file=$(M)
