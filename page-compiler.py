import re, sys

# argv[1] => source html
# argv[2] => output

def hexify_str(s):
    return ', '.join([hex(ord(c)) for c in s] + ['0x0'])

def write_print(s, f):
    global indent, data_ctr
    f.write(indent + 'char htmldata{}[] = '.format(data_ctr))
    f.write('{' + hexify_str(s) + '};\n')
    #f.write(indent + 'fprintf(file, "%s", htmldata{});\n'.format(data_ctr))
    f.write(indent + 'std::cout << (char*) htmldata{};\n'.format(data_ctr))
    data_ctr += 1

def write_lua(s, f):
    global indent, data_ctr
    f.write(indent + 'char luadata{}[] = '.format(data_ctr))
    f.write('{' + hexify_str(s) + '};\n')
    f.write(indent + 'errcode = luaL_loadbuffer(l, {}, {}, "");\n'.format(
                                    'luadata{}'.format(data_ctr), len(s)))
    f.write(indent + 'lua_pcall(l, 0, 0, 0);\n')


source = None
with open(sys.argv[1], 'r') as source_html_file:
    source = source_html_file.read()

preamble = '''#ifndef COMPILED_PAGE
#define COMPILED_PAGE
void write(lua_State *l)
{
    int errcode;
'''

global indent
global data_ctr
indent = ' ' * 4
data_ctr = 0

with open(sys.argv[2], 'w') as out_file:
    out_file.write(preamble)
    lua_pattern = '\<lua'
    comment1 = '\-\-.*\n'
    comment2 = '\-\-\[\[(.|\n)*\-\-\]\]'
    slit1 = '\'([^\\\']|\\.)*\''
    slit2 = '\"(^\\\"]|\\.)*\"'
    lua_pattern += '(({})|({})|({})|({})|.)*?'.format(comment1, comment2,
                                             slit1, slit2)
    lua_pattern += '\?\>'
    compiled = re.compile(lua_pattern, re.DOTALL)
    #print(lua_pattern)
    while source != '':
        # 3 cases:
        #     next is <lua
        #     next is not <lua, but there is still a <lua
        #     no <lua
        match = compiled.search(source)
        if match:
            #print(source[match.start():match.end()].lstrip('<lua').rstrip('?>'))
            if match.start() == 0: #<lua is next
                write_lua(source[:match.end()].lstrip('<lua')
                                        .rstrip('?>'), out_file)
            else: #<lua a bit later
                write_print(source[:match.start()], out_file)
                write_lua(source[match.start():match.end()].lstrip('<lua').
                                                    rstrip('?>'), out_file)
            if match.end() >= len(source):
                break
            source = source[match.end():]
        else:
            write_print(source, out_file)
            break
    out_file.write('}\n#endif /* COMPILED */')
