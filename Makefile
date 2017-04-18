export PATH := $(CURDIR)/bin:$(PATH)
export ROOT := $(CURDIR)
export G=$(CURDIR)/gen

.PHONY: all clean

all: configs utils puppet
	make -C vim all

clean:
	buildall clean
	make -C vim clean

.PHONY: configs utils puppet

configs:
	buildall all

utils:
	cd ${HOME} && optional npm install jshint

puppet:
	bin/puppet
