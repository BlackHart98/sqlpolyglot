module spark::LanguageServer



import ParseTree;

import util::Reflective;
import util::LanguageServer;
import spark::grammar::Spark;

import Prelude;




// a minimal implementation of a DSL in rascal
// users can add support for more advanced features
set[LanguageService] sparkContributions() = {
    parser(parser(#start[Spark]))

};



void setupIDE() {
  registerLanguage(
    language(
    pathConfig(srcs = [|std:///|, |project://sqlpolyglot/src/main/rascal|]),
    "Spark SQL", 
    "ssql", 
    "spark::LanguageServer",
    "sparkContributions"
    ));
}