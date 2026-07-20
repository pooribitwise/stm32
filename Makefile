# for apt package management use gcc-arm-none-eabi
CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy

INCDIRS=-I. ./inc
OPT=-Os
CFLAGS=-mthumb -mcpu=cortex-m3 -DSTM32F103x6 -Wall -Wextra $(INCDIRS) $(OPT)

OBJECTS=main.o startup.o
CFILES=main.c startup.c

ELF=blink.elf
BINARY=blink.bin

all: $(BINARY)

$(BINARY): $(ELF)
	$(OBJCOPY) -O binary $^ $@

$(ELF): $(OBJECTS)
	$(CC) -nostdlib -T linker.ld -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

clean:
	rm -f $(BINARY) $(ELF) $(OBJECTS)
