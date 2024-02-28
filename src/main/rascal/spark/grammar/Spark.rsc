module spark::grammar::Spark


extend spark::grammar::Auxiliary;



start syntax Spark 
  = expression: Expr
  | statements: StatementWithTerminator+
  | simpleStatement: Statement!statementQuery
  ;
    
syntax StatementWithTerminator
  = statementWithTerminator: Statement 
   Terminator+
  ;


syntax Terminator
  = terminator: ";"
  ;
  


