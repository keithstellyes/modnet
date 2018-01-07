# modnet
A forum written in C++ and Lua, with a Lua-based templating engine Postgres by 
default for DB

# How it works

`page-compiler.py` turns a document with `<lua ?>` into a C header file
where the code in `<lua ?>`. Here's an example using C-style pseudocode:

```html
<html>
  <b> <lua print('Hello, World!') ?> </b>
</html>
```

Then will get turned into something like this:

```c
void do_template(lua_State *L)
{
    printf("<html><b>");
    lua_exec("print('Hello, World!'));
    printf("</b></html>");
}
```

And after running it, you would get this output:

```html
<html>
  <b> Hello, World! </b>
</html>
```
