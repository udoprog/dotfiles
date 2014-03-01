.PHONY: all

all: bundle/Command-T/ruby/command-t/ext.so

bundle/Command-T/ruby/command-t/ext.so:
	cd bundle/Command-T/ruby/command-t && (ruby extconf.rb && make)
