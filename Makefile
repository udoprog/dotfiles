B=$(CURDIR)/build/make
M=$(CURDIR)/build/m4tpl

.PHONY: all clean

all:
	$(B) M="$(M)" all
	cd vim && make B="$(B)" all
	cd awesome && make B="$(B)" all

clean:
	$(B) clean
	cd vim && make B="$(B)" clean
	cd awesome && make B="$(B)" all
	git submodule foreach git submodule update --init
	git submodule foreach git clean -fdx
	git submodule foreach git reset --hard HEAD
	git clean -ffdx
