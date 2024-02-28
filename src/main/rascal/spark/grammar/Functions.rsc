module spark::grammar::Functions


extend spark::grammar::Expressions;

syntax TableIdOrSubquery 
    = tableIdOrSubquerySubquery: "(" Query ")"'AS' Identifier
    | tableId: TableName 'AS' Identifier
    ; 


syntax Expr = function: FunctionCall;
syntax FunctionCall = inBuiltFunction: InBuiltFunction AnalyticFunctionClause?;
syntax CommonValueExpr = functionCVE: FunctionCall;

syntax FunctionCall 
    = udf: PackageName? FUNCTIONNAME"(" {Expr ","}* ")"
    ;


syntax AnalyticFunctionClause = analyticFunctionClause: 'OVER' WindowSpecification;

syntax InBuiltFunction
    = aggregateFunction: AggregateFunction Filter?
    | windowFunction: WindowFunction
    | conditionalFunction: ConditionalFunction
    | mathFunction: MathFunction
    | dateTimeFunction: DateTimeFunction
    | stringFunction: StringFunction
    | conversionFunction: DataType "(" Expr")"
    | arrayFunction:ArrayFunction
    | mapFunction : MapFunction
    | jsonFunction:JSONFunction
    | bitwiseFunction:BitWiseFunction
    | predicateFunction:Predicate
    | generatorFunction:Generator
    | csvFunction: CsvFunction
    | tvf: TableValued
    ;

// 


syntax OrderByOrSortedBy 
    = orderByClause: OrderByClause
    | sortByClause: SortedByClause
    ;


syntax PartitionByOrDistributed 
    = partitionByClause: PartitionByClause
    | distributed: Distributed
    ;

syntax Distributed = distributed: 'DISTRIBUTE' 'BY' { Expr "," }+;

syntax NullOption 
    = ignore: 'IGNORE' 'NULLS' 
    | respect:'RESPECT' 'NULLS'
    ;
syntax Filter =\filter :'FILTER'"("WhereClause")";

syntax AggregateFunction
    = count: 'COUNT'"("Distinct? StarOrExpr")"
    |  \any: "any" "(" Expr")"
    | anyVal:"any_value" "(" Expr (","Boolean)? ")"
    | apcd: "approx_count_distinct" "(" Expr ( "," Number)? ")"
    | aprPer: "approx_percentile""("Expr "," Number ("," Number)?")"
    | bitand: 'bit_and' "("Expr")"
    | bitor: 'bit_or' "("Expr")"
    | bitxor: 'bit_xor' "("Expr")"
    | bitmapConAg: 'bitmap_construct_agg' "("Expr ")"
    |boa : 'bitmap_or_agg' "("Expr ")"
    | boolAnd: 'bool_and' "("Expr ")"
    | boolOr: 'bool_or' "("Expr ")"
    | collectList: 'collect_list' "("Expr ")"
    | collect_set :'collect_set' "("Expr ")"
    | corr: 'corr' "("Expr exp1 ","Expr exp2 ")"
    | countIf: 'count_if' "("Expr ")"
    | countminSketch: 'count_min_sketch'"(" Expr "," Number "," Number", "Number ")"
    | variance: 'variance' "("Expr ")"
    | varSamp: 'var_samp' "("Expr ")"
    | varPop: 'var_pop' "("Expr ")"
    |trySum: 'try_sum' "("Expr ")"
    | tryAvg: 'try_avg' "("Expr ")"
    |stdevs: 'stddev_samp' "("Expr ")"
    |stdPop: 'stddev_pop' "("Expr ")"
    |stdDev:'stddev' "("Expr ")"
    | covarPop: 'cov ar_pop' "("Expr exp1 "," Expr exp2 ")"
    | covarSamp: 'covar_samp' "("Expr exp1 "," Expr exp2 ")"	
    | every: 'every'"("Expr ")"	
    // | first:'first'"("Expr ("," Boolean)? IgnoreNull? ")"	
    // | orderedSet:Order"("Expr")" 'WITHIN' 'Group' "("OrderByClause")" 
    |grouping:'grouping'"("Expr ")"	
    |histNum: 'histogram_numeric'"("Expr exp ","Number ")"	
    // |last: 'last'"("Expr ("," Boolean)? IgnoreNull? ")"	
    | maxBy: 'MAX_BY'"("Distinct? Expr")"
    | mean: 'MEAN'"("Distinct? Expr")"
    |median: 'median'"("Expr ")"
    | minBy: 'MIN_BY'"("Distinct? Expr")"
    | mode: 'MODE'"("Distinct? Expr")"
    |regAvgX: 'regr_avgx'"("Expr x "," Expr y ")"
    |regAvgY: 'regr_avgy'"("Expr x "," Expr y ")"
    |regCount: 'regr_count'"("Expr x "," Expr y ")"
    |regInt: 'regr_intercept'"("Expr x "," Expr y ")"	
    | regR2: 'regr_r2'"("Expr x "," Expr y ")"	
    |regSlope: 'regr_slope'"("Expr x "," Expr y ")"
    |regSXX: 'regr_sxx'"("Expr x "," Expr y ")"	
    |regSXY: 'regr_sxy'"("Expr x "," Expr y ")"	
    | regSYY: 'regr_syy'"("Expr x "," Expr y ")"	
    |skew: 'skewness'"("Expr ")"	
    |some: 'some'"("Expr ")"	
    |std: 'std'"("Expr ")"
    | min: 'MIN'"("Distinct? Expr")"
    | max: 'MAX'"("Distinct? Expr ")"
    | sum: 'SUM'"(" Distinct? Expr ")"
    | avg: 'AVG'"(" Expr")"
    | arrayavg: 'ARRAY_AGG'"(" Expr")"
    // | listagg: 'LISTAGG'"("Distinct? Expr Separator?")"
    ;



