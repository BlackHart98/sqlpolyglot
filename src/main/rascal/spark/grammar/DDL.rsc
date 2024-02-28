module spark::grammar::DDL

extend spark::grammar::Query;


syntax Statement 
    = createViewWithReplace: 'CREATE' OrReplaceOrTemporary 'VIEW' IfNotExists? ViewId
        CreateViewClause* 'AS' QueryOrWith
    | createDb:'CREATE' DatabaseOrSchema IfNotExists? Identifier
        CommentLiteral?
        LocationClause?
        WithDB?
    | createFunction:'CREATE' OrReplaceOrTemporary? 'FUNCTION' IfNotExists?
        {Identifier ","}+ 'AS' StringConstant ResourceLocation?
    | setStatement: SetStatement
    ;


syntax CreateTable
    = fromSource:'CREATE' 'TABLE' IfNotExists? TableName?
        Columns?
        RowFormatClauseSpark
        Option?
        PartitionedByClause?
        (ClusteredByClause?
            SortedByClause?
            'INTO' Expr 'BUCKETS' )?
        LocationClause?
        CommentLiteral?
            TablePropertiesClause?
        AsSelect?
    ;

syntax DatabaseOrSchema 
    = database:'DATABASE'
    | schema : 'SCHEMA'
    | databases: 'DATABASES'
    ;

syntax ColumnKeyword 
    = col:'COLUMN'
    | cols:'COLUMNS'
    ;


syntax RowFormatClauseSpark = rowFormatSpark: 'USING' StoredAsType Option?;

syntax Option = option: 'OPTIONS'"("{Options ","}+ ")";

syntax Options 
    = expr: Expr
    | pair: Identifier Expr 
    | storageLevel: String Expr
    ;

syntax AsSelect
    = withAs: 'AS' QueryOrWith
    | cte:("(" QueryOrWith ")")
    ;

syntax ViewId = PropRef;

syntax OrReplaceOrTemporary 
    = orReplace: 'OR' 'REPLACE'
    | temporary: TemporaryTable
    | replaceTemporary: 'OR' 'REPLACE' TemporaryTable
    ;



syntax TemporaryTable = globalTemporary : 'GLOBAL' 'TEMPORARY';

syntax CreateViewClause 
    = columnLevel : "(" {(Identifier CommentLiteral?) "," }+  ")"
    | viewLevel :CommentLiteral
    | tbl:TablePropertiesClause
    ;

syntax TBLPROPERTIES =tbl: 'TBLPROPERTIES' "("{TblProp ","}+ ")";

 syntax TblProp = String "=" String;


 syntax StoredAsType = hive: 'HIVE';



 syntax ColumnSpecification = columnNoType: Expr;



 syntax WithDB = with: 'WITH' 'DBPROPERTIES' "(" {(Identifier "=" Expr) ","}*  ")" ;




 syntax ResourceLocation = rLoc: 'USING' RType StringConstant;


 syntax RType
    = jar:'JAR'
    | file: 'FILE'
    | archive :'ARCHIVE'
    ;



syntax AlterTable
  = alterOrChange:'ALTER' 'TABLE' TableName AlterOrChange ColumnKeyword? Identifier column_name Identifier? alterColumnAction CommentLiteral
  | addColumn: 'ALTER' 'TABLE' TableName 'ADD'  'columns' "(" { (Identifier DataType? type) ","}+ ")"
  | renameColumn: 'ALTER' 'TABLE' TableName  'RENAME' 'COLUMN' Identifier 'TO' Identifier
  | replaceColumn: 'ALTER' 'TABLE' TableName PartitionClause? 'REPLACE' 'COLUMNS' "(" {(Identifier DataType type) ","}+ CommentLiteral ")" //visit again, the brackets are optional
  | dropColumn: 'ALTER' 'TABLE' TableName 'DROP' ColumnKeyword "("{Identifier","}+ ")"
  | setTableProperties : 'ALTER' 'TABLE' TableName 'SET' 'TBLPROPERTIES' "(" {TblProp ","}+ properties  ")"
  | unsetTableProperties : 'ALTER' 'TABLE' TableName 'UNSET' 'TBLPROPERTIES' "(" {UNQUOTEDCHARSEQUENCE ","}+ keys  ")"
  | setSerdeProp :'ALTER' 'TABLE' TableName PartitionClause? 'SET' 'SERDEPROPERTIES' "(" {TblProp ","}+ properties  ")"
  | setSerdePropWith :'ALTER' 'TABLE' TableName PartitionClause? 'SET' 'SERDE' String SerdePropertiesClause?
  | setFileFormat : 'ALTER' 'TABLE' TableName PartitionClause? 'SET' 'FILEFORMAT' StoredAsType
  | setLocation : 'ALTER' 'TABLE' TableName PartitionClause? 'SET' 'LOCATION' UNQUOTEDCHARSEQUENCE
  | recover: 'ALTER' 'TABLE' TableName 'RECOVER' 'PARTITIONS'
  ;


syntax Statement 
    = alterview: 'ALTER' 'VIEW' AlterView
    | alterdb:'ALTER' AlterSelectors Identifier SetStatement
    ;


syntax AlterView
    = rename: ViewId 'RENAME' 'TO' ViewId
    | setView: ViewId 'SET' 'TBLPROPERTIES' "(" {(String "=" String) ","}+ ")"
    | unsetView: ViewId 'UNSET' 'TBLPROPERTIES' IfExists? "(" {String ","}+ ")"
    | selectView : ViewId 'AS' QueryOrWith
    ;

syntax AlterSelectors
    = schema : 'SCHEMA'
    | db : 'DATABASE'
    | namespace : 'NAMESPACE'
    ;


syntax SetStatement
    = setProperty: 'SET' PropertyType? "(" {TblProp ","}+ ")"
    | noValue : 'SET' Output?
    ;


syntax PropertyType 
    = dbprop :'DBPROPERTIES'
    | prop: 'PROPERTIES'
    ;

syntax Output = v:"-v";


syntax AlterOrChange 
    = alter:'ALTER'
    | change: 'CHANGE'
    ;


syntax Statement
    = dropDb:'DROP' DatabaseOrSchema IfExists? Identifier RestrictOrCascade?
    | dropFunction:'DROP' TemporaryOrGlobal? 'FUNCTION' IfExists? {Identifier "."}+
    | dropTable : 'DROP' 'TABLE' IfExists? TableName Purge?
    | repair: 'REPAIR' 'TABLE' TableName AddDropSync?;



syntax RestrictOrCascade
    = restrict:'RESTRICT'
    | cascade: 'CASCADE'
    ;


syntax TemporaryOrGlobal
    = temporary:'TEMPORARY'
    | globalTemporary : 'GLOBAL' 'TEMPORARY'
    ;


syntax SetStatement
    = setLocation:  'SET' 'LOCATION' StringConstant
    | setStatementSpark: 'SET'  EXPANDEDIDENTIFIER "=" SetValue
    ;

syntax SetValue
  = unquotedSetValue: UNQUOTEDCHARSEQUENCE
  ;

syntax AddDropSync
    = add:'ADD' 'PARTITIONS'
    | drop:'DROP' 'PARTITIONS'
    | sync : 'SYNC' 'PARTITIONS'
    ;

