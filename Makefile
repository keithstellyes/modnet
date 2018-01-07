MD_INC := -I include/
LUA_INC := -I /usr/include/luajit-2.0/ $(MD_INC)
LUA_LIB := -lluajit-5.1 -lpqxx
CC := gcc
CPP := g++
PREAMBLE_OBJ := lib/preamble.o

# our template compiler
TMPLTC := python3 page-compiler.py

site: lib/preamble.o site/index.html

site/index.html: site/index.html.o $(PREAMBLE_OBJ)
	$(CPP) $(LUA_INC) $(LUA_LIB) $(PREAMBLE_OBJ) site/index.html.o -o site/index.html

site/index.html.o: site/_index.html site/index.cpp
	$(TMPLTC) site/_index.html site/index.h
	$(CPP) $(LUA_INC) $(LUA_LIB) -c site/index.cpp -o site/index.html.o


$(PREAMBLE_OBJ): lib/preamble-data.h lib/preamble.c
	$(CPP) lib/preamble.c -c -o lib/preamble.o

lib/preamble.h: lib/preamble.html
	xxd -i lib/preamble.html > lib/preamble-data.h
