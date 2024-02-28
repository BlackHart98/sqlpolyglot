module spark::ast::Spark


extend spark::ast::Expressions;


data Spark 
    = expression(Expr expr)
    | statements(list[StatementWithTerminator] statementWithTerminatorList)
    | simpleStatement(Statement statement)
    ;
    


// Statement
data Statement
    = alterview(AlterView alterView)
    | alterdb(AlterSelectors alterSelectors, Identifier identifier, SetStatement setStatement)
    | insertOverwriteDirectory(
        list[Local] localOpt
        , list[RowFormatClauseSpark] rowFormatClauseSparkOpt
        , list[StoredAs] storedAsOpt
        , Query query
        )
    | insertOverwriteDirectoryPath(
        list[Local] localOpt
        , DirectoryPath directoryPath
  		, RowFormatClauseSpark rowFormatClauseSpark
  		, list[StoredAs] storedAsOpt,
  		Query query
        )
    | loadInto(list[Local] localOpt, str path, TableName tableName, list[PartitionClause] partitionClauseOpt)
    | loadOverwrite(list[Local] localOpt, str path, list[Expr] exprOpt, TableName tableName, list[PartitionClause] partitionClauseOpt)
    | createViewWithReplace(
        OrReplaceOrTemporary orReplaceOrTemporary
        , list[IfNotExists] ifNotExists
        , ViewId viewId
        , list[CreateViewClause] createViewClauseList
        , QueryOrWith queryOrWith
        )
    | createDb(
        DatabaseOrSchema databaseOrSchema
        , list[IfNotExists] ifNotExistsOpt
        , Identifier identifier
        , list[CommentLiteral] commentLiteralOpt
        , list[LocationClause] location
        , list[WithDB] withDBOpt
        )
    | createFunction(
        list[OrReplaceOrTemporary] orReplaceOrTemporaryOpt
        , list[IfNotExists] ifNotExistsOpt
        , list[Identifier] identifierList
        , str string
        , list[ResourceLocation] resourceLocationOpt
        )
    | setStatement(SetStatement setStatement)
    | dropDb(DatabaseOrSchema databaseOrSchema,list[IfExists] ifExistsOpt,Identifier id, list[RestrictOrCascade] restrictOrCascade)
    | dropFunction(list[TemporaryOrGlobal] temporaryOrGlobalOpt,list[IfExists] ifExistsOpt,list[Identifier] idList)
    | dropView(list[IfExists] ifex,list[str] ids)
    // | dropTable(list[IfExists] ifex,TableName tableName , list[Purge] purgeOpt)
    | fromSource(list[IfNotExists] ifNotExistsOpt, list[TableName] tableNameOpt
        , list[Columns] columnsOpt
        , RowFormatClauseSpark rowFormatClauseSpark
        , list[Option] optionOpt
        , list[PartitionedByClause] partitionedByClause
        , lrel[list[ClusteredByClause] clby,list[SortedByClause] sbcl, Expr lit] queryClusterByClauseOpt
        , list[LocationClause] locationClauseOpt
        , list[CommentLiteral] commentLiteralOpt
        , list[TablePropertiesClause] tblpOpt
        , list[AsSelect] asSelectOpt
        )
    | repair(TableName tableName, list[AddDropSync] addDropSync)
    | describeStatement(Describe desc)
    ;


data Describe
    = describeDb(Desc desc, list[Extended] extendedOpt, list[Identifier] identifier)
    | describeFunc(Desc desc, list[Extended] extendedOpt, list[Identifier] identifier)
    | describeQuery(Desc desc, list[DescribeStatement] describestmt)
    | describeTable(
        Desc desc
        , list[Table] tableOpt
        , list[Extended] extendedOpt
        , TableName tblName
        , list[PartitionClause] partClsOpt
        )
    | describeTableWithId(
        Desc desc
        , list[Table] tableOpt
        , list[Extended] extendedOpt
        , TableName tblName
        , PartitionClause partCls
        , list[Identifier] identifier
        )
    | listFile(File file, Url url)
    | listJar(Jar jar, Url url)
    | refresh(Url url)
    | refreshTable(list[Table] tableOpt, TableName tblName)
    | refreshFuntion(list[Identifier] ids)
    | reset(list[Identifier] identifier)
    | showColumns(ColumnKeyword colKeyword, FromOrIn formOrIn, list[FromOrIn] formOrInOpt)
    | showCreateTable(TableName tid, list[VarAssignAs] assign)
    | showDatabases(DatabaseOrSchema dos, list[Expr] exp)
    | showFunction(list[FunctionKind] fk,list[FromOrIn] formOrInOpt,list[Expr] exps)
    | showPartitions(TableName tid, list[PartitionClause] pclOpt)
    | showTables(list[FromOrIn] fromorIn,list[Expr] exps)
    | showTableProperties(TableName tid, UnquotedOrString uqos)
    | showViews(list[FromOrIn] fromorIn, list[Expr] exps)
    | uncache(list[IfExists] ifex, TableName tid)
    | showTableExtended(list[FromOrIn] fromorIn, Expr expr, list[PartitionClause] pclOpt)
    ;


