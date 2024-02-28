module spark::prettyprint::DML

import List;
import spark::ast::Spark;
import spark::prettyprint::Query;
import spark::prettyprint::Functions;
import spark::prettyprint::Expressions;
import spark::prettyprint::DDL;
import basesql::prettyprint::BaseSQL;
import String;




public str toString(
  Statement::insertOverwriteDirectory(
    list[Local] lcl
    , list[RowFormatClauseSpark] rowFormatCls
    , list[StoredAs] storedAs
    , Query qry
  )
) = "INSERT OVERWRITE " + "<prettyOptional(lcl, prettyLocal)>" + trim("<prettyOptional(rowFormatCls, toString)> <prettyOptional(storedAs, toString)>") + " <toString(qry)>";


public str toString(
  Statement::insertOverwriteDirectoryPath(
    list[Local] lcl
    , DirectoryPath directoryPath
    , RowFormatClauseSpark rowFormatCls
    , list[StoredAs] storedAs
    , Query qry
  )
) = "INSERT OVERWRITE " + "<prettyOptional(lcl, prettyLocal)>" + " DIRECTORY <toString(directoryPath)> " + trim("<toString(rowFormatCls)> <prettyOptional(storedAs, toString)>") + " <toString(qry)>";


public str toString(
  Statement::loadInto(
    list[Local] lcl
    , str directoryPath
    , TableName tblName
    , list[PartitionClause] partitionCls
  )
) = "LOAD DATA " + "<prettyOptional(lcl, prettyLocal)>" + " DIRECTORY <directoryPath> " + "INTO INTO TABLE " + trim("<toString(tblName)> <prettyOptional(partitionCls, toString)>");




public str toString(
  Statement::loadOverwrite(
    list[Local] lcl
    , str directoryPath
    , list[Expr] expr
    , TableName tblName
    , list[PartitionClause] partitionCls
  )
) = "LOAD DATA " + "<prettyOptional(lcl, prettyLocal)>" + " INPATH <directoryPath> " + "OVERWRITE " + "<prettyOptional(expr, toString)>" + "INTO TABLE " + trim("<toString(tblName)> <prettyOptional(partitionCls, toString)>");


public str toString(Statement::insertWithQuery(InsertWithQuery insertWithQry)) = "<toString(insertWithQry)>";



// InsertWithQuery
public str toString(
  InsertWithQuery::intoWithValue(
    list[Table] tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , Value vl
  )
) = "INSERT INTO <prettyOptional(tbl, toString)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <toString(vl)>";


public str toString(
  InsertWithQuery::overwriteWithValue(
    list[Table] tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , Value vl
  )
) = "INSERT OVERWRITE <prettyOptional(tbl, toString)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <toString(vl)>";


public str toString(
  InsertWithQuery::intoWithValueFromTable(
    TableName tblName
    , Table tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , Value vl
  )
) = "INSERT INTO <toString(tbl)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <toString(vl)>";


public str toString(
  InsertWithQuery::overwriteWithValueFromTable(
    TableName tblName
    , Table tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , Value vl
  )
) = "INSERT INTO <toString(tbl)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <toString(vl)>";



public str toString(
  InsertWithQuery::intoFromTable(
    TableName tblName
    , Table tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , list[Query] qry
  )
) = "INSERT INTO <toString(tbl)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <prettyOptional(qry, toString)>";



public str toString(
  InsertWithQuery::overwriteFromTable(
    TableName tblName
    , Table tbl
    , TableName tblName
    , list[PartitionWithOptionValueClause] partitionWithOptValCls 
    , list[IfNotExists] ifNotExists
    , list[ColumnSpecificationForInsert] columnSpecificationForInsert
    , list[Query] qry
  )
) = "INSERT OVERWRITE <toString(tbl)> <toString(tblName)> <prettyOptional(partitionWithOptValCls, toString)> <prettyOptional(ifNotExists, toString)> <prettyOptional(columnSpecificationForInsert, toString)> <prettyOptional(qry, toString)>";


public str toString(
  InsertWithQuery::intoWithReplace(
    list[Table] tbl
    , list[TableName] tblName
    , list[Columns] cols 
    , Expr expr
    , QueryOrWith qryOrWith
  )
) = "INSERT INTO <prettyOptional(tbl, toString)> <prettyOptional(tblName, toString)> <prettyOptional(cols, toString)> REPLACE WHERE <toString(expr)> <toString(qryOrWith)>";




public str toString(Value::valuesas(ValuesBuilder vb,list[VarAssign]  varass))= "<toString(vb)> <intercalate("",[toString(v)|v<-varass])>";
public str toString(valuesBuilder(list[ValueSet] exprs))="VALUES <intercalate(",",[toString(v)|v<-exprs])>";
public str toString(valset(list[Expr] e))="(<intercalate(",",[toString(v)|v<-e])>) ";


