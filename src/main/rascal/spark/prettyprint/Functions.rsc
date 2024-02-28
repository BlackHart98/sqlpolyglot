module spark::prettyprint::Functions

import List;
import spark::ast::Spark;
import spark::prettyprint::Expressions;
import basesql::prettyprint::BaseSQL;
import String;


public str toString(Expr::function(FunctionCall fCall)) = "<toString(fCall)>";


public str toString(\filter(WhereClause wcl))="FILTER(<toString(wcl)>)";





public str toString(InBuiltFunction::aggregateFunction(AggregateFunction agf, list[Filter] \filter)) = "<toString(agf)> <intercalate("",["<toString(q)>"|q<-\filter])>";
public str toString(InBuiltFunction::stringFunction(StringFunction sf)) = toString(sf);
public str toString(InBuiltFunction::windowFunction(WindowFunction windFunc)) = "<toString(windFunc)>";
public str toString(InBuiltFunction::conditionalFunction(ConditionalFunction cf)) = toString(cf);
public str toString(InBuiltFunction::mathFunction(MathFunction mf)) = toString(mf);
public str toString(InBuiltFunction::dateTimeFunction(DateTimeFunction dtf)) = toString(dtf);
public str toString(InBuiltFunction::conversionFunction( DataType dt, Expr exp)) = "<toString(dt)>(<toString(exp)>)";
public str toString(InBuiltFunction::arrayFunction(ArrayFunction af)) = toString(af);
public str toString(InBuiltFunction::mapFunction(MapFunction mpf)) = toString(mpf);
public str toString(InBuiltFunction::predicateFunction(Predicate pf)) = toString(pf);
public str toString(InBuiltFunction::generatorFunction(Generator gf)) = toString(gf);
        // case tvf(TableValued tv) :return toString(tv);






public str toString(Predicate::ilikeF(Expr exp1,Expr exp2)) = "ilike(<toString(exp1)>,<toString(exp2)>)";
public str toString(Predicate::likeF(Expr exp1,Expr exp2)) = "like(<toString(exp1)>,<toString(exp2)>)";
public str toString(Predicate::regExp(Expr exp1,Expr exp2)) = "regexp(<toString(exp1)>,<toString(exp2)>)";
public str toString(Predicate::rlikeF(Expr exp1,Expr exp2)) = "rlike(<toString(exp1)>,<toString(exp2)>)";
public str toString(Predicate::\in(Expr exp1,list[Expr] exprs2)) = "<toString(exp1)> in (<intercalate(",",[toString(e)|e<-exprs2])>)";




public str toString(ConditionalFunction::nvlFunction(Expr e1,Expr e2)) = "nvl(<toString(e1)>,<toString(e2)>)";
public str toString(ConditionalFunction::nvl2(Expr e1,Expr e2,Expr e3)) = "nvl2(<toString(e1)>,<toString(e2)>,<toString(e3)>)";
public str toString(ConditionalFunction::ifFunction(Expr e1,Expr e2,Expr e3)) = "if(<toString(e1)>,<toString(e2)>,<toString(e3)>)";
public str toString(ConditionalFunction::coalesce(Expr e1,list[Expr] es)) = "nvl(<toString(e1)>,<intercalate("",[toString(e)|e<-es])>)";
public str toString(ConditionalFunction::ifNull(Expr e1,Expr e2)) = "ifNull(<toString(e1)><toString(e2)>)";
public str toString(ConditionalFunction::nullIf(Expr e1,Expr e2)) = "nullIf(<toString(e1)><toString(e2)>)";



public str toString(FunctionCall fc){
    switch(fc){
       case inBuiltFunction(InBuiltFunction inBuiltFunc, list[AnalyticFunctionClause] analyticFunctionCls):return  "<toString(inBuiltFunc)>" + "<prettyOptional(analyticFunctionCls, toString)>";
       case udf(list[PackageName] pkgName, str funcName, list[Expr] expr): return trim("<prettyOptional(pkgName, toString)> <funcName>(<intercalate(", ", [toString(exp) | exp <- expr])>)");
       default: throw "<fc> not seen";
    }
}

public str toString(AnalyticFunctionClause::analyticFunctionClause(WindowSpecification windSpec)) = "OVER <toString(windSpec)>";

