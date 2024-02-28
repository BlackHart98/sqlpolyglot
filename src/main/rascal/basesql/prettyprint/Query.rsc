module basesql::prettyprint::Query

import basesql::ast::BaseSQL;
import List;
import String;

extend basesql::prettyprint::Functions;



// Query
public str toString(
  Query::query(
    SelectClause selectCls
    , list[FromClause] fromCls
    , list[JoinClause] joinCls
    , list[WhereClause] whereCls
    , list[GroupByClause] groupCls 
    , list[HavingClause] havingCls 
    , list[OrderByClause] orderByCls 
    , list[WindowClause] windowCls 
    , list[LimitOffsetClauses] limitOffsetCls
    , list[QueryClusterByClause] queryClusterByCls
  )
) = "<toString(selectCls)>\n" + 
    trim("<prettyOptional(fromCls, toString, sep="\n")>" + 
         "<prettyOptional(joinCls, toString)>" + 
         "<prettyOptional(whereCls, toString, sep="\n")>" + 
         "<prettyOptional(groupCls, toString, sep="\n")>"+ 
         "<prettyOptional(havingCls, toString, sep="\n")>" + 
         "<prettyOptional(orderByCls, toString, sep="\n")>" + 
         "<prettyOptional(windowCls, toString, sep="\n")>" + 
         "<prettyOptional(limitOffsetCls, toString, sep="\n")>" + 
         "<prettyOptional(queryClusterByCls, toString, sep="\n")>"
         );


public str toString(
  Query::union(
    Query qry1
    , list[SetQuantifier] setQuantifier
    , Query qry2
  )
) = "<toString(qry1)> UNION <prettyOptional(setQuantifier, toString)> <toString(qry2)>";

public str toString(
  Query::intersect(
    Query qry1
    , Query qry2
  )
) = "<toString(qry1)> INTERSECT <toString(qry2)>";

// Local
public str prettyLocal(Local::local()) = "LOCAL";

// DirectoryPath
public str toString(DirectoryPath::referenceOnly(str regularId)) = "\'${<regularId>}\'";
public str toString(DirectoryPath::directoryReference(str regularId, Identifier id)) = "\'${<regularId>}/<toString(id)>\'";
public str toString(DirectoryPath::directoryPath(list[Identifier] ids)) = "\'/<intercalate("/", [ toString(id) | id <- ids])>\'";

// SetQuantifier
public str toString(SetQuantifier::\all()) = "ALL";
public str toString(SetQuantifier::distinct()) = "DISTINCT";

// SelectClause
public str toString(SelectClause::selectClause(list[SetQuantifier] setQuantifier, Projection proj)) 
  = "SELECT 
    '  <trim("<prettyOptional(setQuantifier, toString)> <toString(proj)>")>";
public str toString(SelectClause::transform(
    list[Expr] expr
    , list[RowFormatClause] rowFormatCls1
    , str strConst
    , list[TransformColumnSpecification] transformColumnSpecifications
    , list[RowFormatClause] rowFormatCls2
    , list[RecordReaderClause] recordReader
  )
) = "SELECT TRANSFORM(<intercalate(", ", [ toString(exp) | exp <- expr ])>) <prettyOptional(rowFormatCls1, toString)> 
    'USING <strConst> AS (<intercalate(", ", [ toString(transformColumnSpecification) | transformColumnSpecification <- transformColumnSpecifications ])>) <prettyOptional(rowFormatCls2, toString)> <prettyOptional(recordReader, toString)>";

// Projection
public str toString(
  Projection::expAsVars(
    list[ExpAsVarOrStar] expAsVarOrStars
  )
) = "<intercalate(", \n", [ prettyExpAsVarOrStar(expAsVarOrStar) | expAsVarOrStar <- expAsVarOrStars ])>";

// TransformColumnSpecification
public str toString(
  TransformColumnSpecification::transformColumnSpecification(
    Identifier id
    , list[DataType] dType
  )
) = "<toString(id)> <prettyOptional(dType, toString)>";

// RecordReaderClause
public str toString(RecordReaderClause::recordReaderClause(str strConst)) = "RECORDREADER <strConst>";

// FromClause
public str toString(FromClause::fromClause(list[TableIdOrSubquery] tblIdOrSubqueries)) = "FROM <intercalate(", ", [ toString(tblIdOrSubquery) | tblIdOrSubquery <- tblIdOrSubqueries ])>";

// TableIdOrSubquery
public str toString(
  TableIdOrSubquery::tableId(
    TableName tblName
    , list[Identifier] id
  )
) = "<toString(tblName)> " + "<prettyOptional(id, toString)>";

// TableIdOrSubquery
public str toString(
  TableIdOrSubquery::tableIdOrSubquerySubquery(
    Query qry
    , Identifier id
  )
) = "(<toString(qry)>) <toString(id)>";


