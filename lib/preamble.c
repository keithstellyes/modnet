#include <stdio.h>

#include "preamble-data.h"

void write_preamble(FILE *file)
{
	fwrite(lib_preamble_html, lib_preamble_html_len, 1, file);
}