// WindowFunction
public str toString(WindowFunction::lead(Expr expr, list[LeadLagOffSet] leadLagOffSet)) = "LEAD(<toString(expr)> <prettyOptional(leadLagOffSet, toString)>)";
public str toString(WindowFunction::lag(Expr expr,  list[LeadLagOffSet] leadLagOffSet)) = "LAG(<toString(expr)> <prettyOptional(leadLagOffSet, toString)>)";
public str toString(WindowFunction::firstValue(Identifier id, list[CommaThenBoolean] commaThenBoolean)) = "FIRST_VALUE(<toString(id)> <prettyOptional(commaThenBoolean, toString)>)";
public str toString(WindowFunction::lastValue(Identifier id, list[CommaThenBoolean] commaThenBoolean)) = "LAST_VALUE(<toString(id)> <prettyOptional(commaThenBoolean, toString)>)";

// LeadLagOffSet
public str toString(LeadLagOffSet::leadLagOffSet(str \int, list[LeadLagDefault] leadLagDefault)) = ", <\int> <prettyOptional(leadLagDefault, toString)>";

// LeadLagDefault
public str toString(LeadLagDefault::leadLagDefault(Expr expr)) = ", <toString(expr)>";

// CommaThenBoolean
public str toString(CommaThenBoolean::commaThenBoolean(Boolean boolean)) = ", <toString(boolean)>";

// AnalyticFunctionClause
public str toString(AnalyticFunctionClause::analyticFunctionClause(WindowSpecification windSpec)) = "OVER <toString(windSpec)>";




public str toString(AggregateFunction::orderedSet(Order ord, Expr lit,OrderByClause odbcl)) = "<toString(ord)>(<toString(lit)> )within group (<toString(odbcl)>)";
public str toString(AggregateFunction::count(list[Distinct] distinct , StarOrExpr soe)) = "COUNT(<intercalate("",[toString(d)|d<-distinct])> <toString(soe)>) ";
public str toString(AggregateFunction::sum(list[Distinct] distinct , Expr exp)) = "SUM(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>) ";
public str toString(AggregateFunction::max(list[Distinct] distinct,Expr exp)) = "MAX(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>) ";
public str toString(AggregateFunction::avg( Expr exp)) = "AVG( <toString(exp)>) ";  //incomplete
public str toString(AggregateFunction::\any(Expr exp)) = "ANY( <toString(exp)>)";
public str toString(AggregateFunction::apcd(Expr exp , list[NumericLiteral] numlits)) = "APPROX_COUNT_DISCOUNT(<toString(exp)><intercalate("",[toString(lit)|lit<-numlits])>)";
public str toString(AggregateFunction::aprPer(Expr expr, NumericLiteral numlit , list[NumericLiteral] numlits)) = "APPROX_PERCENTILE(<toString(expr)>,<toString(numlit)><intercalate("",[toString(lit)|lit<-numlits])>)";
public str toString(AggregateFunction::bitand(Expr exp)) = "BIT_AND(<toString(exp)>)";
public str toString(AggregateFunction::bitor(Expr exp)) = "BIT_OR(<toString(exp)>)";
public str toString(AggregateFunction::bitxor(Expr exp)) = "BIT_XOR(<toString(exp)>)";
public str toString(AggregateFunction::bitmapConAg(Expr exp)) = "BITMAP_CONSTRUCT_AGG(<toString(exp)>)";
public str toString(AggregateFunction::boa(Expr exp)) = "BITMAP_OR_AGG(<toString(exp)>)";
public str toString(AggregateFunction::boolAnd(Expr exp)) = "BOOL_AND( <toString(exp)>)";
public str toString(AggregateFunction::boolOr(Expr exp)) = "BOOL_OR( <toString(exp)>)";
public str toString(AggregateFunction::collectList(Expr exp)) = "collect_list( <toString(exp)>)";
public str toString(AggregateFunction::collect_set(Expr exp)) = "collect_set( <toString(exp)>)";
public str toString(AggregateFunction::corr(Expr exp1,Expr exp2)) = "CORR( <toString(exp1)>,<toString(exp2)>)";
public str toString(AggregateFunction::countIf(Expr exp)) = "COUNT_IF( <toString(exp)>)";
public str toString(AggregateFunction::variance(Expr exp)) = "VARIANCE( <toString(exp)>)";
public str toString(AggregateFunction::varSamp(Expr exp)) = "var_samp( <toString(exp)>)";
public str toString(AggregateFunction::varPop(Expr exp)) = "var_pop( <toString(exp)>)";
public str toString(AggregateFunction::trySum(Expr exp)) = "try_sum( <toString(exp)>)";
public str toString(AggregateFunction::tryAvg(Expr exp)) = "try_avg( <toString(exp)>)";
public str toString(AggregateFunction::stdevs(Expr exp)) = "stddev_samp( <toString(exp)>)";
public str toString(AggregateFunction::stdPop(Expr exp)) = "stddev_pop( <toString(exp)>)";
public str toString(AggregateFunction::stdDev(Expr exp)) = "STDDEV( <toString(exp)>)";
public str toString(AggregateFunction::covarPop(Expr exp,Expr exp2)) = "covar_pop( <toString(exp)>,<toString(exp2)>)";
public str toString(AggregateFunction::covarSamp(Expr exp1,Expr exp2)) = "covar_samp( <toString(exp1)>,<toString(exp2)>)";
public str toString(AggregateFunction::every(Expr exp)) = "EVERY( <toString(exp)>)";
        // case first(Expr exp,list[str] boolit, list[IgnoreNull] ignore)) = "FIRST(<toString(exp)> <intercalate("",[",<q>"|q<-boolit])>  <intercalate("",[<toString(q)>|q<-ignore])>)";   
