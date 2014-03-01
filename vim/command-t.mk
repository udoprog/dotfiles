.PHONY: all

all: bundle/command-t/ruby/command-t/ext.so

bundle/command-t/ruby/command-t/ext.so:
	cd bundle/command-t/ruby/command-t && (ruby extconf.rb && make)
