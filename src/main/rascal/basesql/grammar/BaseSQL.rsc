module basesql::grammar::BaseSQL


// extend lang::basesql::grammar::BaseSQLStatement;
extend basesql::grammar::DML;


syntax StatementWithTerminator
  = statementWithTerminator: Statement Terminator+
  ;


syntax Terminator
  = terminator: ";"
  ;




syntax Statement
      = use: 'USE' Identifier
      | truncateTable: 'TRUNCATE' Table? TableName PartitionClause?
      | msckRepair:  'MSCK' Repair? TableName MsckRepairActionClause?
      | analyzeTable: 
            'ANALYZE' 'TABLE' TableName PartitionClause? 'COMPUTE' 'STATISTICS' ForColumns? CacheMetadata? NoScan?
      ;