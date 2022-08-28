
CC = gcc
ASM64 = yasm -f elf64 -DYASM -D__x86_64__ -DPIC

CFLAGS = -g -Wall -fno-stack-protector
LD = ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2

PROGS   = libmini.so libmini64.a start.o \
		  write1 alarm1 alarm2 alarm3 \
		  jmp1

all: $(PROGS)

%.o: %.asm
	$(ASM64) $< -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) $<

%: %.c
	$(CC) $(CFLAGS) $< -o $@


libmini64.a: libmini64.asm libmini.c
	$(CC) -c $(CFLAGS) -fPIC -nostdlib libmini.c
	$(ASM64) $< -o libmini64.o
	ar rc libmini64.a libmini64.o libmini.o

libmini.so: libmini64.a
	ld -shared libmini64.o libmini.o -o libmini.so

write1: write1.o start.o
	$(CC) -c $(CFLAGS) -nostdlib -I. -I.. -DUSEMINI write1.c
	ld -m elf_x86_64 --dynamic-linker /lib64/ld-linux-x86-64.so.2 -o $@ $^ -L. -L.. -lmini
	rm write1.o

alarm1: alarm1.o start.o
	$(CC) -c $(CFLAGS) -nostdlib -I. -I.. -DUSEMINI alarm1.c
	$(LD) -o $@ $^ -L. -L.. -lmini
	rm alarm1.o

alarm2: alarm2.o start.o
	$(CC) -c $(CFLAGS) -nostdlib -I. -I.. -DUSEMINI alarm2.c
	$(LD) -o $@ $^ -L. -L.. -lmini
	rm alarm2.o

alarm3: alarm3.o start.o
	$(CC) -c $(CFLAGS) -nostdlib -I. -I.. -DUSEMINI alarm3.c
	$(LD) -o $@ $^ -L. -L.. -lmini
	rm alarm3.o

jmp1: jmp1.o start.o
	$(CC) -c $(CFLAGS) -nostdlib -I. -I.. -DUSEMINI jmp1.c
	$(LD) -o $@ $^ -L. -L.. -lmini
	rm jmp1.o

clean:
	rm -f a.out *.o $(PROGS) 
