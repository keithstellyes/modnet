#include "common/string.hpp"

#include <string.h>
#include <iostream>

bool starts_with(const char *pre, const char *s)
{
    size_t prelen = strlen(pre);
    size_t slen = strlen(s);

    return prelen <= slen && strncmp(pre, s, strlen(pre)) == 0;
}

// Should only be used by html_escape, heuristically tries to get
// the max length for html_escape, shouldn't be used by anything else.
// The worst-case space for html_escape is length * 5 (for " => &quot)
inline size_t html_escape_bufflen(size_t length)
{
    // / 2 can be done pretty fast via bit shifting
    return length + length / 2;
}

std::string html_escape(char *s, size_t length)
{
    std::string out;
    out.resize(html_escape_bufflen(length));

    for(unsigned int i = 0; i < length; i++) {
        char c = s[i];

        switch(c) {
	    case '"':
		    out.append("&quot");
		    break;
            case '&':
		    out.append("&amp");
		    break;
            case '<':
		    out.append("&lt");
		    break;
            case '>':
                    out.append("&gt");
		    break;
            default:
		    out.push_back(c);
		    break;
        }
    }

    return out;
}
