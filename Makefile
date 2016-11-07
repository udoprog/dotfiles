export PATH := $(CURDIR)/bin:$(PATH)
export ROOT := $(CURDIR)
export G=$(CURDIR)/gen

.PHONY: all clean

all: configs utils
	make -C vim all

clean:
	buildall clean
	make -C vim clean

.PHONY: configs utils

configs:
	buildall all

utils:
	cd ${HOME} && optional npm install jshint
