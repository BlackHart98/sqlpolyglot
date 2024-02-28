module spark::ast::Expressions


extend basesql::ast::BaseSQL;



// Expr
data Expr 
    = exist(Expr exp)
    | likeAll(Expr exp,list[Expr] exps)
    | notlikeAll(Expr exp,list[Expr] exps)
    | likeAny(Expr exp,list[Expr] exps)
    | notlikeAny(Expr exp,list[Expr] exps)
    | notlikeSome(Expr exp,list[Expr] exps)
    | likeSome(Expr exp,list[Expr] exps)
    | rlike(Expr lhs ,RLikeOrRegex rli , Expr rhs, EscapeEx escex)
    | simpleCase(list[Expr] exps,list[WhenClause] wcl,list[ElseClause] elseCls)
    | like(Expr lhs, Expr rhs, EscapeEx ex)
    | ilike(Expr lhs, Expr rhs, list[EscapeEx] exOpt)
    | match(Expr e, list[Case] cases, list[Default] d)
    | block(list[Expr] exprs) 
    | lambda (str arg, Expr exp)
    | function(FunctionCall functionCall)
    | optValue(OptionValue optionVal)
    ;


data RLikeOrRegex 
    = rLike()
    | regexp()
    ;

// DataType
data PrimitiveType 
    = byteType()
    | longType()
    | shortType()
    | numericType()
    | boolType()
    | timestampNTZType()
    | decType()
    | realType()
    ;




data EscapeEx = escape(Expr expr);


data CommentLiteral = comment(str comment);

data Array
  = array(list[Expr] expr)
  ;


data OptionValue 
    = none()
    | disk1()
    | disk2()
    | disk3()
    | memory1()
    | memory2()
    | memoryOnlyser()
    | memoryOnlyser2()
    | memAndDisk()
    | memoryAndDisk2()
    | memoryAndDiskSer()
    | memoryAndDiskSer2()
    | offHeap()
    ;

// Expr misc.
data Default
    = \default(Expr e)
    ;

data Case
    = \case( Expr e1, Expr e2)
    ;

// Function Call
data FunctionCall
  = inBuiltFunction(InBuiltFunction inBuiltFunction, list[AnalyticFunctionClause] analyticFunctionClauseOpt)
  | udf(list[PackageName] pkgName, str funcName, list[Expr] expr)
  ;

data Filter = \filter(WhereClause whereClause);

data AnalyticFunctionClause = analyticFunctionClause(WindowSpecification windowSpecification);

data InBuiltFunction
    = aggregateFunction(AggregateFunction aggregateFunction, list[Filter] filterOpt)
    | windowFunction(WindowFunction windowFunction)
    | conditionalFunction(ConditionalFunction conditionalFunction)
    | mathFunction(MathFunction mathFunction)
    | dateTimeFunction(DateTimeFunction dateTimeFunction)
    | stringFunction(StringFunction stringFunction)
    | conversionFunction(DataType dataType, Expr expr)
    | arrayFunction(ArrayFunction arrayFunction)
    | mapFunction(MapFunction mapFunction)
    // | jsonFunction(JSONFunction jsonFunction)
    // | bitwiseFunction(BitWiseFunction bitwiseFunction)
    | predicateFunction(Predicate predicate)
    | generatorFunction(Generator generator)
    // | csvFunction(CsvFunction csvFunction)
    | tvf(TableValued tableValued)
    ;



data MapFunction
    = elementAt(Expr e1, Expr e2)	
    | \map(lrel[str id, Expr e] mapitems)
    | concat(list[Expr] es)	
    | contain(Expr e1, Expr e2)
    | entries(Expr e)	
    | fromArrays(Expr e1, Expr e2)
    | fromEntries(Expr e)	
    | keys(Expr e)	
    | values(Expr e)
    | strToMap(Expr e1, lrel[Expr e2, list[Expr] e3s]erel)
    | tryEl(Expr e1, Expr e2)
    ;


data ConditionalFunction 
    = nvlFunction(Expr e1,Expr e2)
    | nvl2(Expr e1,Expr e2,Expr e3)
    | ifFunction(Expr e1,Expr e2,Expr e3)
    | coalesce(Expr e1,list[Expr] es)
    | ifNull(Expr e1,Expr e2)
    | nullIf(Expr e1,Expr e2)
    ;