syntax DateTimeFunction
    = toDate: 'TO_DATE'"("Expr")"
    | toUtcTimestamp: 'TO_UTC_TIMESTAMP'"("Expr "," Expr")"
    | fromUtcTimestamp: 'FROM_UTC_TIMESTAMP'"("Expr "," Expr")"
    | fromUnixTimeTwoParam: 'FROM_UNIXTIME'"("Expr "," Expr")"
    | unixTimestampNoParam: 'UNIX_TIMESTAMP'"("")"
    | unixTimestampOneParam: 'UNIX_TIMESTAMP'"("Expr")"
    | unixTimestampTwoParam: 'UNIX_TIMESTAMP'"("Expr "," Expr")"
    | dateSub: 'DATE_SUB'"("Expr "," Expr")"
    | dateAdd: 'DATE_ADD'"("Expr "," Expr")"
    | dateDiff: 'DATEDIFF'"("Expr "," Expr")"
    | currentTimeStamp: 'CURRENT_TIMESTAMP'"("")"
    | currentDate: 'CURRENT_DATE'"("")"
    | monthsBetween: 'MONTHS_BETWEEN'"("Expr","Expr")"
    | month: 'MONTH'"("Expr")"
    | year: 'YEAR'"("Expr")"
    | addMonths: 'ADD_MONTHS'"("Expr","Expr")"
    ;


