module spark::prettyprint::Spark

import spark::ast::Spark;
extend spark::prettyprint::Auxiliary;
extend spark::prettyprint::Query;
extend spark::prettyprint::Functions;
extend spark::prettyprint::Expressions;
extend spark::prettyprint::DDL;
extend spark::prettyprint::DML;
extend basesql::prettyprint::BaseSQL;
import List;



public str toString(Spark s){
    switch(s){
        case expression(Expr e):return toString(e);
        case statements(list[StatementWithTerminator] stmts): {
           return "<intercalate("\n\n",[ "<toString(sts)><intercalate("",[toString(term)|term<-terms])>"| statementWithTerminator(Statement sts,list[Terminator] terms)<-stmts])>";
            
        } 
        default: throw "<s> not found";
    }
}
 
public str toString(terminator())= ";";