data Literal
    = numeric( NumericLiteral numLit )
    | binary( str binLit) 
    // | @category="Constant" float: FloatLiteral realLiteral 
    | boolean(str booleanLiteral )
    | string(str stringLiteral )
    // | dateTime(DOT dot, Quote q1, DateTimeLiteral dateTimeLiteral, Quote q2)
    | interval(IntervalLiteral intervalLit )
    | nullLiteral()  
    | nilLiteral(str nillit) 
    ; 


data PartitionByOrDistributed 
    = partitionByClause(PartitionByClause partByCls)
    | distributed(Distributed dist)
    ;



data Distributed = distributed(list[Expr] exps);
  
data SortedByClause = sortBy( list[str] leftbr, list[SortedByElem] sbe ,list[str] rightbr)| sortedBy(  list[SortedByElem] sbe );

data Sort = sort()|sorted();

data SortedByElem = sortByElem(Expr exp, list[DirectionOrNUlls] dons);

data SortedByDirection = ascSorted()|descSorted();

data NullOption = ignore() | respect();


data WindowFunction
    = lead(Expr expr,  list[LeadLagOffSet] leadLagOffSet)
    | lag(Expr expr,  list[LeadLagOffSet] leadLagOffSet)
    | firstValue(Identifier identifier, list[CommaThenBoolean] commaThenBoolean)
    | lastValue(Identifier identifier, list[CommaThenBoolean] commaThenBoolean)
    ;


data LeadLagOffSet = leadLagOffSet(str \int,  list[LeadLagDefault] leadLagDefault);

data LeadLagDefault = leadLagDefault(Expr expr);

data CommaThenBoolean = commaThenBoolean(Boolean boolean);



data IntervalLiteral = withString(list[str] signs,  IntervalStringQualifier strandQualifier );

data Generator 
    =explode( Expr expr)	
    | ex_outer( Expr expr)
    | inline( list[Expr] exps)
    | in_outer( Expr exp)	
    | posEx( Expr exp)		
    | posEx_outer( Expr exp)	
    | stack( Expr exp, list[Expr] e)
    ;

 data IntervalStringQualifier 
    = ym( list[Quote] quote1, list[str] signs, YearMonthLiteral yrmlit,list[Quote] quote2, YearMonthIntervalQualifier ymiq)
    | dt(list[Quote] q1,list[str] signs,DayTimeLiteral dtlit,list[Quote] q2, DayTimeIntervalQualifier dtiq)
    ;
 
data Quote = quote();
data YearMonthLiteral = constructor(str year, list[str] month);
data DayTimeLiteral = dti(DayTimeInterval dti);

data DayTimeInterval =const(str day, lrel[str hour, lrel[str min ,lrel[str sec,str mil] second] mins] hours);




data YearMonthIntervalQualifier 
    = withTo(YearMonthField ytmf1,YearMonthField ytmf2)
    | withoutTo(YearMonthField ytmf)
    ;

data DayTimeIntervalQualifier 
    = withTo(DayTimeField dtf1, DayTimeField dtf2)
    | withoutTo(DayTimeField dtf)
    ;


data YearMonthField
= year()|month() ;

data DayTimeField= day() |hour() |minute()| second()
;
data Long =long()| bigInt();
data Float = float()|\real();
data Dec = decimal()| dec()| numeric();
data Int = abb()|full();
data Timestamp = timestamp() |ltz();


data ArrayFunction
    =  arrayFunc(list[Expr] exps)
    |struct(list[Expr] exps)
    |arrayAppend( Expr e1, Expr e2)
    |arrayCompact(Expr exp)
    | arrayContains( Expr e1, Expr e2)
    |arrayDistinct(Expr exp)
    |arrayExcept( Expr e1, Expr e2)
    |\insert( Expr e1, Expr e2, Expr e3)
    |intersect( Expr e1, Expr e2)
    |\join( Expr e1, Expr e2,list[Expr] exps)
    | arrayMax(Expr exp)
    | arrayMin(Expr exp)
    | arrayPos( Expr e1, Expr e2)
    | array_prepend( Expr e1, Expr e2)
    | array_remove( Expr e1, Expr e2)
    |  arrayRepeat( Expr e1, Expr e2)
    |union( Expr e1, Expr e2)
    | overlap( Expr e1, Expr e2)	
    |zip(Expr exp, list[Expr] exps)
    | flatten(Expr exp)
    | get( Expr e1, Expr e2)
    | sequence( Expr e1, Expr e2,Expr e3)
    | shuffle(Expr exp)
    | slice( Expr e1, Expr e2,Expr e3)
    | sort( Expr e1,list[Expr]  exps)
    ;


