/* Example 2, Simple Calculator Parser */

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h> // for atof()
    #include <string.h> // for semantic check
    #define YYSTYPE char const *//only need string here. Ref: http://stackoverflow.com/questions/8632516/how-to-get-string-value-of-token-in-flex-and-bison
    extern int yylex(); // Declared by lexer
    void yyerror(const char *s); // Declared later in file
    
    /*************Define variables for semantic checking***************/
    char * class_name = NULL; //to locate Class category
    
    /**********Look Up function***********/
    // Look Up if the given string (STATE or method) belongs to the class
    // if the identifier is in the table--LookUp() return i,
    //otherwise return -1-- doesn't match at all
    int LookUp(char *array[], int length, const char* string) {
        int i = 0;
        while(i < length) {
            if(string == NULL || array[i] == NULL)
                return -1;
            else if(strcmp(array[i], string) == 0)  //if the current string match one of the variable names in the table
               return i;
            else
               i++;
        }
        return -1;
    }
    
    /*******************************************build the LookUp table *********************************************/
	char *camera[] = {"rt_RayOrigin", "rt_RayDirection", "rt_InverseRayDirection", "rt_Epsilon", "rt_HitDistance", 
		 	  "rt_ScreenCoord", "rt_LensCoord", "rt_du", "rt_dv", "rt_TimeSeed", "constructor", "generateRay"};    
	// including both STATE and methods in the class, i.e constructor.

	char *texture[] = {"rt_TextureUV", "rt_TextureUVW", "rt_TextureColor", "rt_FloatTextureValue","rt_du", 
	           	   "rt_dv", "rt_dsdu", "rt_dtdu", "rt_dsdv", "rt_dtdv", 
		   	   "rt_dPdu", "rt_dPdv", "rt_TimeSeed", "constructor", "Lookup"};

	char *primitive[] = {"rt_RayOrigin", "rt_RayDirection", "rt_InverseRayDirection", "rt_Epsilon", "rt_HitDistance", 
			     "rt_BoundMin", "rt_BoundMax", "rt_GeometricNormal", "rt_dPdu", "rt_dPdv", 
			     "rt_ShadingNormal", "rt_TextureUV", "rt_TextureUVW", "rt_dsdu", "rt_dsdv", 
			     "rt_PDF", "rt_TimeSeed", "constructor", "intersect", "computeBounds",
	                     "computeNormal", "computeTextureCoordinates", "computeDerivatives", "generateSample", "samplePDF",
			     "rt_HitPoint"};

	char *material[] = {"rt_RayOrigin", "rt_RayDirection", "rt_InverseRayDirection", "rt_HitPoint", "rt_dPdu", 
			    "rt_dPdv", "rt_LightDirection", "rt_LightDistance", "rt_LightColor", "rt_EmissionColor",
        	            "rt_BSDFSeed", "rt_TimeSeed", "rt_PDF", "rt_SampleColor", "rt_BSDFValue", 
			    "rt_du", "rt_dv", "constructor", "shade", "BSDF", 
			    "sampleBSDF", "evaluatePDF", "emission",
		            "rt_ShadingNormal", "rt_HitDistance"};

	char *light[] = {"rt_HitPoint", "rt_GeometricNormal", "rt_ShadingNormal", "rt_LightDirection", "rt_TimeSeed", 
			 "constructor", "illumination"};

	char *methods[] = {"constructor", "generateRay","intersect", "computeBounds", "computeNormal", 
			   "computeTextureCoordinates", "computeDerivatives", "generateSample", "samplePDF", "Lookup", 
			   "illumination", "BSDF", "sampleBSDF", "evaluatePDF", "emission",
			   "shade"};
    
%}



/* declare tokens */
%token PLUS MUL MINUS DIV ASSIGN EQUAL NOT_EQUAL LT LE GT GE COMMA COLON SEMICOLON LPARENTHESIS RPARENTHESIS LBRACKET RBRACKET LBRACE RBRACE AND OR INC DEC UNDERSCORE
%token BOOL
%token FLOAT INT
%token RTCAMERA RTPRIMITIVE RTTEXTURE RTMATERIAL RTLIGHT
%token STATE
%token PUBLIC CLASS IF ELSE RETURN
%token KEYWORD QUALIFIER TYPE
%token IDENTIFIER2// test 5, color is not included in IDENTIFIER
%token SWIZZLE
%token VOID
%token INTNAME FLOATNAME BOOLNAME
%token FOR WHILE DO
%token COLOR // test 5
%%

file: single_file_operation
| file file_reduction
;

single_file_operation: class
;

file_reduction: function | declaration
;