data FromOrIn 
    = from(list[Identifier] ids)
    | \in(list[Identifier] ids)
    ;


data Lazy = lazy();

data File 
    = files()
    ;

data Jar
    = jars()
    ;

data Url 
    = url(lrel[list[SchemePart] schemePt, DirectoryPart directoryPt, list[FileNamePart] filePt] urlprts)
    | stringlit(list[str] regularIdOpt)
    ;


data Desc 
    = desc()
    | describe()
    ;





data FunctionKind 
    = user()
    | system()
    | \all()
    ;


data Extended = extended();


data DescribeStatement = qow(QueryOrWith qow)| fromClause(FromClause fcl) | vas(Value va);

// data ValuesAs= valuesas(ValuesBuilder vb,list[VarAssign]  varass);

data UnquotedOrString = unquote(str unquotedChar);

// data QUERY = queryKeyword();



data InsertWithQuery
    = intoWithValue(
        list[Table] tableOpt
        , TableName tableName
        , list[PartitionWithOptionValueClause] partitionOptCls
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpec
  	    , Value vl
        )
    | overwriteWithValue(
        list[Table] tableOpt
        , TableName tableName
        , list[PartitionWithOptionValueClause] partitionOptCls
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpec
  	    , Value vl
        )
    | intoWithValueFromTable(
        TableName tableName1
        , Table table
        , TableName tableName2
        , list[PartitionWithOptionValueClause] partitionOptCls
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpec
  	    , Value vl
        )
    | overwriteWithValueFromTable(
        TableName tableName1
        , Table table
        , TableName tableName2
        , list[PartitionWithOptionValueClause] partitionOptCls
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpec
  	    , Value vl
        )
    | intoFromTable(
        TableName tableName1
        , Table table
        , TableName tableName
        , list[PartitionWithOptionValueClause] partitionOptCls
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpec
  	    , list[Query] qryOpt
        )
    | overwriteFromTable(
        TableName tableName1
        , Table table
        , TableName tableName
        , list[PartitionWithOptionValueClause] partitionOptCls
        , list[IfNotExists] ifNotExists
        , list[ColumnSpecificationForInsert] columnSpec
  	    , list[Query] qryOpt
        )
    | intoWithReplace(
        list[Table] tableOpt
        , list[TableName] tableNameOpt
        , list[Columns] cols
        , Expr expr
  	    , QueryOrWith qryorwith
        )
    ;



data Value 
    = valuesas(ValuesBuilder valBuilder, list[VarAssign] varAssign)
    ; 

data ValuesBuilder = valuesBuilder(list[ValueSet] valueset);


data ValueSet = valset(list[Expr] expr);



data AddDropSync
    = add()
    | drop()
    | sync()
    ;


data AsSelect
    = withAs(QueryOrWith queryOrWith)
    | cte(QueryOrWith queryOrWith)
    ;

data ClusterBy = clusterby(list[Expr] exprs);

data RestrictOrCascade
    = restrict()
    | cascade()
    ;


data TemporaryOrGlobal
    = temporary()
    | global()
    ;


data TemporaryTable = globalTemporary();



data CreateViewClause
    = columnLevel(lrel[Identifier id,list[CommentLiteral] commentLiteral] clevel)
    | viewLevel(CommentLiteral cl)
    | tbl(TablePropertiesClause tblp)
    ;


data TBLPROPERTIES = tbl(lrel[str str1,str str2] tblprops);


data OrReplaceOrTemporary 
    = orReplace()
    | temporary(TemporaryTable temporaryTable)
    | replaceTemporary(TemporaryTable temporaryTable)
    ;


data DatabaseOrSchema = database()| schemaKeyword()| databases();


data WithDB = with(lrel[str ids, Expr expr] props);

data ResourceLocation = rLoc(RType rType, str slit);


data RType = jar() | file() | archive();


data SetStatement
    = setProperty(list[PropertyType ] propertyTypeOpt, lrel[str str1, str str2] propassignments)
    | setLocation(str location)
    | noValue(list[Output] outputOpt)
    | setStatementSpark(str expandedIdentifier, SetValue setValue)
    ;

data Output = v();

data PropertyType = dbprop() | prop();

