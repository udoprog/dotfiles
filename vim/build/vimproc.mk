.PHONY: all

DIR=bundle/vimproc.vim
SO=$(DIR)/lib/vimproc_linux64.so

all: $(SO)

clean:
	$(RM) $(SO)

$(SO):
	make -C $(DIR)
