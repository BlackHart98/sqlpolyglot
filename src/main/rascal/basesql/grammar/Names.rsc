module basesql::grammar::Names

extend basesql::grammar::Layout;




syntax PropRef
  = propRef: {Identifier "."}+
  ;

syntax VarAssign
  = varAssign: VarAssignAs? Identifier
  ;

syntax VarAssignAs
  = as: 'AS'
  ;


syntax Identifier
  = varReference: "${"REGULARIDENTIFIER"}"
  | regularIdentifier: REGULARIDENTIFIER
  | quotedIdentifier: BACKQUOTED_IDENTIFIER
  ;


syntax TableName
  = LocalOrSchemaQualifiedName
  ;


syntax LocalOrSchemaQualifiedName
  = name: SchemaNameDot? Identifier
  ;

syntax SchemaNameDot
  = schemaName: Identifier"."
  ;


syntax Url
  = url: SchemePart? DirectoryPart? FileNamePart
  | urlVarReference: "${"REGULARIDENTIFIER "}"
  ;


syntax SchemePart
  = schemePart: Scheme"://"
  | noScheme: "/"
  ;

syntax Scheme
  = hdfs: 'hdfs'
  ;


syntax DirectoryPart
  = directoryPart: {Identifier "/"}+ "/"
  ;



syntax FileNamePart
  = fileNamePart: Identifier"."Identifier
  ;



lexical REGULARIDENTIFIER 
  = ([a-z A-Z] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords;
lexical EXPANDEDIDENTIFIER = [a-z A-Z 0-9 _ . \-]*;
lexical UNQUOTEDCHARSEQUENCE = (![;])*;
lexical BACKQUOTED_IDENTIFIER = [`]![`]*[`]; 
lexical QUOTED_IDENTIFIER = [\'][a-z A-Z][a-z A-Z 0-9 _]* [\'];


lexical SPACES = " "+;



keyword Keywords
	= 'INT'
  | 'SMALLINT'
  | 'BIGINT'
  | 'TINYINT'
	| 'STRING'
	| 'BOOLEAN'
  | 'FLOAT'
  | 'DOUBLE'
	| 'BINARY'
  // | 'TIMESTAMP'
  | 'DECIMAL'
  | 'WHEN'
  | 'CASE'
  | 'END'
  | 'DECIMAL'
  // | 'DATE'
  | 'VARCHAR'
  | 'CHAR'
  | 'DISTINCT'
  | 'MAP'
  | 'LEFT'
  | 'SEMI'
  | 'INNER'
  | 'CROSS'
  | 'JOIN'
  | 'WHERE'
  | 'USE'
  | 'NULL'
  | 'LATERAL'
  | 'VIEW'
  | 'CREATE'
  | 'TRUE'
  | 'FALSE'
  | 'ROW'
  | 'FORMAT'
  | 'COMMENT'
  | 'ANALYZE'
  | 'ADD'
  | 'FILE'
  | 'ALTER'
  | 'DROP'
  | 'REPAIR'
  | 'DEFINED'
  | 'PARTITION'
  | 'THEN'
  | 'AS'
  // | 'FROM'
	;


