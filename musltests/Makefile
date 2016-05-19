all: lookup lookup_static

lookup: lookup.c
	gcc -std=c99 -Wall --pedantic lookup.c -o lookup

lookup_static: lookup.c
	gcc -std=c99 -Wall --pedantic -static lookup.c -o lookup_static

clean:
	rm -f lookup_static
	rm -f lookup

lddtest: lookup lookup_static
	ldd lookup_static; true
	ldd lookup