syntax StringFunction
    = ascii:'ascii' "(" Expr ")"
    | regExpReplace: 'REGEXP_REPLACE'"("Expr","Expr","Expr")"
    | base64:'base64'"("Expr")"
    | btrim:'btrim'"("Expr string ("," Expr)?")"
    | blen: 'bit_length'"("Expr")"
    | encode: 'encode'"("Expr "," Expr ds")"
    | decode: 'decode'"("Expr "," Expr ds")"
    | char: 'char'"("Expr")"
    | chr: 'chr'"("Expr")"
    | length: 'LENGTH'"("Expr")"
    | len: 'LEN'"("Expr")"
    | concat: 'CONCAT'"("Expr","{Expr ","}+")"
    | instr: 'INSTR'"("Expr","Expr")"
    | substring: 'SUBSTRING'"("Expr","Expr")"
    | substringWithEnd: 'SUBSTRING'"("Expr","Expr","Expr")"
    | substr: 'SUBSTR'"("Expr","Expr")"
    | substrfrom:'SUBSTR'"("Expr From ")"
    | substringfrom:'SUBSTRING'"("Expr From ")"
    | substrWithEnd: 'SUBSTR'"("Expr","Expr","Expr")"
    | upper: 'UPPER'"("Expr")"
    | uCase: 'UCASE'"("Expr")"
    | lower: 'LOWER'"("Expr")"
    | lCase: 'LCASE'"("Expr")"
    | getJsonObject: 'GET_JSON_OBJECT'"("Expr","Expr")"
    | char_len: 'char_length'"("Expr")"
    | character_len:'character_length'"("Expr")"	
    |concat_ws: 'concat_ws' "("Expr sep ("," Expr)*")"	
    | contains:'contains'"(" Expr left ","Expr right")"	
    |decodewithSearch: 'decode'"("Expr expr("," Expr search","Expr result)+ (","Expr)?")" 
    |elt: 'elt'"(" Expr n ("," Expr input)+ ")"	
    | endsWith:'endswith'"(" Expr left ","Expr right")"		
    | fis:'find_in_set'"(" Expr left ","Expr right")"	
    | fNumber:'format_number'"(" Expr left ","Expr right")"	
    | formatString:'format_string'"("Expr ("," Expr)+")"	
    | initCap: 'initcap'"(" Expr ")"	
    |left:'left'"(" Expr "," Expr len")"	
    |leven:'levenshtein'"(" Expr str1"," Expr str2("," Expr threshold)?")"	
    | locate:'locate'"(" Expr substr "," Expr ("," Expr pos)?")"	
    | lpad:'lpad'	"(" Expr substr "," Expr ("," Expr pos)?")"
    | ltrim:'ltrim'"(" Expr ")"	
    | lhunCheck:'luhn_check'"(" Expr string ")"	
    | mask: 'mask'"(" Expr input ("," Expr upperChar)* ")"	
    | oct_len: 'octet_length'"(" Expr expr")"	
    | overlay:'overlay'"(" Expr input"," Expr replace"," Expr pos ("," Expr len)?")"	
    | overlayWithSnippet: 'overlay''(' Expr input 'PLACING' Expr replacing 'FROM' Expr pos ('FOR' Expr len)? ')'
    | position:'position'"("Expr substr"," Expr string ("," Expr pos)?")"	
    | positionIn:'position'"("Expr inExp")"	
    | replace:'replace'"(" Expr string"," Expr search("," Expr rep)?")"	
    | \right:'right'"(" Expr string","Expr len")"	
    | rtrim:'rtrim'"(" Expr string")"	
    |space:'space'"(" Expr n")"		
    |startsWith:'startswith'"(" Expr left"," Expr right")"	
    |substring_index:'substring_index'"(" Expr string "," Expr  delim"," Expr count")"	
    |trim:'trim'"("Expr")"	
    |trimfrom:'trim'"(" TrimDir  From")"	
    |trimstr:'trim'"(" TrimDir?  Expr trimStr From ")"	
    ;

syntax TrimDir =trail:'TRAILING' |lead:'LEADING' |both:  'BOTH';

syntax From =from: 'from' Expr ('For' Number)?;
syntax ConditionalFunction
    = nvlFunction: 'NVL'"("Expr","Expr")"
    | nvl2:'nvl2'"("Expr"," Expr"," Expr")"
    | ifFunction: 'IF'"("Expr"," Expr"," Expr")"
    | coalesce: 'COALESCE'"("Expr","{Expr ","}+")"
    | ifNull: 'ifnull' "(" Expr expr1 Expr expr2 ")"
    | nullIf: 'nullif'"(" Expr expr1 Expr expr2 ")"
    ;


syntax MathFunction
    = ceilFunction: 'CEIL'"("{Expr ","}+")" 
    | ceilingFunction: 'CEILING'"("{Expr ","}+")"
    | exponent: 'EXP'"("Expr")" 
    | hex: 'hex'"("Expr ")"
    | unhex: 'unhex'"("Expr ")"
    | div: Expr 'div' Expr
    ;

syntax WindowFunction
    = lead: 'LEAD'"("Expr LeadLagOffSet?")"
    | lag: 'LAG'"("Expr LeadLagOffSet?")"
    | firstValue: 'FIRST_VALUE'"("Identifier ("," Literal)?")"
    | lastValue: 'LAST_VALUE'"("Identifier  ("," Literal)?")"
    | cumeDist:'cume_dist'"()"
    | dense:'dense_rank'"()"	
    | nthValue:'nth_value'"("Expr input (","Expr offset)?")"	
    | ntile:"ntile""("Expr")"
    | percentRank:'percent_rank'"()"	
    | rank:'rank'"()"	
    | rowNumber: 'row_number'"()"	
    | aggregateFunction: AggregateFunction
    ;


syntax LeadLagOffSet = leadLagOffSet: "," Number LeadLagDefault?;

syntax LeadLagDefault = leadLagDefault: ","Expr;

syntax CommaThenBoolean = commaThenBoolean: ","Expr;




