module basesql::prettyprint::SolutionModifiers

import basesql::ast::BaseSQL;
import List;

extend basesql::prettyprint::Expressions;

// GroupByClause
public str toString(
  GroupByClause::groupByClause(
    list[ExpAsVar] expAsVars
  )
) = "GROUP BY <intercalate(",", [ toString(expAsVar) | expAsVar <- expAsVars ])>";

// HavingClause
public str toString(HavingClause::havingClause(Expr exp)) = "HAVING <toString(exp)>";

// OrderByClause
public str toString(OrderByClause::orderByClause(list[OrderElem] orderElems)) = "ORDER BY <intercalate(",", [ toString(orderElem) | orderElem <- orderElems ])>";

// OrderElem
public str toString(OrderElem::orderExpr(Expr expr)) = "<toString(expr)>";
public str toString(OrderElem::asc(Expr expr)) = "<toString(expr)> ASC";
public str toString(OrderElem::desc(Expr expr)) = "<toString(expr)> DESC";

// LimitOffsetClauses
public str toString(LimitOffsetClauses::limitOffsetClauses(LimitClause limitCls, list[OffsetClause] offsetCls)) = "<toString(limitCls)> <prettyOptional(offsetCls, toString)>";
public str toString(LimitOffsetClauses::offsetLimitClauses(OffsetClause offsetCls, list[LimitClause] limitCls)) = "<toString(offsetCls)> <prettyOptional(limitCls, toString)>";

// LimitClause
public str toString(LimitClause::limitClause(str \int)) = "LIMIT <\int>";

// OffsetClause
public str toString(OffsetClause::offsetClause(str \int)) = "OFFSET <\int>";