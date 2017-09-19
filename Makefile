export ROOT ?= $(CURDIR)
export PATH := $(ROOT)/helpers:$(PATH)
export DISTRO := $(shell $(ROOT)/helpers/detect-distro)
export BIN := $(HOME)/usr/bin
export REPO := $(HOME)/repo
export CACHE := $(ROOT)/cache

M ?= $(ROOT)/dotfiles.mk

ifeq ($(DEBUG),yes)
make-opts :=
else
make-opts := -s --no-print-directory
endif

all:
	@$(MAKE) \
		$(make-opts) \
		-C $(shell dirname $(M)) \
		-f $(ROOT)/helpers/Makefile.build \
		target-file=$(M)
