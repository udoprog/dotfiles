export ROOT ?= $(CURDIR)
export PATH := $(ROOT)/helpers:$(PATH)
export DISTRO := $(shell $(ROOT)/helpers/detect-distro)
export BIN := $(HOME)/usr/bin
export REPO := $(HOME)/repo

M ?= $(ROOT)/dotfiles.mk

all:
	@$(MAKE) --no-print-directory \
		-C $(shell dirname $(M)) \
		-f $(ROOT)/helpers/Makefile.build \
		target-file=$(M)
