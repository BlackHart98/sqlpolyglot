module basesql::prettyprint::DDL

import basesql::ast::BaseSQL;
import List;
import String;

extend basesql::prettyprint::Query;

// TablePropertiesClause
public str toString(
  TablePropertiesClause::tablePropertiesClause(
    list[TableProperty] tblProperties
  )
) = "TBLPROPERTIES (<intercalate(",", [ toString(tblProperty) | tblProperty <- tblProperties])>)";

// CreateTable
public str toString(
  CreateTable::withColumns(
    list[TemporaryTable] temporaryTable
    , list[ExternalTable] externalTable
    , list[IfNotExists] ifNotExists 
    , TableName tblName
    , list[Columns] columns
    , list[Comment] comment
    , list[PartitionedByClause] partitionByCls
    , list[ClusteredByClause] clusteredByCls
    , list[RowFormatClause] rowFormatCls
    , list[StorageClause] storageCls 
    , list[LocationClause] locationCls
    , list[TablePropertiesClause] tblPropertiesCls
  )
) = "CREATE " + trim("<prettyOptional(temporaryTable, toString)> <prettyOptional(externalTable, toString)>") + " TABLE "+ trim("<prettyOptional(ifNotExists, toString)> <toString(tblName)> <prettyOptional(columns, toString)> <prettyOptional(comment, toString)> <prettyOptional(partitionByCls, toString)> <prettyOptional(clusteredByCls, toString)> <prettyOptional(rowFormatCls, toString)> <prettyOptional(storageCls, toString)> <prettyOptional(locationCls, toString)> <prettyOptional(tblPropertiesCls, toString)>");

public str toString(
  CreateTable::withQuery(
    list[TemporaryTable] temporaryTbl 
    , list[ExternalTable] externalTbl
    , list[IfNotExists] ifNotExists 
    , TableName tblName
    , list[RowFormatClause] rowFormatCls 
    , list[StorageClause] storageCls
    , CreateTableQuery createTblQry
  )
) = "CREATE " + trim("<prettyOptional(temporaryTbl, toString)> <prettyOptional(externalTbl, toString)>") + " TABLE " + trim(" <prettyOptional(ifNotExists, toString)> <toString(tblName)> <prettyOptional(rowFormatCls, toString)> <prettyOptional(storageCls, toString)> <toString(createTblQry)>");

public str toString(
  CreateTable::withLike(
    list[TemporaryTable] temporaryTbl
    , list[ExternalTable] externalTbl
    , list[IfNotExists] ifNotExists  
    , TableName tbl1
    , Like like
    , TableName tbl2
    , list[TablePropertiesClause] tblPropertiesCls
  )
) = "CREATE " + trim("<prettyOptional(temporaryTbl, toString)> <prettyOptional(externalTbl, toString)>") + " TABLE " + trim("<prettyOptional(ifNotExists, toString)> <toString(tbl1)> <toString(like)> <toString(tbl2)> <prettyOptional(tblPropertiesCls, toString)>");

// Like
public str toString(Like::like()) = "LIKE";

// CreateTableQuery
public str toString(CreateTableQuery::createTableQuery(QueryOrWith qryOrWith)) = "AS <toString(qryOrWith)>";

// QueryOrWith
public str toString(QueryOrWith::queryOrWithQuery(Query qry)) = "<toString(qry)>";
public str toString(
  QueryOrWith::queryOrWithWith(
    WithClause withCls
    , list[CTEClause] cteClss
    , Query qry
  )
) = "<toString(withCls)> <intercalate(", ", [ toString(cteCls) | cteCls <- cteClss])> <toString(qry)>";

// Purge
public str toString(Purge::purge()) = "PURGE";

// TemporaryTable
public str toString(TemporaryTable::temporaryTable()) = "TEMPORARY";

// ExternalTable
public str toString(ExternalTable::externalTable()) = "EXTERNAL";

