module spark::prettyprint::Auxiliary



import List;
import spark::ast::Spark;
extend spark::prettyprint::DML;
import spark::prettyprint::Query;
import spark::prettyprint::Functions;
import spark::prettyprint::Expressions;
import spark::prettyprint::DDL;
import spark::prettyprint::DML;
import basesql::prettyprint::BaseSQL;
import String;


public str toString(Statement::describeStatement(Describe desc)) = toString(desc);



public str toString(Describe desc){
    switch(desc){
        case  describeDb(Desc desc,list[Extended] exts , list[Identifier] ids):return "<toString(desc)> DATABASE <intercalate("",[toString(fn)|fn<-exts])> <intercalate(".",[toString(id)|id<-ids])>";
        case  describeFunc(Desc desc,list[Extended] exts , list[Identifier] ids):return "<toString(desc)> FUNCTION <intercalate("",[toString(fn)|fn<-exts])> <intercalate(".",[id|id<-ids])>";
        case  describeQuery(Desc desc, list[DescribeStatement] dest):return "<toString(desc)> QUERY <prettyOptional(dest, toString)>";
        case  describeTable(Desc desc,list[Table] tbl, list[Extended] exts,TableName tid,list[PartitionClause] pcl):return "<toString(desc)>  <intercalate("",[toString(tb)|tb<-tbl])> <intercalate("",[toString(fn)|fn<-exts])> <toString(tid)> <intercalate("",[toString(tb)|tb<-pcl])>";
        case  describeTableWithId(Desc desc,list[Table] tbl, list[Extended] exts,TableName tid,PartitionClause  pcl , list[Identifier] ids):return "<toString(desc)>  <intercalate("",[toString(tb)|tb<-tbl])> <intercalate("",[toString(fn)|fn<-exts])> <toString(tid)> <intercalate("",[toString(tb)|tb<-pcl])> <intercalate(".",[id|id<-ids])>";
        case  listFile(File file,Url url):return "LIST <toString(file)> <toString(url)>";
        case  listJar(Jar jar, Url url):return "LIST <toString(jar)> <toString(url)>";
        case  refresh(Url url):return "REFRESH <toString(url)>";
        case  refreshTable(list[Table] tb,TableName tid):return "REFRESH <intercalate("",[toString(tbl)|tbl<-tb])> <toString(tid)>";
        case  refreshFuntion(list[Identifier] ids):return "REFRESH FUNCTION <intercalate(".",[id|id<-ids])>";
        case  reset(list[Identifier] ids):return "RESET <intercalate(".",[id|id<-ids])>";
        case  showColumns(ColumnKeyword column,FromOrIn foi,list[FromOrIn] fromorIn):return "SHOW <toString(column)> <toString(foi)> <intercalate("",[toString(tbl)|tbl<-fromorIn])>";      
        case  showCreateTable(TableName tid, list[VarAssignAs] assign):return "SHOW CREATE TABLE <toString(tid)> <intercalate("",["<toString(ass)> serde"| ass<-assign])>";
        case  showDatabases(DatabaseOrSchema dos, list[Expr] exp):return "SHOW <toString(dos)> <intercalate("",["like <toString(e)>"|e<-exp])>";
        case  showFunction(list[FunctionKind] fk,list[FromOrIn] fromorIn,list[Expr] exps):return "show <intercalate("",[toString(e)|e<-fk])> functions <intercalate("",[toString(tbl)|tbl<-fromorIn])> <intercalate("",["like <toString(e)>"|e<-exps])>";
        case  showPartitions(TableName tid, list[PartitionClause] pcl):return "SHOW PARTITIONS <toString(tid)> <intercalate("",[toString(tb)|tb<-pcl])>";
        case  showTableExtended(list[FromOrIn] fromorIn,Expr expr,list[PartitionClause] pcl):return "show table extended <intercalate("",[toString(tb)|tb<-fromorIn])> like <toString(expr)> <intercalate("",[toString(tb)|tb<-pcl])>";
        case  showTables(list[FromOrIn] fromorIn,list[Expr] exps):return "SHOW TABLES <intercalate("",[toString(tb)|tb<-fromorIn])> <intercalate("",["LIKE <toString(e)>"|e<-exps])>";
        case  showTableProperties(TableName tid,UnquotedOrString uqos):return "SHOWS TBLPROPERTIES <toString(tid)> (<toString(uqos)>)";
        case  showViews(list[FromOrIn] fromorIn, list[Expr] exps):return "SHOW VIEW <intercalate("",[toString(tb)|tb<-fromorIn])> <intercalate("",["like <toString(e)>"|e<-exps])>";
        case  uncache(list[IfExists] ifex,TableName tid):return "UNCACHE TABLE <intercalate("",[toString(ifEx)|ifEx<-ifex])> <toString(tid)>";
        default: throw "<desc> not seen ";
    }
}


public str toString(Desc::desc())= "DESC";
public str toString(Desc::describe())= "DESCRIBE";
public str toString(lazy())= "LAZY";

// data Extended = extended();
public str toString(Extended extnd){
    switch(extnd){
        case extended(): return "EXTENDED";
        default: throw "<extnd> not seen ";
    }
}


public str toString(FromOrIn foi){
    switch(foi){
        case from(list[Identifier] fid): return "from <intercalate(".",[toString(id)|id<-fid])>";
        case \in(list[Identifier] inId): return "in <intercalate(".",[toString(id)|id<-inId])>";
        default: throw "<col> not seen";
    }
}


public str toString(FunctionKind fk){
    switch(fk){
        case user(): return "USER";
        case system(): return "SYSTEM";
        case \all(): return "ALL";
        default: throw "<fk> not seen";
    }  
}


public str toString(Jar fl){
    switch(fl){
        case Jar::jar():return "JAR";
        case Jar::jars():return "JARS";
        default: throw "<fl> not seen";
    }
}

public str toString(File fl){
    switch(fl){
        case File::file():return "FILE";
        case File::files():return "FILES";
        default: throw "<fl> not seen";
    }
}

public str toString(UnquotedOrString unquotedChar){
    switch(unquotedChar){
        case unquote(str strval): return "<strval>";
        default: throw "<unquotedChar> not seen ";
    }
}
