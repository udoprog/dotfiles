O=$(CURDIR)/build/optional
B=$(CURDIR)/build/make
M=$(CURDIR)/build/m4tpl

.PHONY: all clean

all: configs utils
	cd vim && make B="$(B)" all
	cd awesome && make B="$(B)" all

clean:
	$(B) clean
	cd vim && make B="$(B)" clean
	cd awesome && make B="$(B)" clean

.PHONY: configs utils

configs:
	$(B) M="$(M)" all

utils:
	cd ${HOME} && $(O) npm install jshint
