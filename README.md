# NOTE

I've decided to cancel this, as this project was an experiment in how C++ and 
Lua might perform as a web stack. Unfortunately, from my benchmarking, in 
order for this to have acceptable performance, one would have to implement
generated template caching. Unfortunately, that's a too much of a time-sink.

Facebook has a C++ web thing that might be good. Go is supposed to be
moderately low-level, also Rust. Perhaps one of those would work out better.

However, the template engine might be interesting to further projects, so
I've left this code as-is.

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
