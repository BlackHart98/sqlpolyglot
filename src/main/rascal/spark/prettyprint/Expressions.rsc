module spark::prettyprint::Expressions

import spark::ast::Spark;
import List;
import basesql::prettyprint::BaseSQL;



 
public str toString(Expr::exist(Expr exp)) = "EXISTS<toString(exp)>";
// public str toString(Expr::nilLiteral(_)) = "NIL";
public str toString(Expr::not(Expr e)) = "!<toString(e)>";
public str toString(Expr::likeAll(Expr exp,list[Expr] exps)) = "<toString(exp)> LIKE ALL (<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(Expr::notlikeAll(Expr exp,list[Expr] exps)) = "<toString(exp)>  NOT LIKE ALL (<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(Expr::likeAny(Expr exp,list[Expr] exps)) = "<toString(exp)>   LIKE ANY (<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(Expr::notlikeAny(Expr exp,list[Expr] exps)) = "<toString(exp)>  NOT LIKE ANY (<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(Expr::notlikeSome(Expr exp,list[Expr] exps)) = "<toString(exp)>  NOT LIKE SOME (<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(Expr::likeSome(Expr exp,list[Expr] exps)) = "<toString(exp)> LIKE SOME (<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(Expr::rlike(Expr lhs, RLikeOrRegex rli, Expr rhs, EscapeEx escex)) =  "<toString(lhs)> <toString(rli)> <toString(rhs)> <intercalate("",[toString(e)|e<-escex])>";
public str toString(Expr::ilike(Expr lhs, Expr rhs ,list[EscapeEx] ex)) = "<toString(lhs)> ILIKE <toString(rhs)> <intercalate("",[toString(es)|es<-ex])>";  
public str toString(Expr::match(Expr e, list[Case] cases, list[Default] d)) = "(<toString(e)>) MATCH {<intercalate("",[toString(\case)|\case<-cases])> <intercalate("",[toString(a)|a<-d])>}";
public str toString(Expr::lambda (str arg, Expr exp)) = "<arg> =\> <toString(exp)>";
public str toString(Expr::optValue(OptionValue opt)) = "<toString(opt)>";




public str toString(NumericLiteral::\int(str intlit)) = intlit;
// public str toString(NumericLiteral::withoutExp(Decimal dec,list[str] prefix)) = "<toString(dec)><intercalate("",[p|p<-prefix])>";





public str toString(RLikeOrRegex::rLike()) = "RLIKE";
public str toString(RLikeOrRegex::regexp()) = "REGEXP";



// public str toString(Decimal::decimal()) = "DECIMAL";
// public str toString(PrimitiveType::decType()) = "DEC";



public str toString(escape(Expr e))= "ESCAPE <toString(e)>"; 

public str toString(comment(str strConst)) = "COMMENT <strConst>";

public str toString(\case(Expr e1, Expr e2)){
   return "CASE <toString(e1)> =\> <toString(e2)> ;" ;
}



public str toString(\default(Expr e)){
    return "DEFAULT =\> <toString(e)> ;";
}


public str toString(OptionValue::none()) = "NONE";
public str toString(OptionValue::disk1()) = "DISK_ONLY";
public str toString(OptionValue::disk2()) = "DISK_ONLY_2";
public str toString(OptionValue::disk3()) = "DISK_ONLY_3";
public str toString(OptionValue::memory1()) = "MEMORY_ONLY";
public str toString(OptionValue::memory2()) = "MEMORY_ONLY_2";
public str toString(OptionValue::memoryOnlyser()) = "MEMORY_ONLY_SER";
public str toString(OptionValue::memoryOnlyser2()) = "MEMORY_ONLY_SER_2";
public str toString(OptionValue::memAndDisk()) = "MEMORY_AND_DISK";
public str toString(OptionValue::memoryAndDisk2()) = "MEMORY_AND_DISK_2";
public str toString(OptionValue::memoryAndDiskSer()) = "MEMORY_AND_DISK_SER";
public str toString(OptionValue::memoryAndDiskSer2()) = "MEMORY_AND_DISK_SER_2";
public str toString(OptionValue::offHeap()) = "OFF_HEAP";



public str toString(PrimitiveType::byteType()) = "BYTE";
public str toString(PrimitiveType::longType()) = "LONG";
public str toString(PrimitiveType::shortType()) = "SHORT";
public str toString(PrimitiveType::numericType()) = "NUMERIC";
public str toString(PrimitiveType::decType()) = "DEC";
public str toString(PrimitiveType::timestampNTZType()) = "TIMESTAMP_NTZ";
public str toString(PrimitiveType::realType()) = "REAL";





