module spark::grammar::Query

extend spark::grammar::Functions;


syntax Query
    = queryWithLateralView: 
        SelectClause  
        FromClause? 
        Distributed? 
        SortedByClause? 
        PivotUnpivot? 
        LateralView+ 
        JoinClause* 
        WhereClause? 
        GroupByClause? 
        HavingClause?  
        WindowClause? 
        OrderByClause? 
        LimitOffsetClauses? 
        QueryClusterByClause?
    | queryWithDistributed: 
        SelectClause  
        FromClause? 
        Distributed
        SortedByClause? 
        PivotUnpivot? 
        JoinClause* 
        WhereClause? 
        GroupByClause? 
        HavingClause?  
        WindowClause? 
        OrderByClause? 
        LimitOffsetClauses? 
        QueryClusterByClause?
    ;


syntax PivotUnpivot = 
    pivot: 'PIVOT' "(" {(AggregateFunction PivotAlias?) ","}+ 'FOR' ColList 'IN' "(" {(ExpressionList PivotAlias?) ","}+ ")" ")"
                    | unpivot: 'UNPIVOT' (IncludeorEx 'NULLS')? "(" ValueColumnUnpivot 
")" PivotAlias?;


syntax PivotAlias = 'AS' Identifier;

syntax LateralView
    = lateralView: 'LATERAL' 'VIEW' Outer? FunctionCall Identifier 'AS' {Identifier ","}+
    ;

syntax ValueColumnUnpivot
    = valueColumnUnpivot: ColList 'For' Identifier name 'IN' "("{(ExpressionList PivotAlias?) ","}+")";


syntax ExpressionList 
    = single: SingleExpression
    | multiple:"("{Expr ","}+ ")" 
    ;

syntax SingleExpression 
    = Literal 
    | Identifier
    ;


syntax ColList 
    = single:Identifier
    | multiple:"("{Identifier ","}+ ")" 
    ;


syntax IncludeorEx 
    = include:'INCLUDE'
    | exclude:'EXCLUDE'
    ;
