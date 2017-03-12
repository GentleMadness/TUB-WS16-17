/* A simple scanner for a toy Pascal-like language. */
%option noyywrap
%{
#include <math.h> // for atof() 
int num_lines = 1;
%}
    
DIGIT    [0-9]
ID       [_a-zA-Z][a-zA-Z_0-9]*
HEX      [A-Fa-f]+

%%  
[\n]      ++num_lines;

"+" printf( "PLUS\n");

"*" printf( "MUL\n");

"-" printf( "MINUS\n");

"/" printf( "DIV\n");

"=" printf( "ASSIGN\n");

"==" printf( "EQUAL\n");

"!=" printf( "NOT_EQUAL\n");

"<" printf( "LT\n");

"<=" printf( "LE\n");

">" printf( "GT\n");

">=" printf( "GE\n");

"," printf( "COMMA\n");

":" printf( "COLON\n");

";" printf( "SEMICOLON\n");

"(" printf( "LPARENTHESIS\n");

")" printf( "RPARENTHESIS\n");

"[" printf( "LBRACKET\n");

"]" printf( "RBRACKET\n");

"{" printf( "LBRACE\n");

"}" printf( "RBRACE\n");

"&&" printf( "AND\n");

"||" printf( "OR\n");

"++" printf( "INC\n");

"--" printf( "DEC\n");

true|false	printf( "BOOL %s\n", yytext );

{DIGIT}+"."{DIGIT}*("e"|"E"){DIGIT}+(("lf"|"LF")?|("f"|"F")?)	 { printf( "FLOAT %s\n", yytext);}

{DIGIT}+"."{DIGIT}*(("lf"|"LF")?|("f"|"F")?)	{ printf( "FLOAT %s\n", yytext); } 

"."{DIGIT}+(("lf"|"LF")?|("f"|"F")?)	{ printf( "FLOAT %s\n", yytext); } 


{DIGIT}+("e"|"E")("-"|"+")?{DIGIT}+(("lf"|"LF")?|("f"|"F")?)	 { printf( "FLOAT %s\n", yytext);}

{DIGIT}*"."{DIGIT}+("e"|"E")("-"|"+")*{DIGIT}+(("lf"|"LF")?|("f"|"F")?)	 { printf( "FLOAT %s\n", yytext);}

"0x"({DIGIT}|{HEX})+([u|U])? 	{ printf( "INT %s\n", yytext ); } // Hexadecimal number, suffix u or U
"0X"({DIGIT}|{HEX})+([u|U])? 	{ printf( "INT %s\n", yytext ); } // Hexadecimal number, suffix u or U
"0"+[0-7]+([u|U])?	{ printf( "INT %s\n", yytext); } // Octal number
{DIGIT}+([u|U])?	{ printf( "INT %s \n", yytext ); } //Decimal number, suffix u or U

rt_RayOrigin|rt_RayDirection|rt_InverseRayDirection|rt_Epsilon|rt_HitDistance|rt_ScreenCoord|rt_LensCoord|rt_du|rt_dv|rt_TimeSeed|rt_BoundMin|rt_BoundMax|rt_GeometricNormal|rt_dPdu|rt_dPdv|rt_ShadingNormal|rt_TextuteUV|rt_TextureUVW|rt_dsdu|rt_dsdv|rt_PDF|rt_TextureUV|rt_TextureUVW|rt_TextureColor|rt_FloatTextureValue|rt_dtdu|rt_dtdv|rt_HitPoint|rt_LightDirection|rt_LightDistance|rt_LightColor|rt_EmissionColor|rt_BSDFSeed|rt_SampleColor|rt_BSDFValue|rt_du|rt_dv|rt_GeometricNormal|rt_ShadingNormal	printf( "STATE %s\n", yytext );    
    
class|const|break|case|continue|default|do|double|else|enum|extern|for|goto|if|sizeof|static|struct|switsch|typedef|union|unsigned|while|illuminance|ambient|dominantAxis|dot|hit|inside|inverse|luminance|max|min|normalize|perpendicularTO|pow|rand|reflect|sqrt|trace { printf( "KEYWORD %s\n", yytext ); }

attribute|uniform|varying|const|public|private|scratch	printf( "QUALIFIER %s\n", yytext );

int|float|bool|void|vec2|vec3|vec4|ivec2|ivec3|ivec4|bvec2|bvec3|bvec4|rt_Primitive|rt_Camera|rt_Material|rt_Texture|rt_Light	printf( "TYPE %s\n", yytext ); 

{ID}	printf( "IDENTIFIER %s\n", yytext );     

"."{ID}   printf( "SWIZZLE %s\n", yytext+1 );

"/*"        {                                             //reference: http://web.mit.edu/gnu/doc/html/flex_2.html
            register int c;
            for ( ; ; )
                {
                while ( (c = input()) != '*' &&c != EOF )
		     if (c == '\n') ++num_lines;  /* eat up text of comment */

		while ( c == '*' && (c =input()) != '/'&& c != EOF)
		     if (c == '\n') ++num_lines;
		if ( c == '/' )
                break; /* found the end */

                if ( c == EOF )
                    {
                     printf( "ERROR(%d): EOF in comment",++num_lines);
                    break;
                    }
                }
            }


[ \t]+	/* eat up itespace */

 "//"[^\n]*  /* 1 line comment */
     
.	printf( "ERROR(%d): Unrecognized symbol \"%s\"\n", num_lines, yytext ); // Error report, num_lines should start from 1.


     
%%
     
int main( int argc, char **argv )
{
  // we assume that the input file is given as input as first argument
  ++argv, --argc;   
  num_lines = 1; // To keep track of the current line number, num_lines starts with 1.
  if ( argc > 0 )
    yyin = fopen( argv[0], "r" );
  else
    yyin = stdin;
  yylex();
 //   printf( "# of lines = %d\n", num_lines);
  return 0;
}
