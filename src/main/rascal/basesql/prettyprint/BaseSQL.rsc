module basesql::prettyprint::BaseSQL


import basesql::ast::BaseSQL;
extend basesql::prettyprint::DDL;

import List;
import String;




public str toString(StatementWithTerminator::statementWithTerminator(Statement stmt, list[Terminator] terms)) = "<toString(stmt)><for(term <- terms) {><toString(term)>
                                                                                                                                     '<}>";

public str toString(Terminator::terminator()) = ";"; 




public str toString(Statement::use(Identifier id)) = "USE <toString(id)>";

public str toString(Statement::addFile(Url url)) = "ADD FILE <toString(url)>";


public str toString(
  Statement::with(
    WithClause withCls
    , list[CTEClause] cteClss
    , CTEAction cteActn
  )
) = "<toString(withCls)> <intercalate(", ", [ toString(cteCls) | cteCls <- cteClss])> <prettyCTEAction(cteActn)>";

public str toString(Statement::statementQuery(Query qry)) = "<toString(qry)>";

public str toString(
  Statement::insertOverwriteDirectory(
    list[Local] lcl
    , DirectoryPath directoryPath
    , list[RowFormatClause] rowFormatCls
    , list[StoredAs] storedAs
    , Query qry
  )
) = "INSERT OVERWRITE " + "<prettyOptional(lcl, prettyLocal)>" + " DIRECTORY <toString(directoryPath)> " + trim("<prettyOptional(rowFormatCls, toString)> <prettyOptional(storedAs, toString)>") + " <toString(qry)>";

public str toString(Statement::truncateTable(list[Table] tbl, TableName tblName, list[PartitionClause] partitionCls)) = "TRUNCATE <prettyOptional(tbl, toString)> <toString(tblName)> <prettyOptional(partitionCls, toString)>";

public str toString(Statement::insertWithQuery(InsertWithQuery insertWithQry)) = "<toString(insertWithQry)>";

public str toString(Statement::createView(list[IfNotExists] ifNotExists, TableName tblName, QueryOrWith qryOrWith)) = "CREATE VIEW <prettyOptional(ifNotExists, toString)> <toString(tblName)> AS <toString(qryOrWith)>";

public str toString(Statement::dropView(list[IfExists] ifExists, TableName tblName)) = "DROP VIEW <prettyOptional(ifExists, toString)> <toString(tblName)>";

public str toString(Statement::createTable(CreateTable createTbl)) = "<toString(createTbl)>";

public str toString(Statement::dropTable(list[IfExists] ifExists, TableName tblName, list[Purge] purge)) = "DROP TABLE <prettyOptional(ifExists, toString)> <toString(tblName)> <prettyOptional(purge, toString)>";

public str toString(Statement::alterTable(AlterTable alterTbl)) = "<toString(alterTbl)>";

public str toString(
  Statement::msckRepair(
    list[Repair] repair
    , TableName tblName
    , list[MsckRepairActionClause] msckRepairActionClause
  )
) = "MSCK <prettyOptional(repair, toString)> <toString(tblName)> <prettyOptional(msckRepairActionClause, toString)>";

public str toString(
  Statement::analyzeTable(
    TableName tblName
    , list[PartitionClause] partitionCls
    , list[ForColumns] forCol
    , list[CacheMetadata] cacheMetaData
    , list[NoScan] noScan
  )
) = "ANALYZE TABLE <toString(tblName)> <prettyOptional(partitionCls, toString)> COMPUTE STATISTICS <prettyOptional(forCol, toString)> <prettyOptional(cacheMetaData, toString)> <prettyOptional(noScan, toString)>";
