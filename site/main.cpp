#include <iostream>
#include <cstring>

#include "fcgio.h"
#include "common/string.hpp"
#include "index.h"

using namespace std;

int main(int argc, char **argv) {
    // Backup the stdio streambufs
    streambuf *cin_streambuf  = cin.rdbuf();
    streambuf *cout_streambuf = cout.rdbuf();
    streambuf *cerr_streambuf = cerr.rdbuf();

    FCGX_Request request;

    FCGX_Init();
    FCGX_InitRequest(&request, 0, 0);

#ifndef SYNC_WITH_STDIO
#define SYNC_WITH_STDIO 0
#endif

#if SYNC_WITH_STDIO == 0
#endif

    while (FCGX_Accept_r(&request) == 0) {
        fcgi_streambuf cin_fcgi_streambuf(request.in);
        fcgi_streambuf cout_fcgi_streambuf(request.out);
        fcgi_streambuf cerr_fcgi_streambuf(request.err);

        cin.rdbuf(&cin_fcgi_streambuf);
        cout.rdbuf(&cout_fcgi_streambuf);
        cerr.rdbuf(&cerr_fcgi_streambuf);

        cout << "Content-type: text/html\r\n\r\n";

	if(!strcmp("/", FCGX_GetParam("DOCUMENT_URI", request.envp))) {
	    do_index();
	} else if(starts_with("/boards", 
                (const char*)FCGX_GetParam("DOCUMENT_URI", request.envp))) {
	    cout << FCGX_GetParam("DOCUMENT_URI", request.envp);
	}
	std::cout << "\n";
    }
    // restore stdio streambufs
    cin.rdbuf(cin_streambuf);
    cout.rdbuf(cout_streambuf);
    cerr.rdbuf(cerr_streambuf);

    return 0;
}