public str toString(AggregateFunction::grouping(Expr exp)) = "grouping(<toString(exp)>)";
public str toString(AggregateFunction::histNum(Expr exp,NumericLiteral numlit)) = "histogram_numeric(<toString(exp)>,<toString(numlit)> )";  
        // case last(Expr exp,list[str] boolit, list[IgnoreNull] ignore)) = "LAST(<toString(exp)> <intercalate("",[",<q>"|q<-boolit])>  <intercalate("",[<toString(q)>|q<-ignore])>)"; 
public str toString(AggregateFunction::maxBy(list[Distinct] distinct,Expr exp)) = "MAX_BY(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>)";
public str toString(AggregateFunction::mean(list[Distinct] distinct,Expr exp)) = "MEAN(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>)";
public str toString(AggregateFunction::median(Expr exp)) = "MEDIAN( <toString(exp)>) ";
public str toString(AggregateFunction::minBy(list[Distinct] distinct,Expr exp)) = "MIN_BY(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>) ";
public str toString(AggregateFunction::mode(list[Distinct] distinct,Expr exp)) = "MODE(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>) ";
public str toString(AggregateFunction::regAvgX(Expr x,Expr y)) = "regr_avgx( <toString(x)>,<toString(y)>)";
public str toString(AggregateFunction::regAvgY(Expr x,Expr y)) = "regr_avgy( <toString(x)>,<toString(y)>)";
public str toString(AggregateFunction::regCount(Expr x,Expr y)) = "regr_count( <toString(x)>,<toString(y)>)";
public str toString(AggregateFunction::regInt(Expr x,Expr y)) = "regr_intercept( <toString(x)>,<toString(y)>)";  
public str toString(AggregateFunction::regR2(Expr x,Expr y)) = "regr_r2( <toString(x)>,<toString(y)>)";  
public str toString(AggregateFunction::regSlope(Expr x,Expr y)) = "regr_slope( <toString(x)>,<toString(y)>)";
public str toString(AggregateFunction::regSXX(Expr x,Expr y)) = "regr_sxx( <toString(x)>,<toString(y)>)";
public str toString(AggregateFunction::regSXY(Expr x,Expr y)) = "regr_sxy( <toString(x)>,<toString(y)>)";
public str toString(AggregateFunction::regSYY(Expr x,Expr y)) = "regr_syy( <toString(x)>,<toString(y)>)";    
public str toString(AggregateFunction::skew(Expr x)) = "SKEWNESS(<toString(x)>)";    
public str toString(AggregateFunction::some(Expr x)) = "SOME(<toString(x)>)";    
public str toString(AggregateFunction::std(Expr x)) = "STD(<toString(x)>)";
public str toString(AggregateFunction::min(list[Distinct] distinct,Expr exp)) = "MIN(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>)";
public str toString(AggregateFunction::max(list[Distinct] distinct,Expr exp)) = "MAX(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)>)";
public str toString(AggregateFunction::arrayavg(Expr exp)) = "array_agg(<toString(exp)>)";
public str toString(AggregateFunction::listagg(list[Distinct] distinct,Expr exp,list[Separator] sep)) = "LISTAGG(<intercalate("",[toString(d)|d<-distinct])> <toString(exp)> <intercalate("",[toString(d)|d<-sep])>)";

