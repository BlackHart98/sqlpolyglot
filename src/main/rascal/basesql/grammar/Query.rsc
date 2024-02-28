module basesql::grammar::Query

extend basesql::grammar::Functions;




// This commented line introduces ambiguity to the language, this was one of the unsolved HQL spoofax bug
// Todo- resolved this bug


syntax Query
  = query:
        SelectClause FromClause? JoinClause? WhereClause? GroupByClause? HavingClause?
        OrderByClause? WindowClause? LimitOffsetClauses? QueryClusterByClause?
  | bracket "(" Query ")"
  | left  union: Query 'UNION' SetQuantifier? Query
  > left intersect: Query 'INTERSECT' Query	
  ;

syntax Local = local: 'LOCAL';

syntax DirectoryPath 
  = referenceOnly: "\'""${" REGULARIDENTIFIER "}""\'"
  | directoryReference: "\'""${" REGULARIDENTIFIER "}""/"Identifier"\'"
  | directoryPath: "\'""/"{Identifier "/"}+"\'"
  ;




syntax SetQuantifier
  = \all: 'ALL'
  | distinct: 'DISTINCT'
  ;


syntax SelectClause
  = selectClause: 'SELECT' SetQuantifier? Projection
  ;

syntax Projection = expAsVars: {ExpAsVarOrStar ","}+;




syntax RecordReaderClause = recordReaderClause: 'RECORDREADER' StringConstant;

syntax FromClause =  fromClause: 'FROM' {TableIdOrSubquery ","}+;

syntax TableIdOrSubquery
  = tableId: TableName Identifier?
  | tableIdOrSubquerySubquery: "(" Query ")" Identifier 
  ;




syntax JoinClause
  = innerJoinClause: Inner? 'JOIN' TableIdOrSubquery JoinCondition? JoinClause? 
  | outerJoinClause: OuterType Outer? 'JOIN' TableIdOrSubquery JoinCondition JoinClause? 
  | leftSemiJoinClause: LeftSemiJoin TableIdOrSubquery JoinCondition JoinClause?
  | crossJoinClause: CrossJoin TableIdOrSubquery JoinCondition? JoinClause?
  ;


syntax Inner  = inner: 'INNER';

syntax Outer = outer: 'OUTER';

syntax JoinCondition = joinCondition: 'ON' Expr;

syntax OuterType
  = left: 'LEFT'
  | right: 'RIGHT'
  | full: 'FULL'
  ;

syntax LeftSemiJoin = leftSemiJoin:'LEFT' 'SEMI' 'JOIN';

syntax CrossJoin = crossJoin: 'CROSS' 'JOIN';

syntax WhereClause = whereClause: 'WHERE' Expr;


syntax QueryClusterByClause = insertWithClusterByClause: 'CLUSTER' 'BY' {Identifier ","}+;

syntax WithClause = withClause: 'WITH';

syntax CTEClause = cteClause: Identifier 'AS' "(" Query ")";


syntax CTEAction
  = selectAction: Query
  | fromAction: 
        'FROM' TableName
        SelectClause
  | cteActionInsertWithSelect: 
        'FROM' TableName  'INSERT' OverWriteOrInto TableName PartitionWithOptionValueClause? 
        SelectClause
  | cteActionInsertWithQuery: 
        'INSERT' OverWriteOrInto TableName PartitionWithOptionValueClause?
        ColumnSpecificationForInsert? 
        Query
  ; 

syntax OverWriteOrInto
  = overWriteOrIntoOverwrite: 'OVERWRITE' Table?
  | overWriteOrIntoInto: 'INTO' Table?
  ;

syntax ColumnSpecificationForInsert = columnSpecificationForInsert: "("{Identifier ","}+ ")";

syntax InsertWithQuery
  = overwrite: 
        'INSERT' 'OVERWRITE' Table? TableName PartitionWithOptionValueClause? IfNotExists? 
  		ColumnSpecificationForInsert?
  		Query
  | into:
        'INSERT' 'INTO' Table? TableName PartitionWithOptionValueClause?
  	    ColumnSpecificationForInsert?
  	    Query   
  ; 


syntax Expr = QueryExpr;

syntax QueryExpr
  = scalarSubquery: Subquery
  | exists: 'EXISTS' Subquery
  > non-assoc inSubquery: Expr Not? 'IN' Subquery
  ;

syntax Subquery = subquery: "(" Query ")";