data SetValue = unquotedSetValue(str unquotedSetValue);


data RowFormatClauseSpark = rowFormatSpark(StoredAsType storedAsType,  list[Option] optionOpt);

data Option = option(list[Options] optionList);

data Options = exp(Expr e) | pair(str id, Expr e)| storageLevel(str strLit,Expr e);

data AlterTable
    = alterOrChange(
        TableName tableName
        , AlterOrChange alterOrChange
        , list[ColumnKeyword] columnKeywordOpt
        , Identifier column_name
        , list[Identifier] alterColumnActionOpt
        , CommentLiteral commentLiteral
        )
    | addColumn(TableName tableName ,lrel[Identifier identifier,list[DataType] datatype] cols)
    | renameColumn(TableName tableName, Identifier id1, Identifier id2)
    | replaceColumn(TableName tableName,list[PartitionClause] partitionClauseOpt,lrel[Identifier id ,DataType datatype] columns, CommentLiteral commentLiteral)
    | dropColumn(TableName tableName,ColumnKeyword columnKeyword,list[Identifier] identifierList)
    | setTableProperties(TableName tableName, lrel[str str1, str str2] tblprops)
    | unsetTableProperties(TableName tableName,list[str] keys)
    | setSerdeProp(TableName tableName, list[PartitionClause] partitionClauseOpt, lrel[str str1, str str2] tblprops)
    | setSerdePropWith(TableName tableName, list[PartitionClause] partitionClauseOpt, str id, list[SerdePropertiesClause] serdePropertiesClauseOpt)
    | setFileFormat(TableName tableName, list[PartitionClause] partitionClauseOpt, StoredAsType storedAsType)
    | setLocation(TableName tableName, list[PartitionClause] partitionClauseOpt , str CharSeq)
    | recover(TableName tableName)
    ;


data AlterOrChange 
    = alter()
    | change()
    ;


data ColumnKeyword = col() | cols();


data AlterSelectors
    = schema()
    | db()
    | namespace()
    ;


data AlterView
    = rename(ViewId viewId1, ViewId viewId2)
    | setView(ViewId viewId, lrel[str ids ,str strings] props)
    | unsetView(ViewId viewId, list[IfExists] ifExistsOpt, list[str] strings)
    | selectView(ViewId vid, QueryOrWith queryorwith)
    ;

data ViewId = propRef(list[Identifier] identifier);

 
// Query
data Query
    = queryWithLateralView( 
        SelectClause  selectClause
        , list[FromClause] fromClauseOpt
        , list[Distributed] distributedOpt
        , list[SortedByClause] sortedByClauseOpt
        , list[PivotUnpivot] pivotUnpivotOpt
        , list[LateralView] lateralViewList
        , list[JoinClause] joinClauseOpt 
        , list[WhereClause] whereClauseOpt
        , list[GroupByClause] groupByClauseOpt
        , list[HavingClause] havingClauseOpt  
        , list[WindowClause] windowClauseOpt
        , list[OrderByClause] orderByClauseOpt 
        , list[LimitOffsetClauses] limitOffsetClausesOpt
        , list[QueryClusterByClause] queryClusterByClauseOpt
        )
    | queryWithDistributed(
        SelectClause  selectClause
        , list[FromClause] fromClauseOpt
        , Distributed distributed
        , list[SortedByClause] sortedByClauseOpt
        , list[PivotUnpivot] pivotUnpivotOpt
        , list[JoinClause] joinClauseOpt 
        , list[WhereClause] whereClauseOpt
        , list[GroupByClause] groupByClauseOpt
        , list[HavingClause] havingClauseOpt  
        , list[WindowClause] windowClauseOpt
        , list[OrderByClause] orderByClauseOpt 
        , list[LimitOffsetClauses] limitOffsetClausesOpt
        , list[QueryClusterByClause] queryClusterByClauseOpt
        )
    ;


data PivotUnpivot 
    = pivot(lrel[AggregateFunction aggfunc,list[str] pa] agg,ColList collist,lrel[ExpressionList explist,list[str] pa] exl)
    | unpivot( list[IncludeorEx] incoex , ValueColumnUnpivot valcolun, list[str] pa)
    ;


data LateralView
    = lateralView(list[Outer] outerOpt, FunctionCall functionCall, Identifier identifier,  list[Identifier] idList)
    ;


data ValueColumnUnpivot = valueColumnUnpivot(ColList collist, str name,lrel[ExpressionList explist,list[str] pa] exl);

data ExpressionList = singleExpr(str exp) | multiple(list[Expr] exps);


data ColList = singleCol(str) | multiple(list[str] ids);



data IncludeorEx = include()| exclude();