data AggregateFunction 
    = count(list[Distinct] distinct , StarOrExpr soe)
    | sum(list[Distinct] distinct , Expr exp)
    | max(list[Distinct] distinct,Expr exp)
    | min(list[Distinct] distinct,Expr exp)
    | avg( Expr exp)  //incomplete
    | \any(Expr exp)
    | apcd(Expr exp , list[NumericLiteral] numlits)
    | aprPer(Expr expr, NumericLiteral numlit , list[NumericLiteral] numlits)
    | bitand(Expr exp)
    | bitor(Expr exp)
    | bitxor(Expr exp)
    | bitmapConAg(Expr exp)
    | boa(Expr exp)
    | boolAnd(Expr exp)
    | boolOr(Expr exp)
    | collectList(Expr exp)
    | collect_set(Expr exp)
    | corr(Expr exp1,Expr exp2)
    | countIf(Expr exp)
    | Sketch(Expr exp, NumericLiteral numlit1,NumericLiteral numlit2,NumericLiteral numlit3)
    | variance(Expr exp)
    | varSamp(Expr exp)
    | varPop(Expr exp)
    | trySum(Expr exp)
    | tryAvg(Expr exp)
    | stdevs(Expr exp)
    | stdPop(Expr exp)
    | stdDev(Expr exp)
    | covarPop(Expr exp1,Expr exp2)
    | covarSamp(Expr exp1,Expr exp2)
    | every(Expr exp)
    | first(Expr exp,list[str] boolit, list[IgnoreNull] ignore)	
    | firstValue(Expr exp,list[str] boolit)	
    | orderedSet(Order ord, Expr lit,OrderByClause odbcl)
    | grouping(Expr exp)
    | histNum(Expr exp,NumericLiteral numlit)	
    | last(Expr exp,list[str] boolit, list[IgnoreNull] ignore)	
    | maxBy(list[Distinct] distinct,Expr exp)
    | mean(list[Distinct] distinct,Expr exp)
    | median(Expr exp)
    | minBy(list[Distinct] distinct,Expr exp)
    | mode(list[Distinct] distinct,Expr exp)
    | regAvgX(Expr x,Expr y)
    | regAvgY(Expr x,Expr y)
    | regCount(Expr x,Expr y)
    | regInt(Expr x,Expr y)	
    | regR2(Expr x,Expr y)	
    | regSlope(Expr x,Expr y)
    | regSXX(Expr x,Expr y)
    | regSXY(Expr x,Expr y)
    | regSYY(Expr x,Expr y)	
    | skew(Expr x)	
    | some(Expr x)	
    | std(Expr x)
    | arrayavg(Expr exp)
    | listagg(list[Distinct] distinct,Expr exp,list[Separator] sep)
    ;

 data Order = cont()|disc();



 data NumericLiteral
    = \int(str IntegerLiteral)
    | withoutExp(Decimal dec,list[str] prefix )
    ;  //return to complete

data TableValued=range(list[Expr] exps);
data Decimal = dec(list[str] signs, str number ,str decimal, list[str] decimal2);
data Separator = separator(Expr e);

data Distinct = distinct();

data IgnoreNull = ignoreNull();

