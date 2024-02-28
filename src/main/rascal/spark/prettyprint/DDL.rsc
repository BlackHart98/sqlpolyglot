module spark::prettyprint::DDL

import List;
import spark::ast::Spark;
import spark::prettyprint::Query;
import spark::prettyprint::Functions;
import spark::prettyprint::Expressions;
import basesql::prettyprint::BaseSQL;


public str toString(Statement stmt){
    switch(stmt){
        case  alterdb(AlterSelectors altsel, Identifier id, SetStatement setStm):return "ALTER <toString(altsel)> <toString(id)> <toString(setStm)>";
        case  alterview(AlterView altView):return "ALTER VIEW <toString(altView)>";
        case  dropDb(DatabaseOrSchema dos, list[IfExists] ifex, Identifier id, list[RestrictOrCascade] roc):{
            return "DROP <toString(dos)> <intercalate("",[toString(ifEx)|ifEx<-ifex])> <toString(id)> <intercalate("",[toString(ro)|ro<-roc])>";
        }
        case  dropFunction(list[TemporaryOrGlobal] temp,list[IfExists] ifex,list[Identifier] ids):{
            return "DROP  <intercalate("",[toString(t)|t<-temp])> FUNCTION <intercalate("",[toString(ifEx)|ifEx<-ifex])> <intercalate(".",[toString(id)|id<-ids])>";
        }
        case  dropTable(list[IfExists] ifex, TableName tid, list[Purge] purge):{
            return "DROP TABLE <intercalate("",[toString(ifEx)|ifEx<-ifex])> <toString(tid)> <intercalate("",[toString(p)|p<-purge])>";
        }
        case createViewWithReplace(
            OrReplaceOrTemporary orReplaceOrTemporary
            , list[IfNotExists] ifNotExistsOpt
            , ViewId viewId
            , list[CreateViewClause] createViewClauseList
            , QueryOrWith queryOrWith
            
        ): {
            return "CREATE <toString(orReplaceOrTemporary)> VIEW <intercalate("",[toString(ifEx)|ifEx<-ifNotExistsOpt])> <toString(viewId)>" +
                "<intercalate("\n", [toString(t)|t<-createViewClauseList])>\n" +
                "<toString(queryOrWith)>";
        }
        case createDb(
            DatabaseOrSchema dos
            , list[IfNotExists] ifnotexist
            , Identifier id
            , list[CommentLiteral] commlit
            , list[LocationClause] location
            , list[WithDB] wdb
        ): {
            return "CREATE <toString(dos)> <intercalate("",[toString(fcl)|fcl<-ifnotexist])> <toString(id)> <intercalate("",[toString(fcl)|fcl<-commlit])> <intercalate(",",[toString(fcl)|fcl<-location])> <intercalate(",",[toString(fcl)|fcl<-wdb])>";
        }
        case createFunction(
            list[OrReplaceOrTemporary] replaceTemp
            , list[IfNotExists] ifnotexist
            , list[Identifier] ids
            , str literal
            , list[ResourceLocation] rsl
        ): {
            return "CREATE <intercalate("",[toString(or)|or<-replaceTemp])> FUNCTION  <intercalate("",[toString(or)|or<-ifnotexist])> <intercalate(",",[toString(or)|or<-ids])> as <literal> <intercalate("",[toString(or)|or<-rsl])>";
        }
        case setStatement(SetStatement setStmt): return "<toString(setStmt)>";
        case repair(TableName tblName, list[AddDropSync] addDropSync): return "REPAIR TABLE <toString(tblName)> <prettyOptional(addDropSync, toString)>";
        default: throw "<stmt> not seen ";
    }

}




public str toString(ResourceLocation resourceLoc){
    switch(resourceLoc){
        case rLoc(RType rtype, str strconst): return "USING <toString(rtype)> <strconst>";
        default: throw "<resourceLoc> not seen ";
    }
}



public str toString(TemporaryTable tempTbl){
    switch(tempTbl){
        case globalTemporary(): return "GLOBAL TEMPORARY";
        default: throw "<tempTbl> not seen ";
    }
}


public str toString(RType rtype){
    switch(rtype){
        case jar(): return "JAR";
        case file(): return "FILE";
        case archive(): return "ARCHIVE";
        default: throw "<rtype> not seen ";
    }
}




public str toString(CreateViewClause createviewcls){
    switch(createviewcls){
        case columnLevel(lrel[Identifier id,list[CommentLiteral] cmlt] clevel): return "(<intercalate(",",["<p.id> <intercalate("",[toString(c)|c<-p.cmlt])>"|p<-clevel])>)";
        case viewLevel(CommentLiteral commentLit): return "<toString(commentLit)>";
        case tbl(TablePropertiesClause tableProp): return "<toString(tableProp)>";
        default: throw "<createviewcls> not seen ";
    }
}




