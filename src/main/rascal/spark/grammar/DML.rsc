module spark::grammar::DML

extend spark::grammar::DDL;

syntax Statement
    = insertOverwriteDirectory: 
        'INSERT' 'OVERWRITE' Local? 'DIRECTORY'
  			RowFormatClauseSpark?
  			StoredAs?
  			Query
    | insertOverwriteDirectoryPath: 
        'INSERT' 'OVERWRITE' Local? 'DIRECTORY' DirectoryPath 
  			RowFormatClauseSpark
  			StoredAs?
  			Query
    | loadInto:'LOAD' 'DATA' Local? 'INPATH' StringConstant 'INTO' 'INTO' 'TABLE' TableName PartitionClause?
    | loadOverwrite:'LOAD' 'DATA' Local? 'INPATH' StringConstant 'OVERWRITE' Expr? 'INTO' 'TABLE' TableName PartitionClause?
    ;



syntax InsertWithQuery 
    = intoWithValue: 
        'INSERT' 'INTO' Table? TableName PartitionWithOptionValueClause? IfNotExists? 
  		    ColumnSpecificationForInsert?
  		    Value 
    | overwriteWithValue: 
        'INSERT' 'OVERWRITE' Table? TableName PartitionWithOptionValueClause? IfNotExists? 
  		    ColumnSpecificationForInsert?
  		    Value
    | intoWithValueFromTable: 
        'INSERT' 'INTO' TableName Table TableName PartitionWithOptionValueClause? IfNotExists? 
  		    ColumnSpecificationForInsert?
  		    Value 
    | overwriteWithValueFromTable: 
        'INSERT' 'OVERWRITE' TableName Table TableName PartitionWithOptionValueClause? IfNotExists? 
  		    ColumnSpecificationForInsert?
  		    Value 
    | intoFromTable: 
        'INSERT' 'INTO' TableName Table TableName PartitionWithOptionValueClause? IfNotExists? 
  		    ColumnSpecificationForInsert?
  		    Query? 
    | overwriteFromTable: 
        'INSERT' 'OVERWRITE' TableName Table TableName PartitionWithOptionValueClause? IfNotExists? 
  		    ColumnSpecificationForInsert?
  		    Query? 
    | intoWithReplace: 'INSERT' 'INTO' Table? TableName? Columns? 'REPLACE' 'WHERE' Expr QueryOrWith
    ;


syntax Value = ValuesAs; 


syntax ValuesAs = valuesas: ValuesBuilder VarAssign?;


syntax ValuesBuilder = valuesBuilder: 'VALUES' { ValueSet "," }+;


syntax ValueSet = valset:"(" {Expr ","}+ ")";




