all:
	build/make all
	cd vim && make all
	cd awesome && make all

clean:
	build/make clean
	cd vim && make clean
	git submodule foreach git submodule update --init
	git submodule foreach git clean -fdx
	git submodule foreach git reset --hard HEAD
	git clean -ffdx

.PHONY: awesome

awesome:
	cd awesome && make
