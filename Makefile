export PATH := $(CURDIR)/bin:$(PATH)
export ROOT := $(CURDIR)

.PHONY: all clean

all: configs utils
	make -C vim all
	make C awesome all

clean:
	buildall clean
	make -C vim clean
	make -C clean

.PHONY: configs utils

configs:
	buildall all

utils:
	cd ${HOME} && optional npm install jshint
