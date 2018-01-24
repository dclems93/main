CC = gcc
CFLAGS = -g
LDFLAGS = -g

mywc: mywc.o
	$(CC) $(LDFLAGS) -o mywc mywc.o

mywc.o: mywc.c
	$(CC) $(CFLAGS) -c mywc.c

poly: poly.o dump.o
	$(CC) $(LDFLAGS) -o poly poly.o dump.o

poly.o: poly.c
	$(CC) $(CFLAGS) -c poly.c

dump.o: dump.c
	$(CC) $(CFLAGS) -c dump.c
