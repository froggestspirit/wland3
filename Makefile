rom := wl3.gbc

objects := main.o

### Build targets

.PHONY: all clean compare

all: $(rom) compare

clean:
	rm -f $(rom) $(objects)

compare: $(rom)
	md5sum -c rom.md5

%.o: %.asm
	rgbasm -o $@ $<

wl3.gbc: $(objects)
	rgblink -p 0xFF -o $@ $^
	rgbfix -p 0xFF -v $@
