module basesql::grammar::SolutionModifiers

extend basesql::grammar::Expressions;


syntax GroupByClause = groupByClause: 'GROUP' 'BY' {ExpAsVar ","}+;


syntax HavingClause = havingClause: 'HAVING' Expr;


syntax OrderByClause = orderByClause: 'ORDER' 'BY' {OrderElem ","}+;


syntax OrderElem
  = orderExpr: Expr
  | asc: Expr 'ASC'
  | desc: Expr 'DESC'
  ;



syntax LimitOffsetClauses
  = limitOffsetClauses: LimitClause OffsetClause?
  | offsetLimitClauses: OffsetClause LimitClause?
  ;

syntax LimitClause = limitClause: 'LIMIT' Int;

syntax OffsetClause = offsetClause: 'OFFSET' Int;
