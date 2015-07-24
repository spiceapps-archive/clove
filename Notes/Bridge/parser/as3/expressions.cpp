Lexer* lexer = new Lexer();


#include "asts.cpp"


AST* get_string_ast<T = Evaluator>(Lexer& lexer, const char * search)
{
	//...self explanatory
}

AST* get_number_ast<T =  NumberEvaluator>(Lexer& lexer)
{

}

AST* get_package_path_ast(Lexer& lexer)
{
	lexer->add_ast(&get_string_ast);
	
	if(!lexer->get_terminal("."))
	{
		return NULL;
	}
	//recursion
	lexer->add_ast(&get_package_path_ast);
}



AST* get_package_ast(Lexer& lexer)
{
	//package OR package com.spice.clove{ }
	Evaluator* e = get_string_ast<>(lexer,search);
	lexer->add_ast(e,&get_package_path); //let the lexer control the add_ast if it's OPTIONAL
	lexer->skip(1,"{");//skip 1, check if it's "{"
	lexer->add_ast(e,)
	lexer->skip(1,"}");//skip 1, check if it's "{". Throw error if it doesn't exist.
	return e;	
}





//the start of it...

Evaluator* e = new Evaluator();
lexer->register_terminal("string",&get_string_terminal);
lexer->get_ast(e,&get_package_ast);
