B=$(CURDIR)/build/make
M=$(CURDIR)/build/m4tpl
VIMINIT=$(CURDIR)/vimrc.mini

.PHONY: all clean

all:
	$(B) M="$(M)" all
	cd vim && make B="$(B)" all
	cd awesome && make B="$(B)" all

clean:
	$(B) clean
	cd vim && make B="$(B)" clean
	cd awesome && make B="$(B)" clean
