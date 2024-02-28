module basesql::grammar::DML

extend basesql::grammar::DDL;


syntax Statement
      = with: WithClause {CTEClause ","}+ CTEAction 
      | statementQuery: Query
      | insertOverwriteDirectory: 
            'INSERT' 'OVERWRITE' Local? 'DIRECTORY' DirectoryPath 
                  RowFormatClause?
                  StoredAs?
                  Query
      | insertWithQuery: InsertWithQuery 
      ;