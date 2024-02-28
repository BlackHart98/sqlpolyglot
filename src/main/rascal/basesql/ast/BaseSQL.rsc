module basesql::ast::BaseSQL


data StatementWithTerminator = statementWithTerminator(Statement stmt, list[Terminator] terminator);

data Terminator = terminator();

data StarOrExpr = aggExpr(Expr expr) | star();


// expression
data Expr 
  = propRef(list[Identifier] identifier)
  | integer(str \int) 
  | long(str \int) 
  | decimal(str decim) 
  | illegalNull() 
  | string(str  strConst)
  | \true() | \false()
  | mapLit(list[MapEntry] mapEnt)
  | date(str  strConst)
  | time(str  strConst)
  | timeStamp(str  strConst)
  | uMin(Expr expr)
  | cast(Expr expr, DataType datatype)
  | cct(Expr expr1, Expr expr2)
  | mul(Expr expr1, Expr expr2)
  | div(Expr expr1, Expr expr2)
  | modulus(Expr expr1, Expr expr2)
  | sub(Expr expr1, Expr expr2)
  | add(Expr expr1, Expr expr2)
  | eq(Expr expr1, Expr expr2)
  | twoEqual(Expr expr1, Expr expr2)
  | gt(Expr expr1, Expr expr2)
  | lt(Expr expr1, Expr expr2)
  | gte(Expr expr1, Expr expr2)
  | lte(Expr expr1, Expr expr2)
  | nullSafeEqual(Expr expr1, Expr expr2)
  | neq1(Expr expr1, Expr expr2)
  | neq2(Expr expr1, Expr expr2)
  | like(Expr expr1, Expr expr2)
  | inPredicate(Expr expr, list[Not] not, ArrayLiteral arrayLiteral)
  | between(Expr expr1, Expr exprCVE1, Expr exprCVE2)
  | isNull(Expr expr)
  | isNotNull(Expr expr)
  | not(Expr expr)
  | and(Expr expr1, Expr expr2)
  | or(Expr expr1, Expr expr2)
  | simpleCase(Expr expr, list[WhenClause] whenCls, list[ElseClause] elseClsOpt)
  | searchedCase(list[WhenClause] whenCls, list[ElseClause] elseCls)
  | interval(str strConst, Duration duration)
  | scalarSubquery(Subquery subquery)
  | exists(Subquery subquery)
  | inSubquery(Expr expr, list[Not] not, Subquery subquery)
  ;

data NamedStructEntry = namedStructEntry(str quotedId, Expr expr);

data ExpAsVarOrStar
  = projectionExpAsVar(ExpAsVar expAsVar)
  | tableNameDotStar(TableName tblName)
  | projectionStar()
  ;

data ExpAsVar 
  = expAsVar(Expr expr, list[VarAssign] varAssign)
  | namedStructExp(list[NamedStructEntry] namedStructEntry, list[VarAssign] varAssign)
  ;


data Boolean = \true() | \false();

data Duration = year() | month() | day() | hour() | minute() | second();

data Not = not();

data WhenClause = whenClause(Expr expr1, Expr expr2);

data ElseClause = elseClause(Expr expr);

data ArrayLiteral = array(list[Expr] expr);


data MapEntry = mapEntry(Expr expr1, Expr expr2);




  
data WindowSpecification 
  = windowSpecification(
        list[PartitionByClause] partitionByCls
        , list[OrderByClause] orderByCls
        , list[WindowFrameClause] windowFrameCls
    )
  | namedWindow(Identifier identifier)
  ;

data PartitionByClause = partitionByClause(list[Expr] expr);

data RowsOrRange = rows() | range();


data WindowFrameClause 
  = windowFrameClause(RowsOrRange rowOrRange , FrameStartOrBetween frameStartOrBetween)
  ;

data FrameStartOrBetween
  = frameStart(FrameStart frmStart)
  | frameBetween(FrameBetween frmBetween)
  ; 

data FrameBetween
  = frameBetweenUnboundedPreceding(UnboundedPreceding unboundedFollowing, FrameEndA frameEndA)
  | frameBetweenNumericPreceding(NumericPreceding numericPreceding, FrameEndA frameEndA)
  | frameBetweenCurrentRow(CurrentRow currentRow, FrameEndB frameEndB)
  | frameBetweenNumericFollowing(NumericFollowing numericFollowing, FrameEndC frameEndC)
  ;

data FrameStart
  = frameStartUnboundedPreceding(UnboundedPreceding unboundedPreceding)
  | frameStartNumericPreceding(NumericPreceding numericPreceding)
  | frameStartCurrentRow(CurrentRow currentRow)
  ;


