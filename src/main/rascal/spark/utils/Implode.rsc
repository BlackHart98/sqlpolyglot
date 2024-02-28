module spark::utils::Implode


import spark::grammar::Spark;
import spark::ast::Spark;
import ParseTree;


public Spark loadSpark(loc file)=implode(#Spark, parse(#start[Spark], file));


public Spark loadSpark(str input)=implode(#Spark, parse(#start[Spark], input));