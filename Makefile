MD_INC := -I include/
LUA_INC := -I /usr/include/luajit-2.0/ $(MD_INC)
LUA_LIB := -lluajit-5.1 -lpqxx
CC := gcc
CPP := g++ -O2 -Wall
PREAMBLE_OBJ := lib/preamble.o

# our template compiler
TMPLTC := python3 page-compiler.py

site: site/main

site/index.html.o: site/_index.html site/index.cpp $(PREAMBLE_OBJ)
	$(TMPLTC) site/_index.html site/index-html.h
	$(CPP) $(LUA_INC) $(LUA_LIB) $(PREAMBLE_OBJ) site/index.cpp -c -o \
		site/index.html.o

site/main.o: site/index.html.o site/main.cpp
	$(CPP) $(LUA_INC) $(MD_INC) site/main.cpp -c -o site/main.o 

site/main: site/main.o lib/common/string.o
	$(CPP) $(LUA_INC) $(LUA_LIB) $(PREAMBLE_OBJ) \
		site/index.html.o lib/common/string.o\
		-lfcgi -lfcgi++ site/main.o -o site/main

$(PREAMBLE_OBJ): lib/preamble-data.h lib/preamble.cpp
	$(CPP) lib/preamble.cpp -c lib/preamble.o

lib/common/string.o: include/common/string.hpp
	$(CPP) $(MD_INC) lib/common/string.cpp -c -o lib/common/string.o

lib/preamble.h: lib/preamble.html
	xxd -i lib/preamble.html > lib/preamble-data.h