// Columns
public str toString(
  Columns::columns(
    list[ColumnSpecification] colSpecifications
  )
) = "(
    '  <intercalate(", \n", [ toString(colSpec) | colSpec <- colSpecifications])>
    ')";

// PartitionedByClause
public str toString(
  PartitionedByClause::partitionedByClause(
    Columns col
  )
) = "PARTITIONED BY <toString(col)>";

// ClusteredByClause
public str toString(
  ClusteredByClause::clusteredByClause(
    list[Identifier] ids
    , [sortedByCls]
    , str \int
  )
) = "CLUSTERED BY (<intercalate(",", [ toString(id) | id <- ids])>) <toString(sortedByCls)> INTO <\int> BUCKETS";

// SortedByElem
public str toString(SortedByElem::sortByElem(Identifier id, list[SortedByDirection] sortedByDirection)) = "<toString(id)> <prettyOptional(sortedByDirection, toString)>";

// SortedByDirection
public str toString(SortedByDirection::asc()) = "ASC";
public str toString(SortedByDirection::desc()) = "DESC";

// SortedByClause
public str toString(SortedByClause::sortBy(list[SortedByElem] sortByElems)) = "SORTED BY (<intercalate(",", [ toString(sortByElem) | sortByElem <- sortByElems])>)";

// LocationClause
public str toString(LocationClause::locationClause(str strConst)) = "LOCATION <strConst>";

// AlterTable
public str toString(AlterTable::renameTable(TableName tbl1, TableName tbl2)) = "ALTER TABLE <toString(tbl1)> RENAME TO <toString(tbl2)>";
public str toString(AlterTable::addPartition(TableName tbl, list[IfNotExists] ifNotExists, list[PartitionClauseWithLocation] partitionClsWithLocations)) = "ALTER TABLE <toString(tbl)> ADD <prettyOptional(ifNotExists, toString)> <intercalate(",", [ toString(partitionClsWithLocation) | partitionClsWithLocation <- partitionClsWithLocations])>";
public str toString(AlterTable::renamePartition(TableName tbl, PartitionClause partitionCls1, PartitionClause partitionCls2)) = "ALTER TABLE <toString(tbl)> <toString(partitionCls1)> RENAME TO <toString(partitionCls2)>";
public str toString(
  AlterTable::dropPartition(
    TableName tbl
    , list[IfExists] ifExists
    , list[PartitionClause] partitionClss
    , list[IgnoreProtection] ignoreProtection
    , list[Purge] purge
  )
) = "ALTER TABLE <toString(tbl)> DROP <prettyOptional(ifExists, toString)> <intercalate(",", [ toString(partitionCls) | partitionCls <- partitionClss])> <prettyOptional(ignoreProtection, toString)> <prettyOptional(purge, toString)>";

// PartitionClauseWithLocation
public str toString(PartitionClauseWithLocation::partitionClauseWithLocation(PartitionClause partitionCls, locationCls)) = "<toString(partitionCls)> <prettyOptional(locationCls, toString)>";

// IgnoreProtection
public str toString(IgnoreProtection::ignoreProtection()) = "IGNORE PROTECTION";

// Repair
public str toString(Repair::repair()) = "REPAIR";

// MsckRepairActionClause
public str toString(MsckRepairActionClause::msckRepairActionClause(RepairPartitionAction repairPartitionAction)) = "<toString(repairPartitionAction)> PARTITIONS";

// RepairPartitionAction
public str toString(RepairPartitionAction::repairPartitionAddAction()) = "ADD";
public str toString(RepairPartitionAction::repairPartitionDropAction()) = "DROP";
public str toString(RepairPartitionAction::repairPartitionsyncAction()) = "SYNC";

// ForColumns
public str toString(ForColumns::forColumns()) = "FOR COLUMNS";

// CacheMetadata
public str toString(CacheMetadata::cacheMetadata()) = "CACHE METADATA";

// NoScan
public str toString(NoScan::noScan()) = "NOSCAN";

