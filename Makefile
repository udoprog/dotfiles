all:
	cd vim && make all
	cd awesome && make all
	make -f configs.mk all
	make -f powerline.mk all

clean:
	cd vim && make clean
	git submodule foreach git submodule update --init
	git submodule foreach git clean -fdx
	git submodule foreach git reset --hard HEAD

.PHONY: awesome

awesome:
	cd awesome && make
