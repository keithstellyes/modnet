MD_INC := -I include/
LUA_INC := -I /usr/include/luajit-2.0/ $(MD_INC)
LUA_LIB := -lluajit-5.1
CC := gcc
CPP := g++
PREAMBLE_OBJ := lib/preamble.o

# our template compiler
TMPLTC := python3 page-compiler.py

site: lib/preamble.o site/index.html

site/index.html: site/index.html.o $(PREAMBLE_OBJ)
	$(CC) $(LUA_INC) $(LUA_LIB) $(PREAMBLE_OBJ) site/index.html.o -o site/index.html

site/index.html.o: site/_index.html site/index.c
	$(TMPLTC) site/_index.html site/index.h
	$(CC) $(LUA_INC) $(LUA_LIB) -c site/index.c -o site/index.html.o


$(PREAMBLE_OBJ): lib/preamble-data.h lib/preamble.c
	$(CC) lib/preamble.c -c -o lib/preamble.o

lib/preamble.h: lib/preamble.html
	xxd -i lib/preamble.html > lib/preamble-data.h