syntax ArrayFunction 
    = arrayFunc: 'array'"(" {Expr ","}+")" 
    |struct: 'struct'"(" {Expr ","}+")"
    |arrayAppend:'array_append'"(" Expr"," Expr")"
    |arrayCompact:'array_compact'"("Expr")"
    | arrayContains:'array_contains'"("Expr","Expr")"
    |arrayDistinct:'array_distinct'"("Expr")"
    |arrayExcept: 'array_except'"("Expr array1"," Expr array2")"
    |\insert:'array_insert'"("Expr ","Expr "," Expr")"
    |intersect:'array_intersect'"(" Expr array1"," Expr array2")"
    |\join:'array_join'"("Expr"," Expr","(','Expr)? ")"
    | arrayMax:'array_max'"("Expr")"
    | arrayMin:'array_min'"("Expr")"
    | arrayPos: 'array_position'"("Expr"," Expr")"
    | array_prepend:'array_prepend'"("Expr"," Expr")"	
    | array_remove:'array_remove'"("Expr"," Expr")"
    |  arrayRepeat:'array_repeat'"("Expr"," Expr")"
    |union:'array_union'"("Expr"," Expr")"	
    | overlap:'arrays_overlap'"("Expr"," Expr")"	
    |zip:'arrays_zip'"("Expr"," {Expr ","}+ ")"	
    | flatten:'flatten'"("Expr")"	
    | get:'get'"("Expr"," Expr")"
    | sequence: 'sequence'"("Expr"," Expr "," Expr")"
    | shuffle: 'shuffle'"("Expr")"	
    | slice :'slice'"("Expr"," Expr"," Expr")"
    | sort :'sort_array'"("Expr ("," Expr)")"
    ;

syntax MapFunction 
    = elementAt: 'element_at'"("Expr"," Expr")"	
    | \map:'map'"("(Identifier"," Expr)+")"
    | concat:'map_concat'"("{Expr ","}+")"	
    | contain:'map_contains_key'"("Expr"," Expr")"
    | entries: 'map_entries'"("Expr")"	
    | fromArrays:'map_from_arrays'"("Expr"," Expr")"	
    | fromEntries:'map_from_entries'"("Expr")"	
    | keys: 'map_keys'"("Expr")"	
    | values:'map_values'"("Expr")"	
    | strToMap:'str_to_map'"("Expr ("," Expr("," Expr)?)? ")"	
    | tryEl:'try_element_at'"("Expr"," Expr")"	
    ;


syntax JSONFunction =
from:'from_json'"("Expr"," Expr("," Expr)?")"	
|getJson:'get_json_object'"("Expr"," Expr")"	
| arrlen: 'json_array_length'"(" Expr jsonArray")"	
| objectKeys: 'json_object_keys'"(" Expr json_object")"	
// | \tuple: 'json_tuple'"("Expr"," {Expr ","}+ ps")"	
| soj: 'schema_of_json'"(" Expr("," Expr)?")"
| toJson:'to_json'"("Expr("," Expr)?")"
;

syntax BitWiseFunction =
and:Expr expr1 "&"  Expr expr2	
| xor: Expr expr1 "^" Expr expr2	
| count: 'bit_count'"(" Expr expr")"	
| bitGet:'bit_get'"(" Expr expr","  Expr pos ")"	
 | getbit:'getbit'"(" Expr expr","  Expr pos ")"		
| shiftright: 'shiftright'"(" Expr base"," Expr expr")"	
|sru:'shiftrightunsigned'"(" Expr base"," Expr expr")"		
|or: Expr expr1 "|" Expr expr2	
|not:"~" Expr expr	
;



syntax CsvFunction =fromCsv:'from_csv'"(" Expr csvStr"," Expr schema("," Expr options)?")"	
| soc: 'schema_of_csv'"(" Expr("," Expr)?")"
|toCsv: 'to_csv'"("Expr("," Expr)?")";


syntax Predicate=
 ilikeF:'ilike'"("Expr","Expr")"
 |likeF:'like'"("Expr","Expr")"
 |regExp:'regexp'"("Expr","Expr")"
 | rlikeF: 'rlike'"("Expr","Expr")"
 |\in: Expr 'in'"("{Expr ","}+")" 
 ;

 syntax TableValued =
 range: 'range'"("{Expr ","}+")" ;

 syntax Generator =
 explode :'explode'"(" Expr expr")"	
| ex_outer:'explode_outer'"(" Expr expr")"	
| inline:'inline'"(" {Expr ","}+ ")"	
| in_outer:'inline_outer'"(" Expr expr")"	
| posEx: 'posexplode'"(" Expr expr")"	
| posEx_outer:'posexplode_outer'"(" Expr expr")"	
| stack:'stack'"(" Expr n"," {Expr ","}+ ")";