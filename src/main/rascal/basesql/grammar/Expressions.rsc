module basesql::grammar::Expressions

extend basesql::grammar::Names;
extend basesql::grammar::Literals;



syntax ExpAsVarOrStar
  = projectionExpAsVar: ExpAsVar
  | tableNameDotStar: TableName ".*"
  | projectionStar: "*"
  ;

syntax ExpAsVar 
  = expAsVar: Expr VarAssign?
  | namedStructExp: 'NAMED_STRUCT'"(" {NamedStructEntry ","}+")" VarAssign?
  ;

syntax NamedStructEntry 
  = namedStructEntry: QUOTED_IDENTIFIER "," Expr 
  ;


syntax Expr
  = bracket "(" Expr ")"
  | Literal
  > PropRef
  > right uMin: "-" Expr
  > cast: 'CAST' "(" Expr 'AS' DataType ")"
  > left cct: Expr lhs "||" Expr rhs
  > left mul: Expr lhs "*" Expr rhs
  > non-assoc div: Expr lhs "/" Expr rhs
  > non-assoc modulus: Expr lhs "%" Expr rhs
  > left sub: Expr lhs "-" Expr rhs
  > left add: Expr lhs "+" Expr rhs
  > non-assoc eq: Expr lhs "=" Expr rhs
  > non-assoc twoEqual: Expr lhs "==" Expr rhs
  > non-assoc gt: Expr lhs "\>" Expr rhs
  > non-assoc lt: Expr lhs "\<" Expr rhs
  > non-assoc gte: Expr lhs "\>=" Expr rhs
  > non-assoc lte: Expr lhs "\<=" Expr rhs
  > non-assoc nullSafeEqual: Expr lhs "\<=\>" Expr rhs
  > non-assoc neq1: Expr lhs "!=" Expr rhs
  > non-assoc neq2: Expr lhs "\<\>" Expr rhs
  > left like: Expr lhs 'LIKE' Expr rhs
  > left inPredicate: Expr Not? 'IN' ArrayLiteral
  > left between: Expr 'BETWEEN' Expr!and!or 'AND' Expr!and!or
  > right isNull: Expr 'IS' 'NULL'
  > right isNotNull: Expr 'IS' 'NOT' 'NULL' 
  > right not: 'NOT' Expr
  > left and: Expr lhs 'AND' Expr rhs
  > left or: Expr lhs 'OR' Expr rhs
  > simpleCase: 'CASE' Expr WhenClause+ ElseClause? 'END'
  > searchedCase: 'CASE' WhenClause+ ElseClause? 'END'
  > interval: 'INTERVAL' StringConstant Duration
  ;

syntax CommonValueExpr 
  = bracket "(" Expr ")"
  | Literal
  > PropRef
  > uMinCVE: "-" CommonValueExpr
  > castCVE: 'CAST' "(" CommonValueExpr 'AS' DataType ")"
  > left cctCVE: CommonValueExpr clhs "||" CommonValueExpr crhs
  > left mulCVE: CommonValueExpr clhs "*" CommonValueExpr crhs
  > non-assoc divCVE: CommonValueExpr clhs "/" CommonValueExpr crhs
  > non-assoc modulusCVE: CommonValueExpr clhs "%" CommonValueExpr crhs
  > non-assoc subCVE: CommonValueExpr clhs "-" CommonValueExpr crhs
  > left addCVE: CommonValueExpr clhs "+" CommonValueExpr crhs
  ;

// lexical BETWEENAND = 'AND';

syntax Duration
  = year: 'YEAR'
  | month: 'MONTH'
  | day: 'DAY'
  | hour: 'HOUR'
  | minute: 'MINUTE'
  | second: 'SECOND'
  ;

syntax Not = not: 'NOT';

syntax WhenClause = whenClause: 'WHEN' Expr 'THEN' Expr;

syntax ElseClause = elseClause: 'ELSE' Expr;

syntax Literal
  =  Map
  ;



syntax ArrayLiteral
  = Array
  ;

syntax Array
  = array: "(" {Expr ","}+ ")"
  ;

syntax Map
  = mapLit: 'MAP' "(" {MapEntry ","}* ")"
  ;


syntax MapEntry 		
  = mapEntry: Expr "," Expr
  ;


syntax DataType
  = primitiveType: PrimitiveType
  | arrayType: 'ARRAY' "\<" DataType "\>"
  | mapType: 'MAP' "\<" PrimitiveType"," DataType "\>"
  | structType: 'STRUCT' "[" {StructTypeFieldSpec ","}+ "]"
  | unionType: 'UNIONTYPE' "\<" {DataType ","}+ "\>"
  ;

syntax PrimitiveType
	= intType : 'INT'
  | smallIntType: 'SMALLINT'
  | bigIntType: 'BIGINT'
  | tinyIntType: 'TINYINT'
  | booleanType: 'BOOLEAN'
  | floatType: 'FLOAT'
  | doubleType: 'DOUBLE'
  | doubleWithPrecisionType: 'DOUBLE PRECISION'
	| stringType: 'STRING'
  | binaryType: 'BINARY'
  | timestampType: 'TIMESTAMP'
  | decimalType: 'DECIMAL' TwoParameterSpec?
  | dateType: 'DATE'
  | varCharType: 'VARCHAR' SingleParameterSpec?
  | charType: 'CHAR' SingleParameterSpec?
	;

syntax TwoParameterSpec
  = twoParameterSpec: "(" Int "," Int")"
  ;

syntax SingleParameterSpec 
  = singleParameterSpec: "(" Int ")"
  ;

syntax StructTypeFieldSpec 
  = structTypefieldSpec: Identifier ":" DataType
  ;

syntax StarOrExpr 
  = aggExpr: Expr
  | star: "*"
  ;
  
syntax Distinct = aggregateDistinct: 'DISTINCT';