public str toString(separator(Expr e))=", <toString(e)>";



public str toString(ArrayFunction::arrayFunc(list[Expr] exps)) = "array(<intercalate(",",[toString(exp)|exp<-exps])>)";
public str toString(ArrayFunction::struct(list[Expr] exps)) = "struct(<intercalate(",",[toString(exp)|exp<-exps])>)";
public str toString(ArrayFunction::arrayAppend( Expr e1, Expr e2)) = "array_append(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::arrayCompact(Expr exp)) = "array_compact(<toString(exp)>)";
public str toString(ArrayFunction::arrayContains( Expr e1, Expr e2)) = "array_contains(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::arrayDistinct(Expr exp)) = "array_distinct(<toString(exp)>)";
public str toString(ArrayFunction::arrayExcept( Expr e1, Expr e2)) = "array_except(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::\insert( Expr e1, Expr e2, Expr e3)) = "array_insert(<toString(e1)>,<toString(e2)>,<toString(e3)>)";
public str toString(ArrayFunction::intersect( Expr e1, Expr e2)) = "array_intersect(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::\join( Expr e1, Expr e2,list[Expr] exps)) = "array_join(<toString(e1)>,<toString(e2)> <intercalate("",[",<toString(q)>"|q<-exps])>)";
public str toString(ArrayFunction::arrayMax(Expr exp)) = "array_max(<toString(exp)>)";
public str toString(ArrayFunction::arrayMin(Expr exp)) = "array_min(<toString(exp)>)";
public str toString(ArrayFunction::arrayPos( Expr e1, Expr e2)) = "array_position(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::array_prepend( Expr e1, Expr e2)) = "array_prepend(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::array_remove( Expr e1, Expr e2)) = "array_remove(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::arrayRepeat( Expr e1, Expr e2)) = "array_repeat(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::union( Expr e1, Expr e2)) = "array_union(<toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::overlap( Expr e1, Expr e2)) = "arrays_overlap(<toString(e1)>,<toString(e2)>)"; 
public str toString(ArrayFunction::zip(Expr exp, list[Expr] exps)) = "zip( <toString(exp)>,<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(ArrayFunction::flatten(Expr exp)) = "flatten(<toString(exp)>)";
public str toString(ArrayFunction::get( Expr e1, Expr e2)) = "get( <toString(e1)>,<toString(e2)>)";
public str toString(ArrayFunction::sequence( Expr e1, Expr e2,Expr e3)) = "sequence( <toString(e1)>,<toString(e2)>,<toString(e3)>)";
public str toString(ArrayFunction::shuffle(Expr exp)) = "shuffle(<toString(exp)>)";
public str toString(ArrayFunction::slice( Expr e1, Expr e2,Expr e3)) = "slice( <toString(e1)>,<toString(e2)>,<toString(e3)>)";
public str toString(ArrayFunction::sort( Expr e1,list[Expr]  exps)) = "sort_array(<toString(e1)> <intercalate("",[",<toString(q)>"|q<-exps])>)";

public str toString(ignoreNull()) = "IGNORE NULLS";
public str toString(Order::cont()) = "PERCENTILE_CONT";
public str toString(Order::disc()) = "PERCENTILE_DISC";

public str toString(distributed(list[Expr] exps))="DISTRIBUTED BY <intercalate(",",[toString(fcl)|fcl<-exps])>";




