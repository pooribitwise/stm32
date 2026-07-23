# for apt package management use gcc-arm-none-eabi
CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

TARGET=main

SRCDIRS = . src
INCDIR = inc

INCDIRS=-I. -I./$(INCDIR)
OPT=-Os

CFLAGS=-mthumb -mcpu=cortex-m3 -DSTM32F103x6 -Wall -Wextra $(INCDIRS) $(OPT)

CFILES=$(foreach dir,$(SRCDIRS),$(wildcard $(dir)/*.c))
OBJECTS=$(CFILES:.c=.o)

ELF=$(TARGET).elf
BINARY=$(TARGET).bin

all: $(BINARY)

$(BINARY): $(ELF)
	$(OBJCOPY) -O binary $< $@

$(ELF): $(OBJECTS)
	$(CC) -nostdlib -T linker.ld -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(BINARY) $(ELF) $(OBJECTS)

flash:
	st-flash --reset write $(BINARY) 0x08000000

erase:
	st-flash --reset erase
