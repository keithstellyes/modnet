#include <stdio.h>
#include <iostream>

#include "preamble-data.h"

void write_preamble()
{
	//fwrite(lib_preamble_html, lib_preamble_html_len, 1, file);
	std::cout << lib_preamble_html;
}