data FrameEndA
  = frameEndANumericPreceding(NumericPreceding numericPreceding)
  | frameEndACurrentRow(CurrentRow currentRow)
  | frameEndANumericFollowing(NumericFollowing numericFollowing)
  | frameEndAUnboundedFollowing(UnboundedFollowing unboundedFollowing)
  ;

data FrameEndB
  = frameEndBCurrentRow(CurrentRow currentRow)
  | frameEndBNumericFollowing(NumericFollowing numericFollowing)
  | frameEndBUnboundedFollowing(UnboundedFollowing unboundedFollowing)
  ; 


data FrameEndC
  = frameEndCNumericFollowing(NumericFollowing numericFollowing)
  | frameEndCUnboundedFollowing(UnboundedFollowing unboundedFollowing)
  ; 


data UnboundedPreceding = unboundedPreceding(); 

data NumericPreceding = numericPreceding(str \int);

data UnboundedFollowing = unboundedFollowing();

data NumericFollowing = numericFollowing(str \int);

data CurrentRow = currentRow();

data WindowClause 
  = windowClause(
        Identifier identifier
        , list[PartitionByClause] partitionByCls
        , list[OrderByClause] orderByCls
        , list[WindowFrameClause] windowFrameCls
    )
  ;


// Data types
data DataType
  = primitiveType(PrimitiveType primType) 
  | arrayType(DataType datatype) 
  | mapType(PrimitiveType primType, DataType datatype) 
  | structType(list[StructTypeFieldSpec] structTypefieldSpeclist) 
  | unionType(list[DataType] datatypelist)
  ;


data PrimitiveType
  = intType()
  | smallIntType()
  | bigIntType()
  | tinyIntType()
  | booleanType()
  | floatType()
  | doubleType()
  | doubleWithPrecisionType()
  | stringType()
  | binaryType()
  | timestampType()
  | decimalType(list[TwoParameterSpec] twoParamSpec)
  | dateType()
  | varCharType(list[SingleParameterSpec] singleParamSpec)
  | charType(list[SingleParameterSpec] singleParamSpec)
  ;


data TwoParameterSpec = twoParameterSpec(str num1, str num2);


data SingleParameterSpec = singleParameterSpec(str num1);

data StructTypeFieldSpec = structTypefieldSpec(Identifier identifier, DataType datatype);

data Distinct = aggregateDistinct();

// Names
data VarAssign = varAssign(list[VarAssignAs] varAssignAs, Identifier identifier);

data VarAssignAs = as();

data Identifier
  = varReference(str varRef)
  | regularIdentifier(str regularId)
  | quotedIdentifier(str quotedId)
  ;


data TableName = name(list[SchemaNameDot] schemaNameDot, Identifier identifier);

data SchemaNameDot = schemaName(Identifier identifier);

data Url
  = url(list[SchemePart] schemePt, list[DirectoryPart] directoryPt, FileNamePart filePt)
  | urlVarReference(str regularId)
  ;

data SchemePart
  = schemePart(Scheme schm)
  | noScheme()
  ;

data Scheme = hdfs();

data DirectoryPart = directoryPart(list[Identifier] identifier);

data FileNamePart = fileNamePart(Identifier identifier1, Identifier identifier2);


// Statement
data Statement 
  = use(Identifier identifier)
  | addFile(Url url)
  | with(WithClause withCls, list[CTEClause] cteCls, CTEAction cteActn)
  | statementQuery(Query qry)
  | insertOverwriteDirectory(
        list[Local] lcl
        , DirectoryPath directoryPath
        , list[RowFormatClause] rowFormatCls
        , list[StoredAs] storedAs
        , Query qry
    )
  | truncateTable(list[Table] tbl, TableName tblName, list[PartitionClause] partitionCls)
  | insertWithQuery(InsertWithQuery insertWithQry)
  | createView(list[IfNotExists] ifNotExists, TableName tblName, QueryOrWith qryOrWith)
  | dropView(list[IfExists] ifExists, TableName tblName)
  | createTable(CreateTable createTbl)
  | dropTable(list[IfExists] ifExists, TableName tblName, list[Purge] purge)
  | alterTable(AlterTable alterTbl)
  | msckRepair(list[Repair] repair, TableName tblName
        , list[MsckRepairActionClause] msckRepairActionClause)
  | analyzeTable(
        TableName tblName
        , list[PartitionClause] partitionCls
        , list[ForColumns] forCol
        , list[CacheMetadata] cacheMetaData
        , list[NoScan] noScan
    )
  ;


