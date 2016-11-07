.PHONY: all clean

all: bundle/Command-T/ruby/command-t/ext.so

clean:

bundle/Command-T/ruby/command-t/ext.so:
	cd bundle/Command-T/ruby/command-t && (ruby extconf.rb && make)
