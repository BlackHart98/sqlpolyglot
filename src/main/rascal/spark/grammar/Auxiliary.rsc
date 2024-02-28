module spark::grammar::Auxiliary


extend spark::grammar::DML;


syntax Statement = describeStatement: Describe;

syntax Describe 
    = describeDb: Desc 'DATABASE' Extended? {Identifier "."}+
    | describeFunc : Desc 'FUNCTION' Extended? {Identifier "."}+
    | describeQuery: Desc 'QUERY' DescribeStatement
    | describeTable: Desc Table? Extended? TableName PartitionClause?
    | describeTableWithId: Desc Table? Extended? TableName PartitionClause {Identifier "."}+
    | listFile: 'LIST' File Url
    | listJar: 'LIST' Jar Url
    | refresh: 'REFRESH' Url
    | refreshTable: 'REFRESH' Table? TableName
    | refreshFuntion: 'REFRESH' 'FUNCTION' {Identifier "."}+
    | reset: 'RESET' {Identifier "."}+
    | showColumns :'SHOW' ColumnKeyword FromOrIn FromOrIn?
    | showCreateTable :'SHOW' 'CREATE' 'TABLE'  TableName (VarAssignAs 'SERDE')?
    | showDatabases:'SHOW' DatabaseOrSchema  ('like' Expr)?
    | showFunction: 'SHOW' FunctionKind? 'FUNCTIONS' FromOrIn? ('like' Expr)?
    | showPartitions: 'SHOW' 'PARTITIONS' TableName PartitionClause?
    | showTableExtended : 'SHOW' 'TABLE' 'EXTENDED' FromOrIn? 'LIKE' Expr
        PartitionClause?
    | showTables: 'SHOW' 'TABLES' FromOrIn? ('like' Expr)?
    | showTableProperties: 'SHOW' 'TBLPROPERTIES' TableName "(" UnquotedOrString")"
    | showViews: 'SHOW' 'VIEWS' FromOrIn? ('like' Expr)?
    | uncache: 'UNCACHE' 'TABLE' IfExists? TableName
    ;



syntax FromOrIn 
    = from: 'FROM'{Identifier "."}+ 
    | \in : 'IN' {Identifier "."}+ 
    ;


syntax Lazy = lazy:'LAZY';

syntax File 
    = single:'FILE' 
    | plural:'FILES'
    ;

syntax Jar 
    = single:'JAR' 
    | plural:'JARS'
    ;

syntax Url 
    = url: {(SchemePart? DirectoryPart FileNamePart?) " "}+
    | stringlit: String+
    ;


syntax Desc 
    = desc:'DESC'
    | describe:'DESCRIBE'
    ;





syntax FunctionKind 
    = user: 'USER' 
    | system:'system'
    | \all:'ALL'
    ;


syntax Extended = extended:'EXTENDED';



syntax DescribeStatement 
    = queryOrWith: QueryOrWith
    | fromClause: FromClause 
    | valuesAs: ValuesAs
    ;



syntax QUERY = queryKeyword:'QUERY';


syntax UnquotedOrString = unquote:UNQUOTEDCHARSEQUENCE;