// Query
data Query
  = query(
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
  | union(Query qry1, list[SetQuantifier] setQuantifier, Query qry2)
  | intersect(Query qry1, Query qry2)   
  ;

data Local = local();

data DirectoryPath
  = referenceOnly(str regularId)
  | directoryReference(str reqularId, Identifier identifier)
  | directoryPath(list[Identifier] identifierList)
  ;

data SetQuantifier
  = \all()
  | distinct()
  ;

data SelectClause
  = selectClause(list[SetQuantifier] setQuantifier, Projection proj)
  | transform(
        list[Expr] expr
        , list[RowFormatClause] rowFormatCls1
        , str strConst
        , list[TransformColumnSpecification] transformColumnSpecification
        , list[RowFormatClause] rowFormatCls2
        , list[RecordReaderClause] recordReader
    )
  ;

data Projection = expAsVars(list[ExpAsVarOrStar] expAsVarOrStar);

data TransformColumnSpecification = transformColumnSpecification(Identifier identifier, list[DataType] datatype);

data RecordReaderClause = recordReaderClause(str strConst);

data FromClause = fromClause(list[TableIdOrSubquery] tblIdOrSubquery);

data TableIdOrSubquery
  = tableId(TableName tblName, list[Identifier] identifierOpt)
  | tableIdOrSubquerySubquery(Query qry, Identifier identifier)
  ;



data JoinClause
  = innerJoinClause(
        list[Inner] innerOpt
        , TableIdOrSubquery tblIdOrSubquery
        , list[JoinCondition] joinConditionOpt
        , list[JoinClause] joinClsOpt
    )
  | outerJoinClause(
        OuterType outerType
        , list[Outer] outerOpt
        , TableIdOrSubquery tblIdOrSubquery
        , JoinCondition joinCondition
        , list[JoinClause] joinClsOpt
    )
  | leftSemiJoinClause(
        LeftSemiJoin leftSemiJoin
        , TableIdOrSubquery tblIdOrSubquery
        , JoinCondition joinCondition
        , list[JoinClause] joinClsOpt
    )
  | crossJoinClause(
        CrossJoin crossjoin
        , TableIdOrSubquery tblIdOrSubquery
        , list[JoinCondition] joinConditionOpt
        , list[JoinClause] joinClsOpt
  )
  ;


data Inner = inner();

data Outer = outer();

data JoinCondition = joinCondition(Expr expr);

data OuterType = left() | right() | full();

data LeftSemiJoin = leftSemiJoin();

data CrossJoin = crossJoin();

data WhereClause = whereClause(Expr expr);

data QueryClusterByClause = insertWithClusterByClause(list[Identifier] identifier);

data WithClause = withClause();

data CTEClause = cteClause(Identifier identifier, Query qry);

data CTEAction
  = selectAction(Query qry)
  | fromAction(TableName tblName, SelectClause selectCls)
  | cteActionInsertWithSelect(
        TableName tblName1
        , OverWriteOrInto overwriteOrInto
        , TableName tblName2
        , list[PartitionWithOptionValueClause] partitionWithOptValCls
        , SelectClause selectCls
    )
  | cteActionInsertWithQuery(
        OverWriteOrInto overwriteOrInto
        , TableName tblName
        , list[PartitionWithOptionValueClause] partitionWithOptValCls
        , list[ColumnSpecificationForInsert] colSpecForInsert
        , Query qry
    )
  ;
 
 data OverWriteOrInto
  = overWriteOrIntoOverwrite(list[Table] tbl)
  | overWriteOrIntoInto(list[Table] tbl)
  ; 

data ColumnSpecificationForInsert = columnSpecificationForInsert(list[Identifier] identifier);

data InsertWithQuery
  = overwrite( 
        list[Table] tbl
        , TableName tblName
        , list[PartitionWithOptionValueClause] partitionWithOptValCls 
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpecificationForInsert
  		, Query qry
    )
  | into(
        list[Table] tbl
        , TableName tblName
        , list[PartitionWithOptionValueClause] partitionWithOptValCls
  	    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
  	    , Query qry
    )  
  ;

// TODO: missing ADT for Expr and QueryExpr

data Subquery = subquery(Query qry);


// SolutionModifiers
data GroupByClause = groupByClause(list[ExpAsVar] expAsVar);

data HavingClause = havingClause(Expr expr);

data OrderByClause = orderByClause(list[OrderElem] orderElem);

data OrderElem = orderExpr(Expr expr) | asc(Expr expr) | desc(Expr expr);

data LimitOffsetClauses
  = limitOffsetClauses(LimitClause limitCls, list[OffsetClause] offsetCls)
  | offsetLimitClauses(OffsetClause offsetCls1, list[LimitClause] offsetCls2)
  ;

data LimitClause = limitClause(str \int);

data OffsetClause = offsetClause(str \int);



// DDL
data TablePropertiesClause = tablePropertiesClause(list[TableProperty]  tblProperty);

data CreateTable
  = withColumns(
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
  | withQuery(
        list[TemporaryTable] temporaryTbl 
        , list[ExternalTable] externalTbl
        , list[IfNotExists] ifNotExists 
        , TableName tblName
        , list[RowFormatClause] rowFormatCls 
        , list[StorageClause] storageCls
        , CreateTableQuery createTblQry
    )
  | withLike(
        list[TemporaryTable] temporaryTbl
        , list[ExternalTable] externalTbl
        , list[IfNotExists] ifNotExists  
        , TableName tbl1
        , Like like
        , TableName tbl2
        , list[TablePropertiesClause] tblPropertiesCls
    )
  ;

data Like = like();

data CreateTableQuery = createTableQuery(QueryOrWith qryOrWith);

data QueryOrWith
  = queryOrWithQuery(Query qry)
  | queryOrWithWith(WithClause withCls, list[CTEClause] cteCls,  Query qry)
  ;

data Purge = purge();

data TemporaryTable = temporaryTable();

data ExternalTable = externalTable();

data Columns = columns(list[ColumnSpecification] colSpecification);

data PartitionedByClause = partitionedByClause(Columns col);

data ClusteredByClause 
  = clusteredByClause(list[Identifier] identifier, list[SortedByClause] sortedByCls, str \int);

data SortedByElem = sortByElem(Identifier identifier, list[SortedByDirection] sortedByDirection);

data SortedByDirection = asc() | desc(); 

data SortedByClause = sortBy(list[SortedByElem] sortByElem);

data LocationClause = locationClause(str strConst);

data AlterTable
  = renameTable(TableName tbl1, TableName tbl2)
  | addPartition(TableName tbl, list[IfNotExists] ifNotExists, list[PartitionClauseWithLocation] partitionClsWithLocation)
  | renamePartition(TableName tbl, PartitionClause partitionCls1, PartitionClause partitionCls2)
  | dropPartition(TableName tbl, list[IfExists] ifExists, list[PartitionClause] partitionCls
    , list[IgnoreProtection] ignoreProtection, list[Purge] purge)
  ;

data PartitionClauseWithLocation = partitionClauseWithLocation(PartitionClause partitionCls, list[LocationClause] locationCls);

data IgnoreProtection = ignoreProtection();

data Repair = repair();

data MsckRepairActionClause = msckRepairActionClause(RepairPartitionAction repairPartitionAction);

data RepairPartitionAction
  = repairPartitionAddAction()
  | repairPartitionDropAction()
  | repairPartitionsyncAction()
  ;

data ForColumns = forColumns();

data CacheMetadata = cacheMetadata();

data NoScan = noScan();


// Common
data IfNotExists = ifNotExists();

data IfExists = ifExists();

data PartitionClause = partitionClause(list[PartitionPart] partitionPart);

data PartitionPart = partitionPart(Identifier identifier, PartitionPartValue partitionPartVal);

data PartitionPartValue = partitionPartValue(Expr expr);

data PartitionPartWithOptionalValue = partitionPartWithOptionalValue(Identifier identifier, list[PartitionPartValue] partitionPartVal);

data PartitionWithOptionValueClause 
  = partitionWithOptionValueClause(list[PartitionPartWithOptionalValue] partitionPartWithOptVal);

data Table = table();

data TableProperty = tableProperty(str strConst1, str strConst2);

data PackageName = packageName(str regularId);

data ColumnSpecification = columnSpecification(Identifier identifier, DataType datatype, list[Comment] comment);

data Comment = comment(str strConst);

data RowFormatClause = rowFormat(RowFormatType rowFormatType);

data RowFormatType 
  = delimited(
        list[FieldsTerminatedBy] fieldsTerminatedBy
        , list[CollectionItemsTerminatedBy] collectionItemsTerminatedBy
        , list[MapKeysTerminatedBy] mapKeysTerminatedBy 
        , list[NullDefinedAs] nullDefinedAs
    )
  | serde(str strConst, list[SerdePropertiesClause] serdePropertiesCls)
  ;

data FieldsTerminatedBy = fieldsTerminatedBy(str strConst, list[EscapedBy] escapedBy);


data EscapedBy = escapedBy();

data CollectionItemsTerminatedBy = collectionItemsTerminatedBy(str strConst);

data MapKeysTerminatedBy = mapKeysTerminatedBy(str strConst);


data LinesTerminatedBy = linesTerminatedBy(str strConst);

data NullDefinedAs = nullDefinedAs(str strConst);


data SerdePropertiesClause = serdePropertiesClause(list[TableProperty] tblProperty);


data StorageClause
  = storageClauseStoredAs(StoredAs storedAs)
  | storageClauseStoredBy(str strConst, list[SerdePropertiesClause] serdePropertiesCls)
  ;

data StoredAs = storedAs(StoredAsType storedAsType);

data StoredAsType 
  = sequenceFile() 
  | textFile() 
  | rcFile() 
  | orc() 
  | parquet()
  | avro() 
  | jsonFile()
  | custom(str strConst1, str strConst2)
  ;