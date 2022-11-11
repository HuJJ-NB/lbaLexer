/*
 * labLexer-2.lex : Scanner for a simple
 *									relop parser.
 */

%{
#include <stdio.h>
int len = 0;
%}

%%

>=|<=|<> {
  printf("(relop,%s)", yytext + yyleng - 2);
}
[<=>] {
  printf("(relop,%s)", yytext + yyleng - 1);
}
[^<=>\n]+/[<=>] {
  printf("(other,%d)", (int)yyleng);
}
[^<=>\n]*[^<=>\r\n]/\n {
  printf("(other,%d)", (int)yyleng);
	return 0;
}
[^<=>\n]+/\r\n {
  printf("(other,%d)", (int)yyleng);
	return 0;
}
. {
  printf("(err,%s)", yytext);
	return 1;
}

%%

int yywrap() {
	return 1;
}