class: CLASS IDENTIFIER COLON RTLIGHT SEMICOLON {class_name = "light"; printf ("SHADER_DEF light\n");}
| CLASS IDENTIFIER COLON RTMATERIAL SEMICOLON {class_name = "material"; printf ("SHADER_DEF material\n");}
| CLASS IDENTIFIER COLON RTCAMERA SEMICOLON {class_name = "camera"; printf ("SHADER_DEF camera\n");}
| CLASS IDENTIFIER COLON RTPRIMITIVE SEMICOLON {class_name = "primitive"; printf ("SHADER_DEF primitive\n");}
| CLASS IDENTIFIER COLON RTTEXTURE SEMICOLON {class_name = "texture"; printf ("SHADER_DEF texture\n");}
;

function:
func_return_values LPARENTHESIS RPARENTHESIS LBRACE RBRACE {printf ("FUNCTION_DEF\n");} //test 6: void shade() {}
|func_return_values LPARENTHESIS values RPARENTHESIS LBRACE in_between_function_list RBRACE {printf ("FUNCTION_DEF\n");}  //test1 void function(int i) { } ,  test2,3, modified for test 5  void fun(int i, int x, int y){}
| func_return_values LPARENTHESIS RPARENTHESIS LBRACE in_between_function_list RBRACE {printf ("FUNCTION_DEF\n");} //int fun() {}
;


IDENTIFIER:
IDENTIFIER2 
{
    /************check if it is a method, if not, do nothing*******************/
    //$$=$0;
    const char *string = $1;
    if(sizeof(string))
    {
      if(class_name == NULL)// not a class in the table, do nothing
          break;
        
      //if found=-1, not a method
      int found = LookUp(methods, sizeof(methods), string);
      
      //found = -1, not a method, do nothing; found = i, it is a method,keep checking.
      int methods_status = (found == -1)? -1 :1;
      
      // not a method, IDENTIFIER2 is not in the table at all, do nothing
      if (methods_status == -1)
         break;
    
    /**************check if the method is under the right class column*********************/
    
      if(methods_status == 1)  // it is a method
      {
        int status = 0; //initialize status as 0;
        if(strcmp(class_name, "camera") == 0)  //check under camera column, current class is camera
             status = LookUp(camera, sizeof(camera)/sizeof(camera[0]), string); // status >= 0, under the class, no error; status = -1, not under directly, keep checking other columns
        else if(strcmp(class_name, "primitive") == 0)
             status = LookUp(primitive, sizeof(primitive)/sizeof(primitive[0]), string);
        else if(strcmp(class_name, "texture") == 0)
            status = LookUp(texture, sizeof(texture)/sizeof(texture[0]), string);
        else if(strcmp(class_name, "material") == 0)
            status = LookUp(material, sizeof(material)/sizeof(material[0]), string);
        else if(strcmp(class_name, "light") == 0)
            status = LookUp(light, sizeof(light)/sizeof(light[0]), string);
            
        if (status >= 0) // the STATE matches the CLASS, do nothing
            break;
           
           /****************locate wrong method below***************/
           
        if(status == -1) // the method is wrongly placed, check which class it belongs to
           {
               char *error_type;
               if(strcmp(class_name, "texture") != 0 && LookUp(texture, sizeof(texture)/sizeof(texture[0]), string) >= 0)
                   error_type = "texture"; // it is under texture

               else if(strcmp(class_name, "camera") != 0 && LookUp(camera, sizeof(camera)/sizeof(camera[0]), string) >= 0)
                   error_type = "camera"; // it is under camera

               else if(strcmp(class_name, "primitive") != 0 && LookUp(primitive, sizeof(primitive)/sizeof(primitive[0]), string) >= 0)
                   error_type = "primitive"; // it is under primitive

               else if(strcmp(class_name, "material") != 0 && LookUp(material, sizeof(material)/sizeof(material[0]), string) >= 0)
                   error_type = "material"; // it is under texture

               else if(strcmp(class_name, "light") != 0 && LookUp(light, sizeof(light)/sizeof(light[0]), string) >= 0)
                  error_type = "light"; // it is under light
     
                 fprintf(stderr, "Error: %s cannot have an interface method of %s\n", class_name, error_type);
           }
     }
   }
}

| COLOR
| KEYWORD  // KEYWORD and COLOR can be used as identifier in functions
| IDENTIFIER UNDERSCORE IDENTIFIER
;

func_return_values: values
| VOID IDENTIFIER
;


values: INTNAME IDENTIFIER
| FLOATNAME IDENTIFIER
| BOOLNAME IDENTIFIER
| TYPE IDENTIFIER
| COLOR IDENTIFIER
| value_list values	// for test 5
;

value_list: COMMA              // for test 5
| values COMMA
;

