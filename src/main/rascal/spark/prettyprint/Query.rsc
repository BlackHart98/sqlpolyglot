module spark::prettyprint::Query

import List;
import String;
import spark::ast::Spark;
import spark::prettyprint::Functions;
import spark::prettyprint::Expressions;
import basesql::prettyprint::BaseSQL;


public str toString(
    queryWithLateralView(
        SelectClause selectCls
        , list[FromClause] fromCls
        , list[Distributed] distcls
        , list[SortedByClause] sbcls
        , list[PivotUnpivot] pivotUnpivot
        , list[LateralView] latView
        , list[JoinClause] joinCls
        , list[WhereClause] whereCls
        , list[GroupByClause] groupCls 
        , list[HavingClause] havingCls 
        , list[WindowClause] windowCls 
        , list[OrderByClause] orderByCls 
        , list[LimitOffsetClauses] limitOffsetCls
        , list[QueryClusterByClause] queryClusterByCls
    )
) = "<toString(selectCls)>\n" + 
    trim("<prettyOptional(fromCls, toString, sep="\n")>" + 
            "<prettyOptional(distcls, toString, sep="\n")>" +
            "<prettyOptional(sbcls, toString, sep="\n")>" + 
            "<prettyOptional(pivotUnpivot, toString, sep="\n")>" + 
            "<prettyOptional(latView, toString, sep="\n")>" +
            "<prettyOptional(joinCls, toString, sep="\n")>" + 
            "<prettyOptional(whereCls, toString, sep="\n")>" + 
            "<prettyOptional(groupCls, toString, sep="\n")>"+ 
            "<prettyOptional(havingCls, toString, sep="\n")>" + 
            "<prettyOptional(orderByCls, toString, sep="\n")>" + 
            "<prettyOptional(windowCls, toString, sep="\n")>" + 
            "<prettyOptional(limitOffsetCls, toString, sep="\n")>" + 
            "<prettyOptional(queryClusterByCls, toString, sep="\n")>"
        );



public str toString(
    queryWithDistributed(
        SelectClause selectCls
        , list[FromClause] fromCls
        , Distributed distcls
        , list[SortedByClause] sbcls
        , list[PivotUnpivot] pivotUnpivot
        , list[JoinClause] joinCls
        , list[WhereClause] whereCls
        , list[GroupByClause] groupCls 
        , list[HavingClause] havingCls 
        , list[WindowClause] windowCls 
        , list[OrderByClause] orderByCls 
        , list[LimitOffsetClauses] limitOffsetCls
        , list[QueryClusterByClause] queryClusterByCls
    )
) = "<toString(selectCls)>\n" + 
    trim("<prettyOptional(fromCls, toString, sep="\n")>" + 
            "<toString(distcls)>" + 
            "<prettyOptional(sbcls, toString, sep="\n")>" + 
            "<prettyOptional(pivotUnpivot, toString, sep="\n")>" + 
            "<prettyOptional(joinCls, toString)>" + 
            "<prettyOptional(whereCls, toString, sep="\n")>" + 
            "<prettyOptional(groupCls, toString, sep="\n")>" + 
            "<prettyOptional(whereCls, toString, sep="\n")>" + 
            "<prettyOptional(groupCls, toString, sep="\n")>" + 
            "<prettyOptional(havingCls, toString, sep="\n")>" + 
            "<prettyOptional(orderByCls, toString, sep="\n")>" + 
            "<prettyOptional(windowCls, toString, sep="\n")>" + 
            "<prettyOptional(limitOffsetCls, toString, sep="\n")>" + 
            "<prettyOptional(queryClusterByCls, toString, sep="\n")>"
        );



// LateralView
public str toString(LateralView::lateralView(
    list[Outer] outerOpt    
    , FunctionCall func
    , Identifier id1
    , list[Identifier] ids
  )
) = "LATERAL VIEW <prettyOptional(outerOpt, prettyOuter)> <toString(func)> <toString(id1)> AS <intercalate(",", [ toString(id) | id <- ids ])>";

