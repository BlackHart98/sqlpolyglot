module basesql::grammar::DDL

extend basesql::grammar::Query;


syntax Statement
      = createView: 'CREATE' 'VIEW' IfNotExists? TableName 'AS' QueryOrWith
      | dropView: 'DROP' 'VIEW' IfExists? TableName
      | createTable: CreateTable
      | dropTable: 'DROP' 'TABLE' IfExists? TableName  Purge?
      | alterTable: AlterTable
      ;



syntax TablePropertiesClause = tablePropertiesClause: 'TBLPROPERTIES' "("{TableProperty ", "}+")";

syntax CreateTable
  = withColumns: 'CREATE' TemporaryTable? ExternalTable? 'TABLE' IfNotExists? TableName 
                        Columns?
                        Comment?
                        PartitionedByClause?
                        ClusteredByClause?
                        RowFormatClause?
                        StorageClause? 
                        LocationClause?
                        TablePropertiesClause?
  | withQuery: 'CREATE' TemporaryTable? ExternalTable? 'TABLE' IfNotExists? TableName 
                    RowFormatClause? 
                    StorageClause?
                    CreateTableQuery
  | withLike: 'CREATE' TemporaryTable? ExternalTable? 'TABLE' IfNotExists?  TableName Like TableName 
                    TablePropertiesClause?
  ;


syntax Like = like: 'LIKE';


syntax CreateTableQuery = createTableQuery: 'AS' QueryOrWith;

syntax QueryOrWith
  = queryOrWithQuery: Query
  | queryOrWithWith: WithClause {CTEClause ","}+ Query
  ;


syntax Purge = purge: 'PURGE';

syntax TemporaryTable = temporaryTable: 'TEMPORARY';

syntax ExternalTable = externalTable: 'EXTERNAL';

syntax Columns = columns: "("{ColumnSpecification ","}+")";

syntax PartitionedByClause = partitionedByClause: 'PARTITIONED' 'BY' Columns;

syntax ClusteredByClause 
  = clusteredByClause: 'CLUSTERED' 'BY' "("{Identifier ","}+")" SortedByClause? 'INTO' Int 'BUCKETS';

syntax SortedByElem = sortByElem: Identifier SortedByDirection?;

syntax SortedByDirection 
  = asc: 'ASC'
  | desc: 'DESC'
  ; 

syntax SortedByClause = sortBy: 'SORTED' 'BY' "("{SortedByElem ", "}+")";

syntax LocationClause = locationClause: 'LOCATION' StringConstant;

syntax AlterTable
  = renameTable: 'ALTER' 'TABLE' TableName 'RENAME' 'TO' TableName
  | addPartition: 'ALTER' 'TABLE' TableName 'ADD' IfNotExists?  {PartitionClauseWithLocation  ","}+
  | renamePartition: 'ALTER' 'TABLE' TableName PartitionClause 'RENAME' 'TO' PartitionClause
  | dropPartition: 'ALTER' 'TABLE' TableName 'DROP' IfExists? {PartitionClause  ","}+ IgnoreProtection?
    Purge?
  ;

syntax PartitionClauseWithLocation = partitionClauseWithLocation: PartitionClause LocationClause?;

syntax IgnoreProtection = ignoreProtection: 'IGNORE' 'PROTECTION';

syntax Repair = repair: 'REPAIR';

syntax MsckRepairActionClause = msckRepairActionClause: RepairPartitionAction 'PARTITIONS';

syntax RepairPartitionAction
  = repairPartitionAddAction: 'ADD'
  | repairPartitionDropAction: 'DROP'
  | repairPartitionsyncAction: 'SYNC'
  ;

syntax ForColumns = forColumns: 'FOR' 'COLUMNS';

syntax CacheMetadata = cacheMetadata: 'CACHE' 'METADATA';

syntax NoScan = noScan: 'NOSCAN';