// JoinClause
public str toString(
  JoinClause::innerJoinClause(
    list[Inner] innerOpt
    , TableIdOrSubquery tblIdOrSubquery
    , list[JoinCondition] joinConditionOpt
    , list[JoinClause] joinClsOpt
  )
) = trim("<prettyOptional(innerOpt, prettyInner)> " + "JOIN <toString(tblIdOrSubquery)> <prettyOptional(joinConditionOpt, toString)> 
         '<prettyOptional(joinClsOpt, toString)>");

public str toString(
  JoinClause::outerJoinClause(
    OuterType outerType
    , list[Outer] outerOpt
    , TableIdOrSubquery tblIdOrSubquery
    , JoinCondition joinCondition
    , list[JoinClause] joinClsOpt
  )
) = "<toString(outerType)> " + trim("<prettyOptional(outerOpt, prettyOuter)> JOIN") + " <toString(tblIdOrSubquery)> <toString(joinCondition)> 
    '<prettyOptional(joinClsOpt, toString)>";

public str toString(
  JoinClause::leftSemiJoinClause(
    LeftSemiJoin leftSemiJoin
    , TableIdOrSubquery tblIdOrSubquery
    , JoinCondition joinCondition
    , list[JoinClause] joinClsOpt
  )
) = "<toString(leftSemiJoin)> <toString(tblIdOrSubquery)> <toString(joinCondition)> 
    '<prettyOptional(joinClsOpt, toString)>";

public str toString(
  JoinClause::crossJoinClause(
        CrossJoin crossjoin
        , TableIdOrSubquery tblIdOrSubquery
        , list[JoinCondition] joinConditionOpt
        , list[JoinClause] joinClsOpt
  )
) = "<toString(crossjoin)> <toString(tblIdOrSubquery)> <prettyOptional(joinConditionOpt, toString)> 
    '<prettyOptional(joinClsOpt, toString)>";

// Inner
public str prettyInner(Inner::inner()) = "INNER";

// Outer
public str prettyOuter(Outer::outer()) = "OUTER";

// JoinCondition
public str toString(JoinCondition::joinCondition(Expr exp)) = "ON <toString(exp)>";

// OuterType
public str toString(OuterType::left()) = "LEFT";
public str toString(OuterType::right()) = "RIGHT";
public str toString(OuterType::full()) = "FULL";

// LeftSemiJoin
public str toString(LeftSemiJoin::leftSemiJoin()) = "LEFT SEMI JOIN";

// CrossJoin
public str toString(CrossJoin::crossJoin()) = "CROSS JOIN";

// WhereClause
public str toString(WhereClause::whereClause(Expr exp)) = "WHERE <toString(exp)>";

// QueryClusterByClause
public str toString(
  QueryClusterByClause::insertWithClusterByClause(
    list[Identifier] ids
  )
) = "CLUSTER BY <intercalate(",", [ toString(id) | id <- ids ])>";

// WithClause
public str toString(WithClause::withClause()) = "WITH";

// CTEClause 
public str toString(CTEClause::cteClause(Identifier id, Query qry)) = "<toString(id)> AS (<toString(qry)>)";

// CTEAction
public str prettyCTEAction(CTEAction::selectAction(Query qry)) = "<toString(qry)>";
public str prettyCTEAction(CTEAction::fromAction(TableName tbl, SelectClause selectCls)) = "FROM <toString(tbl)>
                                                                                           '<toString(selectCls)>";

public str prettyCTEAction(
  CTEAction::cteActionInsertWithSelect(
      TableName tblName1
      , OverWriteOrInto overwriteOrInto
      , TableName tblName2
      , list[PartitionWithOptionValueClause] partitionWithOptValCls
      , SelectClause selectCls
    )
) = "FROM <toString(tblName1)> INSERT <toString(overwriteOrInto)> <toString(tblName2)> " + "<prettyOptional(partitionWithOptValCls, toString)>" + " <toString(selectCls)>";

public str prettyCTEAction(
  CTEAction::cteActionInsertWithQuery(
    OverWriteOrInto overwriteOrInto
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls
    , list[ColumnSpecificationForInsert] colSpecForInsert
    , Query qry
  )
) = "INSERT <toString(overwriteOrInto)> <toString(tblName)> " + trim("<prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(colSpecForInsert, toString)>") +" <toString(qry)>";

// OverWriteOrInto
public str toString(
  OverWriteOrInto::overWriteOrIntoOverwrite(
    list[Table] tbl
  )
) = "OVERWRITE <prettyOptional(tbl, toString)>";
public str toString(
  OverWriteOrInto::overWriteOrIntoInto(
    list[Table] tbl
  )
) = "INTO <prettyOptional(tbl, toString)>";

// ColumnSpecificationForInsert
public str toString(
  ColumnSpecificationForInsert::columnSpecificationForInsert(
    list[Identifier] ids
  )
) = "(<intercalate(",", [ toString(id) | id <- ids ])>)";

// InsertWithQuery
public str toString(
  InsertWithQuery::overwrite(
    list[Table] tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
  , Query qry
  )
) = "INSERT OVERWRITE <prettyOptional(tbl, toString)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <toString(qry)>";

public str toString(
  InsertWithQuery::into(
    list[Table] tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , Query qry
  )
) = "INSERT INTO <prettyOptional(tbl, toString)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <toString(qry)>";

// QueryExpr
public str toString(Expr::scalarSubquery(Subquery sqry)) = "<toString(sqry)>";
public str toString(Expr::exists(Subquery sqry)) = "EXISTS <toString(sqry)>";
public str toString(Expr::inSubquery(Expr exp, list[Not] not, Subquery sqry)) = "<toString(exp)> <prettyOptional(not, prettyNot)> IN <toString(sqry)>";

// Subquery
public str toString(Subquery::subquery(Query qry)) = "(<toString(qry)>)";


