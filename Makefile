LUA_INC := -I /usr/include/luajit-2.0/ 
LUA_LIB := -lluajit-5.1
CC := gcc
CPP := g++

# our template compiler
TMPLTC := python3 page-compiler.py

site: site/index.html

site/index.html: site/index.html.o
	$(CC) $(LUA_INC) $(LUA_LIB) site/index.html.o -o site/index.html

site/index.html.o: site/_index.html site/index.c
	$(TMPLTC) site/_index.html site/index.h
	$(CC) $(LUA_INC) $(LUA_LIB) -c site/index.c -o site/index.html.o