expression: IDENTIFIER  //test 3
| INT
| FLOAT
| BOOL // test 2
| STATE // a state is definitely in the LookUp table.
{
    const char *string = $1;
    if(class_name == NULL)
       break;	//if no class in the table is used, do nothing
    else{
        int status = 0; //initialize status as 0;
        if(strcmp(class_name, "camera") == 0)  //check under camera column, current class is camera
             status = LookUp(camera, sizeof(camera)/sizeof(camera[0]), string); // status >= 0, under the class, no error; status = -1, not under directly, keep checking other columns
        else if(strcmp(class_name, "primitive") == 0)
             status = LookUp(primitive, sizeof(primitive)/sizeof(primitive[0]), string);
        else if(strcmp(class_name, "texture") == 0)
            status = LookUp(texture, sizeof(texture)/sizeof(texture[0]), string);
        else if(strcmp(class_name, "material") == 0)
            status = LookUp(material, sizeof(material)/sizeof(material[0]), string);
        else if(strcmp(class_name, "light") == 0)
            status = LookUp(light, sizeof(light)/sizeof(light[0]), string);
            
        if (status >= 0) // the STATE matches the CLASS, do nothing
            break;
          
        if(status == -1) // the state is wrongly placed, check which class it belongs to
        {
            char *error_type;
            if(strcmp(class_name, "camera") != 0 && LookUp(camera, sizeof(camera)/sizeof(camera[0]), string) >= 0)
               error_type = "camera"; // it is under camera            
            
            else if(strcmp(class_name, "texture") != 0 && LookUp(texture, sizeof(texture)/sizeof(texture[0]), string) >= 0)
               error_type = "texture"; // it is under texture

            else if(strcmp(class_name, "primitive") != 0 && LookUp(primitive, sizeof(primitive)/sizeof(primitive[0]), string) >= 0)
               error_type = "primitive"; // it is under primitive
            
            else if(strcmp(class_name, "material") != 0 && LookUp(material, sizeof(material)/sizeof(material[0]), string) >= 0)
               error_type = "material"; // it is under texture
            
            else if(strcmp(class_name, "light") != 0 && LookUp(light, sizeof(light)/sizeof(light[0]), string) >= 0)
                error_type = "light"; // it is under light
            
            fprintf(stderr, "Error: %s cannot access to a state of %s\n", class_name, error_type);
        }
    }
}

| IDENTIFIER SWIZZLE IDENTIFIER2
| STATE SWIZZLE IDENTIFIER2
| variable_new_type
| expression LT expression //test 1,4
| expression GT expression
| expression GE expression // test 5
| expression INC //test 4
| MINUS expression //test 5
| expression DIV expression //test 5
| expression MINUS expression
| expression MUL expression
| expression PLUS expression
| expression ASSIGN expression // test 4
| LPARENTHESIS expression RPARENTHESIS //test 5
| function_call
;

variable_new_type: TYPE LPARENTHESIS IDENTIFIER RPARENTHESIS //test 6
;

in_between_function_list: in_between_function
| in_between_function_list in_between_function
;

in_between_function: statement
| declaration
;

/*  declaration   */
declaration: values SEMICOLON {printf ("DECLARATION\n");} // modified for test 5
| PUBLIC values SEMICOLON {printf ("DECLARATION\n");} //test 2
| values ASSIGN expression SEMICOLON {printf ("DECLARATION\n");} //test4
| values ASSIGN STATE SEMICOLON {printf ("DECLARATION\n");} //test 5
;

/*  statement  */
statement: selection_statement {printf ("STATEMENT\n");}
| jump_statement {printf ("STATEMENT\n");}
| iteration_statement {printf ("STATEMENT\n");}
| variable_definition_statement {printf ("STATEMENT\n");}
| compound_statement {printf ("STATEMENT\n");}
;

compound_statement
: LBRACE RBRACE
| LBRACE  block_item_list RBRACE  //test4
;

block_item_list
: block_item
| block_item_list block_item
;

block_item
: declaration
| statement
;

expression_statement: SEMICOLON
| expression SEMICOLON
;

expression_list: COMMA
| expression COMMA
;

selection_statement
: IF LPARENTHESIS expression RPARENTHESIS statement ELSE statement {printf ("IF - ELSE\n");}
| IF LPARENTHESIS expression RPARENTHESIS statement {printf ("IF\n");} // test 5
;

iteration_statement
: WHILE LPARENTHESIS expression RPARENTHESIS statement//test4
| FOR LPARENTHESIS expression_statement expression_statement expression RPARENTHESIS statement// test4
;

jump_statement: RETURN expression_statement
;

variable_definition_statement
: IDENTIFIER ASSIGN expression_statement //test 1,4,5
| STATE ASSIGN expression_statement //test 1
| IDENTIFIER PLUS ASSIGN expression_statement //test 4
| values ASSIGN expression_statement //test 5
;

function_call
: IDENTIFIER LPARENTHESIS expression RPARENTHESIS
| IDENTIFIER LPARENTHESIS expression_list expression RPARENTHESIS //test2,3	5
;



%%

void yyerror(const char *s)
{
    fprintf(stderr, "Parse error: %s\n", s);
    exit(-1);
}