public str toString(DateTimeFunction::toDate(Expr exp)) = "to_date(<toString(exp)>)";
public str toString(DateTimeFunction::toUtcTimestamp(Expr exp1, Expr exp2)) = "TO_UTC_TIMESTAMP((<toString(exp1)>,<toString(exp2)>))";
public str toString(DateTimeFunction::fromUtcTimestamp(Expr exp1, Expr exp2)) = "FROM_UTC_TIMESTAMP((<toString(exp1)>,<toString(exp2)>))";
public str toString(DateTimeFunction::fromUnixTimeTwoParam(Expr exp1, Expr exp2)) = "FROM_UNIXTIME(<toString(exp1)>,<toString(exp2)>)";
public str toString(DateTimeFunction::unixTimestampNoParam()) = "UNIX_TIMESTAMP()";
public str toString(DateTimeFunction::unixTimestampOneParam(Expr exp)) = "UNIX_TIMESTAMP(<toString(exp)>)";
public str toString(DateTimeFunction::unixTimestampTwoParam(Expr exp1, Expr exp2)) = "UNIX_TIMESTAMP(<toString(exp1)>,<toString(exp2)>)";
public str toString(DateTimeFunction::dateSub(Expr exp1, Expr exp2)) = "DATE_SUB(<toString(exp1)>,<toString(exp2)>)";
public str toString(DateTimeFunction::dateAdd(Expr exp1, Expr exp2)) = "DATE_ADD(<toString(exp1)>,<toString(exp2)>)";
public str toString(DateTimeFunction::dateDiff(Expr exp1, Expr exp2)) = "DATEDIFF(<toString(exp1)>,<toString(exp2)>)";
public str toString(DateTimeFunction::currentTimeStamp()) = "CURRENT_TIMESTAMP()";
public str toString(DateTimeFunction::currentDate()) = "CURRENT_DATE()";
public str toString(DateTimeFunction::monthsBetween(Expr exp1, Expr exp2)) = "MONTHS_BETWEEN(<toString(exp1)>,<toString(exp2)>)";
public str toString(DateTimeFunction::month(Expr exp)) = "month(<toString(exp)>)";
public str toString(DateTimeFunction::year(Expr exp)) = "year(<toString(exp)>)";
public str toString(DateTimeFunction::addMonths(Expr exp1, Expr exp2)) = "add_months(<toString(exp1)>,<toString(exp2)>)";




public str toString(MathFunction::ceilFunction(list[Expr] exps)) = "ceil(<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(MathFunction::ceilingFunction(list[Expr] exps)) = "ceiling(<intercalate(",",[toString(e)|e<-exps])>)";
public str toString(MathFunction::exponent(Expr exp)) = "exp(<toString(exp)>)";
public str toString(MathFunction::hex(Expr exp)) = "hex(<toString(exp)>)";
public str toString(MathFunction::unhex(Expr exp)) = "unhex(<toString(exp)>)";
public str toString(MathFunction::div(Expr exp1, Expr exp2)) = "<toString(exp1)> div <toString(exp2)>";



public str toString(StringFunction::ascii(Expr exp)) = "ascii(<toString(exp)>)";
public str toString(StringFunction::regExpReplace(Expr exp1, Expr exp2,Expr exp3)) = "regexp_replace(<toString(exp1)>,<toString(exp2)>,<toString(exp3)>)";
public str toString(StringFunction::base64(Expr exp)) = "base64(<toString(exp)>)";
public str toString(StringFunction::btrim(Expr exp, list[Expr] e)) = "btrim(<toString(exp)> <intercalate("",[",<toString(ex)>"|ex<-e])>)";
public str toString(StringFunction::blen(Expr exp)) = "bit_length(<toString(exp)>)";
public str toString(StringFunction::encode(Expr exp1, Expr exp2)) = "encode(<toString(exp1)>,<toString(exp2)>)";
public str toString(StringFunction::decode(Expr exp1, Expr exp2)) = "decode(<toString(exp1)>,<toString(exp2)>)";
public str toString(StringFunction::char(Expr exp)) = "char(<toString(exp)>)";
public str toString(StringFunction::chr(Expr exp)) = "chr(<toString(exp)>)";
public str toString(StringFunction::length(Expr exp)) = "length(<toString(exp)>)";
public str toString(StringFunction::len(Expr exp)) = "len(<toString(exp)>)";
public str toString(StringFunction::concat(Expr exp, list[Expr] e)) = "concat(<toString(exp)>,<intercalate(",",[<toString(ex)>|ex<-e])>)";
public str toString(StringFunction::instr(Expr exp1, Expr exp2)) = "instr(<toString(exp1)><toString(exp2)>)";
public str toString(StringFunction::substring(Expr exp1, Expr exp2)) = "substring(<toString(exp1)>,<toString(exp2)>)";
public str toString(StringFunction::substringWithEnd(Expr exp1, Expr exp2,Expr exp3)) = "substring(<toString(exp1)>,<toString(exp2)>,<toString(exp3)>)";
public str toString(StringFunction::substr(Expr exp1, Expr exp2)) = "substr(<toString(exp1)>,<toString(exp2)>)";
public str toString(StringFunction::substrfrom(Expr exp, From fr)) = "substr(<toString(exp)> <toString(fr)>)";
public str toString(StringFunction::substringfrom(Expr exp, From fr)) = "substring(<toString(exp)> <toString(fr)>)";
public str toString(StringFunction::substrWithEnd(Expr exp1, Expr exp2,Expr exp3)) = "substr(<toString(exp1)>,<toString(exp2)>,<toString(exp3)>)";
public str toString(StringFunction::upper(Expr exp)) = "upper(<toString(exp)>)";
public str toString(StringFunction::uCase(Expr exp)) = "ucase(<toString(exp)>)";
public str toString(StringFunction::lower(Expr exp)) = "lower(<toString(exp)>)";
public str toString(StringFunction::lCase(Expr exp)) = "lcase(<toString(exp)>)";
public str toString(StringFunction::left( Expr exp1,Expr exp2)) = "left(<toString(exp1)> , <toString(exp2)>)";   
public str toString(StringFunction::getJsonObject(Expr exp1, Expr exp2)) = "get_json_object(<toString(exp1)> , <toString(exp2)>)";
public str toString(StringFunction::char_len(Expr exp)) = "char_length(<toString(exp)> )";
public str toString(StringFunction::character_len(Expr exp)) = " character_length(<toString(exp)> )";
public str toString(StringFunction::concat_ws(Expr exp, list[Expr] e)) = "concat_ws(<toString(exp)><intercalate("",[",<toString(es)>"|es<-e])> )";    
public str toString(StringFunction::contains(Expr exp1, Expr exp2)) = "contains(<toString(exp1)> , <toString(exp2)>)";
public str toString(StringFunction::decodewithSearch(Expr exp, lrel[ Expr search,Expr result] exps , list[Expr] ex)) = "decode(<toString(exp)><intercalate("",["<toString(q.search)>,<toString(q.result)>"|q<-exps])>) <intercalate("",[",<toString(es)>"|es<-ex])>"; 
        // case elt(Expr exp, list[Expr] e)) = "elt(<toString(exp)><intercalate("",[",<toString(es)>"|es<-e])> )";        