data DateTimeFunction
    = toDate(Expr exp)
    | toUtcTimestamp(Expr exp1, Expr exp2)
    | fromUtcTimestamp(Expr exp1, Expr exp2)
    | fromUnixTimeTwoParam(Expr exp1, Expr exp2)
    | unixTimestampNoParam()
    | unixTimestampOneParam(Expr exp)
    | unixTimestampTwoParam(Expr exp1, Expr exp2)
    | dateSub(Expr exp1, Expr exp2)
    | dateAdd(Expr exp1, Expr exp2)
    | dateDiff(Expr exp1, Expr exp2)
    | currentTimeStamp()
    | currentDate()
    | monthsBetween(Expr exp1, Expr exp2)
    | month(Expr exp)
    | year(Expr exp)
    | addMonths(Expr exp1, Expr exp2)
    ;


data From = from(Expr, list[NumericLiteral] numlit);


data MathFunction
    = ceilFunction(list[Expr] exps)
    | ceilingFunction(list[Expr] exps)
    | exponent(Expr exp)
    | hex(Expr exp)
    | unhex(Expr exp)
    | div(Expr exp1, Expr exp2)
    ;


data StringFunction
    = ascii(Expr exp)
    | regExpReplace(Expr exp1, Expr exp2,Expr exp3)
    | base64(Expr exp)
    | btrim(Expr exp, list[Expr] e)
    | blen(Expr exp)
    | encode(Expr exp1, Expr exp2)
    | decode(Expr exp1, Expr exp2)
    | char(Expr exp)
    | chr(Expr exp)
    | length(Expr exp)
    | len(Expr exp)
    | concat(Expr exp, list[Expr] e)
    | instr(Expr exp1, Expr exp2)
    | substring(Expr exp1, Expr exp2)
    | substringWithEnd(Expr exp1, Expr exp2,Expr exp3)
    | substr(Expr exp1, Expr exp2)
    | substrfrom(Expr exp, From fr)
    | substringfrom(Expr exp, From fr)
    | substrWithEnd(Expr exp1, Expr exp2,Expr exp3)
    | upper(Expr exp)
    | uCase(Expr exp)
    | lower(Expr exp)
    | lCase(Expr exp)
    | left( Expr exp1,Expr exp2)	
    | getJsonObject(Expr exp1, Expr exp2)
    | char_len(Expr exp)
    | character_len(Expr exp)
    | concat_ws(Expr exp, list[Expr] e)	
    | contains(Expr exp1, Expr exp2)
    | decodewithSearch(Expr exp, lrel[ Expr search,Expr result] exps , list[Expr] ex) 
    | elt(Expr exp, list[Expr] e)		
    | endsWith(Expr exp1, Expr exp2)		
    | fis(Expr exp1, Expr exp2)	
    | fNumber(Expr exp1, Expr exp2)
    | formatString(Expr exp, list[Expr] e)	
    | initCap(Expr exp)	
    |leven(Expr exp1, Expr exp2,list[Expr] exps3)	
    | locate(Expr exp1, Expr exp2,list[Expr] exps3)		
    | lpad(Expr exp1, Expr exp2,list[Expr] exps3)	
    | ltrim( Expr exp)	
    | lhunCheck( Expr exp)
    | mask(Expr exp, list[Expr] e)	
    | oct_len( Expr exp)	
    | overlay( Expr input, Expr replace, Expr pos,list[Expr] len )	
    | overlayWithSnippet( Expr input, Expr replace, Expr pos,list[Expr] len )
    | position( Expr input, Expr replace,list[Expr] len )
    | replace( Expr input, Expr replace,list[Expr] len )	
    | \right(Expr exp1, Expr exp2)		
    | rtrim(Expr exp)
    |space(Expr exp)
    |startsWith(Expr exp1, Expr exp2)
    |substring_index(Expr exp1, Expr exp2, Expr exp3)	
    |trim(Expr exp)
    |trimfrom(TrimDir tdir, From from)
    |trimstr(list[TrimDir] tdirs,  Expr trimStr, From fromExp)	
    |positionIn(Expr exp)
    ;


data Predicate
    = ilikeF(Expr exp1,Expr exp2)
    |likeF(Expr exp1,Expr exp2)
    |regExp(Expr exp1,Expr exp2)
    | rlikeF(Expr exp1,Expr exp2)
    |\in(Expr exp1,list[Expr] exprs2)
    ;

data DirectionOrNUlls 
    = asc()
    | desc()
    | first()
    | last()
    ;

data TrimDir = trail()| lead()|both();