public str toString(AddDropSync addDropSync){
    switch(addDropSync){
        case add(): return "ADD PARTITIONS";
        case drop(): return "DROP PARTITIONS";
        case sync(): return "SYNC PARTITIONS";
        default: throw "<addDropSync> not seen ";
    }
}


public str toString(option(list[Options] ov))="OPTIONS(<intercalate(",",[toString(id)|id<-ov])>)";


public str toString(Options os){
    switch(os){
        case Options::exp(Expr e):return toString(e) ; 
        case Options::pair(str id, Expr e):return "<id> <toString(e)>";
        case Options::storageLevel(str strLit,Expr e):return "<strLit> <toString(e)>";
        default: throw "<os> not seen";

    }
    
}




public str toString(CreateTable createTable){
    switch(createTable){
        case fromSource(
            list[IfNotExists] ifex
            , list[TableName]  tid
            , list[Columns] columnsOpt
            , RowFormatClauseSpark s
            , list[Option] option
            , list[PartitionedByClause] pbcl
            , lrel[list[ClusteredByClause] clby, list[SortedByClause] sbcl, Expr lit] clusterby
            , list[LocationClause] locate
            , list[CommentLiteral] commlit
            , list[TablePropertiesClause] tblp
            , list[AsSelect] as
        ): return "CREATE TABLE <intercalate("",[toString(or)|or<-ifex])> <intercalate("",[toString(or)|or<-tid])> <intercalate("",[toString(col)|col<-columnsOpt])> <toString(s)>  <intercalate("",[toString(or)|or<-option])> 
             <intercalate("",[toString(or)|or<-pbcl])> 
             <intercalate("",["<intercalate("",[toString(c)|c<-clusterby.clby])> 
             <intercalate("",[toString(c)|c<-clusterby.sbcl])>
             INTO <toString(cl.lit)> BUCKETS"|cl<-clusterby])> <intercalate("",[toString(c)|c<-locate])> 
             <intercalate("",[toString(c)|c<-commlit])> <intercalate("",[toString(c)|c<-tblp])> 
             <intercalate("",[toString(c)|c<-as])>";
        default: throw "<createTable> not seen ";
    }
}

public str toString(AsSelect aselect){
    switch(aselect){
        case withAs(QueryOrWith queryOrWith): return toString(queryOrWith);
        case cte(QueryOrWith queryOrWith): return toString(queryOrWith);
        // case databases(): return "DATABASES";
        default: throw "<aselect> not seen ";
    }
}


public str toString(with(lrel[str ids, Expr exp] props))="WITH DBPROPERTIES (<intercalate(",",["<p.ids>=<toString(p.exp)>"|p<-props])>)";


// syntax RowFormatClauseSpark = rowFormatSpark: 'USING' StoredAsType Option?;
public str toString(RowFormatClauseSpark rowFmtCls){
    switch(rowFmtCls){
        case rowFormatSpark(StoredAsType storedAsType, list[Option] option): return "USING <toString(storedAsType)> <prettyOptional(option, toString)>";
        default: throw "<rowFmtCls> not seen ";
    }
}

public str toString(OrReplaceOrTemporary orReplaceOrTemporary){
    switch(orReplaceOrTemporary){
        case orReplace(): return "OR REPLACE";
        case temporary(TemporaryTable tempTbl): return "<toString(tempTbl)>";
        case replaceTemporary(TemporaryTable tempTbl): return "OR REPLACE <toString(tempTbl)>";
        default: throw "<orReplaceOrTemporary> not seen ";
    }
}



public str toString(DatabaseOrSchema databaseOrSchema){
    switch(databaseOrSchema){
        case database(): return "DATABASE";
        case schema(): return "SCHEMA";
        case databases(): return "DATABASES";
        default: throw "<databaseOrSchema> not seen ";
    }
}


public str toString(RestrictOrCascade restrictOrCascade){
    switch(restrictOrCascade){
        case restrict(): return "RESTRICT";
        case cascade(): return "CASCADE";
        default: throw "<restrictOrCascade> not seen ";
    }
}


public str toString(TemporaryOrGlobal temporaryOrGlobal){
    switch(temporaryOrGlobal){
        case temporary(): return "TEMPORARY";
        case global(): return "GLOBAL";
        default: throw "<temporaryOrGlobal> not seen ";
    }
}



public str toString(ColumnKeyword col){
    switch(col){
        case col():return "COLUMN";
        case cols(): return "COLUMNS";
        default: throw "<col> not seen";
    }
}

public str toString(AlterTable alterTbl){
    switch(alterTbl){
        case  replaceColumn(
            TableName tid
            , list[PartitionClause] pclOpt
            , lrel[Identifier id ,DataType datatype] columns
            , CommentLiteral comm
        ):{
            return "ALTER TABLE <toString(tid)> <intercalate("",[toString(pc)|pc<-pclOpt])> REPLACE COLUMNS (<intercalate(",",["<toString(q.id)> <toString(q.datatype)>"|q<-columns])> <toString(comm)>)";
        }
        case  dropColumn(TableName tid, ColumnKeyword col, list[Identifier] ids):{
            return "ALTER TABLE <toString(tid)> DROP <toString(col)> ( <intercalate(",",[toString(id)|id<-ids])>)";
        }
        case  setTableProperties(TableName tid,lrel[str str1,str str2] tblprops):{
            return "ALTER TABLE <toString(tid)> SET TBLPROPERTIES ( <intercalate(",",["<id.str1>=<id.str2>"|id<-tblprops])>)";
        }
        case  addColumn(TableName tableId ,lrel[Identifier  id,list[DataType] datatype] cols):{
            return "ALTER TABLE <toString(tableId)> ADD COLUMNS (<intercalate(",",["<toString(q.id)> <intercalate("",[toString(d)|d<-q.datatype])>"|q<-cols])>)";
        }
        case  unsetTableProperties(TableName tid,list[str] keys):return "ALTER TABLE <toString(tid)> UNSET TBLPROPERTIES ( <intercalate(",",[id|id<-keys])>)";
        case  recover(TableName tid):return "ALTER TABLE <toString(tid)> RECOVER PARTITIONS";
        case  setLocation(TableName tid, list[PartitionClause] pcl , str string ):return "ALTER TABLE <toString(tid)> <intercalate("",[toString(pc)|pc<-pcl])> SET LOCATION <string>";
        case  setFileFormat(TableName tid,list[PartitionClause] pcl, StoredAsType fform):return "ALTER TABLE <toString(tid)> <intercalate("",[toString(pc)|pc<-pcl])> SET FILEFORMAT <toString(fform)> ";
        case  setSerdeProp(TableName tid, list[PartitionClause] pcl,lrel[str str1,str str2] tblprops ):return "ALTER TABLE <toString(tid)> <intercalate("",[toString(pc)|pc<-pcl])> SET SERDEPROPERTIES  (<intercalate(",",["<id.str1>=<id.str2>"|id<-tblprops])>) ";
        case  setSerdePropWith(TableName tid, list[PartitionClause] pcl,str id, list[SerdePropertiesClause] spc):return "ALTER TABLE <toString(tid)> <intercalate("",[toString(pc)|pc<-pcl])> SET SERDE <id> <intercalate("",[toString(pc)|pc<-spc])>";
        case  renameColumn(TableName tid, Identifier id1,Identifier id2):return "ALTER table <toString(tid)> rename COLUMN <toString(id1)> to <toString(id2)>";
        default: throw "<alterTbl> not seen ";
    }
}

public str toString(AlterView av){
    switch(av){
        case rename(ViewId vid1,ViewId vid2): return "<toString(vid1)> RENAME TO <toString(vid2)>";
        case setView(ViewId vid,lrel[str ids ,str strings] props):return"<toString(vid)> SET TBLPROPERTIES (<intercalate(",",["<id.ids>=<id.strings>"|id<-props])> )";
        case unsetView(ViewId vid, list[IfExists] ifex, list[str] strings):return "<toString(vid)> UNSET TBLPROPERTIES <intercalate("",[toString(ifx)|ifx<-ifex])> (<intercalate(",",[id|id<-strings])>)";
        case selectView(ViewId vid, QueryOrWith queryorwith): return "<toString(vid)> AS <toString(queryorwith)>";
        default: throw "<av> not seen";

    }
}

public str toString(AlterSelectors as){
    switch(as){
        case schema():return "SCHEMA";
        case db(): return "DATABASE";
        case namespace(): return "NAMESPACE";
        default: throw "<as> not seen";
    }
}


public str toString(ViewId viewId)="<toString(viewId)>";



public str toString(SetStatement setStm){
    switch(setStm){
        case setProperty(list[PropertyType] proptype, lrel[str str1, str str2] propassignments):{
            return "SET <intercalate("",[toString(v)|v<-proptype])> (<intercalate(", ",["<v.str1> = <v.str2>"|v<-propassignments])>)";
        }
        case setLocation(str val) :return "SET LOCATION <val>";
        case noValue(list[Output] output): return "SET <intercalate("",[toString(v)|v<-output])>";
        case setStatementSpark(str expandedIdentifier, SetValue setValue):{ 
            return "SET <expandedIdentifier> = <toString(setValue)>";
        }
        default: throw "<setStm> not seen";
    }
}



public str toString(PropertyType as){
    switch(as){
        case dbprop():return "DBPROPERTIES";
        case prop(): return "PROPERTIES";
        default: throw "<as> not seen";
    }
}

public str toString(Output::v())= "-v";


// SetValue
public str toString(SetValue::unquotedSetValue(str unquotedCharSeq)) = unquotedCharSeq; 