public str toString(StringFunction::endsWith(Expr exp1, Expr exp2)) = "endswith(<toString(exp1)> , <toString(exp2)>)";       
public str toString(StringFunction::fis(Expr exp1, Expr exp2)) = "find_in_set(<toString(exp1)> , <toString(exp2)>)"; 
public str toString(StringFunction::fNumber(Expr exp1, Expr exp2)) = "format_number(<toString(exp1)> , <toString(exp2)>)";
public str toString(StringFunction::formatString(Expr exp, list[Expr] e)) = "format_string(<toString(exp)><intercalate("",[",<toString(es)>"|es<-e])> )";    
public str toString(StringFunction::initCap(Expr exp)) = "initcap(<toString(exp)> )";    
public str toString(StringFunction::leven(Expr exp1, Expr exp2,list[Expr] exps3)) = "levenshtein(<toString(exp1)>,<toString(exp2)><intercalate("",[",<toString(es)>"|es<-exps3])> )"; 
public str toString(StringFunction::locate(Expr exp1, Expr exp2,list[Expr] exps3)) = "locate(<toString(exp1)>,<toString(exp2)><intercalate("",[",<toString(es)>"|es<-exps3])>)";     
public str toString(StringFunction::lpad(Expr exp1, Expr exp2,list[Expr] exps3)) = "lpad(<toString(exp1)>,<toString(exp2)><intercalate("",[",<toString(es)>"|es<-exps3])>)"; 
public str toString(StringFunction::ltrim( Expr exp)) = "ltrim(<toString(exp)>)";    
public str toString(StringFunction::lhunCheck( Expr exp)) = "lhunCheck(<toString(exp)>)";
public str toString(StringFunction::mask(Expr exp, list[Expr] e)) = "mask(<toString(exp)><intercalate("",[",<toString(es)>"|es<-e])>) "; 
public str toString(StringFunction::oct_len( Expr exp)) = "octet_length(<toString(exp)>)";   
public str toString(StringFunction::overlay( Expr input, Expr replace, Expr pos,list[Expr] len )) = "overlay(<toString(input)>,<toString(replace)>,<toString(pos)><intercalate("",[",<toString(es)>"|es<-len])>)";   
public str toString(StringFunction::overlayWithSnippet( Expr input, Expr replace, Expr pos,list[Expr] len )) = "overlay(<toString(input)> placing <toString(replace)> from <toString(pos)> <intercalate("",["for <toString(es)>"|es<-len])>)";
public str toString(StringFunction::position( Expr input, Expr replace,list[Expr] len )) = "position(<toString(input)>,<toString(replace)><intercalate("",[",<toString(es)>"|es<-len])>)";
public str toString(StringFunction::replace( Expr input, Expr replace,list[Expr] len )) = "position(<toString(input)>,<toString(replace)><intercalate("",[",<toString(es)>"|es<-len])>)";    
public str toString(StringFunction::\right(Expr exp1, Expr exp2)) = "right(<toString(exp1)>,<toString(exp2)>)";  
public str toString(StringFunction::rtrim(Expr exp)) = "rtrim(<toString(exp)>)";
public str toString(StringFunction::space(Expr exp)) = "space(<toString(exp)>)";
public str toString(StringFunction::startsWith(Expr exp1, Expr exp2)) = "startswith(<toString(exp1)>,<toString(exp2)>)";
public str toString(StringFunction::substring_index(Expr exp1, Expr exp2, Expr exp3)) = "substring_index(<toString(exp1)>,<toString(exp2)>,<toString(exp3)>)";    
public str toString(StringFunction::trim(Expr exp)) = "trim(<toString(exp)>)";
public str toString(StringFunction::trimfrom(TrimDir tdir, From from)) = "trim(<toString(tdir)> <toString(from)>)";
public str toString(StringFunction::trimstr(list[TrimDir] tdirs,  Expr trimStr, From fromExp)) = "trim(<intercalate("",["<toString(es)>"|es<-tdirs])> <toString(trimStr)> <toString(fromExp)>)";  
public str toString(StringFunction::positionIn(Expr exp)) = "position(<toString(exp)>)";



