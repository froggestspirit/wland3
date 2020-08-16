.PHONY: all compare

objects := main.o

all: wl3.gbc compare
compare: baserom.gbc wl3.gbc
	cmp $^

%.o: %.asm
	rgbasm -o $@ $<

wl3.gbc: $(objects)
	rgblink -p 0xFF -o $@ $^
	rgbfix -p 0xFF -v $@