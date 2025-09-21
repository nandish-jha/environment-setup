# NANDISH JHA NAJ474 11282001

CC = gcc
CFLAGS = -Wall -pedantic -std=gnu90 -g
CPPFLAGS = -I.

O_FILES = sortMain.o qsort.o swap.o input-routines.o \
intComp.o doubleComp.o complexComp.o

.PHONY: all clean

all: myQsort

myQsort: $(O_FILES)
	$(CC) $(CFLAGS) -o myQsort $(O_FILES) -lm

sortMain.o: sortMain.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c sortMain.c -o sortMain.o

qsort.o: qsort.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c qsort.c -o qsort.o

swap.o: swap.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c swap.c -o swap.o

input-routines.o: input-routines.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c input-routines.c -o input-routines.o

intComp.o: intComp.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c intComp.c -o intComp.o

doubleComp.o: doubleComp.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c doubleComp.c -o doubleComp.o

complexComp.o: complexComp.c qsort.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c complexComp.c -o complexComp.o

clean:
	clear
	rm -f myQsort *.o