public str toString(from(Expr e, list[NumericLiteral] numlit))= "FROM <toString(e)> <intercalate("",["for <toString(lit)>"|lit<-numlit])> ";

public str toString(TrimDir td){
    switch(td){
        case trail(): return "trailing";
        case lead():return "leading";
        case both(): return "both";
        default: throw "<td> not seen";
    }
}


public str toString(MapFunction::elementAt(Expr e1, Expr e2)) = "element_at(<toString(e1)>,<toString(e2)>)";
public str toString(MapFunction::\map(lrel[str id, Expr e] mapitems)) = "map( <intercalate("",["<mp.id>,<toString(mp.e)>"|mp<-mapitems])>)";
public str toString(MapFunction::concat(list[Expr] es)  ) = "map_concat(<intercalate("",[toString(mp)|mp<-es])>)"; 
public str toString(MapFunction::contain(Expr e1, Expr e2)) = "map_contains_key(<toString(e1)>,<toString(e2)>)";
public str toString(MapFunction::entries(Expr e)) = "map_entries(<toString(e)>)";   
public str toString(MapFunction::fromArrays(Expr e1, Expr e2)) = "map_from_arrays(<toString(e1)>,<toString(e2)>)";  
public str toString(MapFunction::fromEntries(Expr e)) = "map_from_entries(<toString(e)>)"; 
public str toString(MapFunction::keys(Expr e)) = "map_from_entries(<toString(e)>)"; 
public str toString(MapFunction::values(Expr e)) = "map_values(<toString(e)>)";
public str toString(MapFunction::strToMap(Expr e1, lrel[Expr e2, list[Expr] e3s]erel)) = "str_to_map(<toString(e1)> <intercalate("",[",<toString(r.e2)> <intercalate("",[toString(r1)|r1<-r.e3s])>"|r<-erel])> )"; 
public str toString(MapFunction::tryEl(Expr e1, Expr e2)) = "try_element_at(<toString(e1)>,<toString(e2)>)";



public str toString(Generator::explode( Expr expr)) = "explode(<toString(expr)>)";   
public str toString(Generator::ex_outer( Expr expr)) = "explode_outer(<toString(expr)>)";
public str toString(Generator::inline( list[Expr] exps)) = "inline(<intercalate(",",[toString(expr)|expr<-exps])>)";
public str toString(Generator::in_outer( Expr exp)) = "inline_outer(<toString(exp)>)";   
public str toString(Generator::posEx( Expr exp)) = "posexplode(<toString(exp)>)";        
public str toString(Generator::posEx_outer( Expr exp)) = "posexplode_outer(<toString(exp)>)";    
public str toString(Generator::stack( Expr exp, list[Expr] e)) = "stack(<toString(exp)>,<intercalate(",",[toString(expr)|expr<-e])>)";
