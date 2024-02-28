module basesql::prettyprint::Expressions

import basesql::ast::BaseSQL;
import List;
// import Prelude;

extend basesql::prettyprint::Names;

// Expressions
public str toString(Expr::propRef(list[Identifier] ids)) = "<intercalate(".", [ toString(id) | id <- ids ])>";
public str toString(Expr::integer(str \int)) = "<\int>";
public str toString(Expr::long(str \int)) = "<\int>";
public str toString(Expr::decimal(str decim)) = "<decim>";
public str toString(Expr::illegalNull()) = "null";
public str toString(Expr::string(str strConst)) = "<strConst>";
public str toString(Expr::\true()) = "TRUE";
public str toString(Expr::\false()) = "FALSE";
public str toString(Expr::mapLit(list[MapEntry] mapEnts)) = "MAP( <intercalate(",", [ toString(entry) | entry <- mapEnts])> )";
public str toString(Expr::date(str strConst)) = "DATE <strConst>";
public str toString(Expr::time(str strConst)) = "TIME <strConst>";
public str toString(Expr::timeStamp(str strConst)) = "TIMESTAMP <strConst>";
public str toString(Expr::uMin(Expr exp)) = "-<toString(exp)>";
public str toString(Expr::cast(Expr exp, DataType dt)) = "CAST ( <toString(exp)> AS <toString(dt)> )";
public str toString(Expr::cct(Expr exp1, Expr exp2)) = "(<toString(exp1)> || <toString(exp2)>)";
public str toString(Expr::mul(Expr exp1, Expr exp2)) = "(<toString(exp1)> * <toString(exp2)>)";
public str toString(Expr::div(Expr exp1, Expr exp2)) = "(<toString(exp1)> / <toString(exp2)>)";
public str toString(Expr::modulus(Expr exp1, Expr exp2)) = "(<toString(exp1)> % <toString(exp2)>)";
public str toString(Expr::sub(Expr exp1, Expr exp2)) = "(<toString(exp1)> - <toString(exp2)>)";
public str toString(Expr::add(Expr exp1, Expr exp2)) = "<toString(exp1)> + <toString(exp2)>";
public str toString(Expr::eq(Expr exp1, Expr exp2)) = "(<toString(exp1)> = <toString(exp2)>)";
public str toString(Expr::twoEqual(Expr exp1, Expr exp2)) = "(<toString(exp1)> == <toString(exp2)>)";
public str toString(Expr::gt(Expr exp1, Expr exp2)) = "(<toString(exp1)> \> <toString(exp2)>)";
public str toString(Expr::lt(Expr exp1, Expr exp2)) = "(<toString(exp1)> \< <toString(exp2)>)";
public str toString(Expr::gte(Expr exp1, Expr exp2)) = "(<toString(exp1)> \>= <toString(exp2)>)";
public str toString(Expr::lte(Expr exp1, Expr exp2)) = "(<toString(exp1)> \<= <toString(exp2)>)";
public str toString(Expr::nullSafeEqual(Expr exp1, Expr exp2)) = "(<toString(exp1)> \<=\> <toString(exp2)>)";
public str toString(Expr::neq1(Expr exp1, Expr exp2)) = "(<toString(exp1)> != <toString(exp2)>)";
public str toString(Expr::neq2(Expr exp1, Expr exp2)) = "(<toString(exp1)> \<\> <toString(exp2)>)";
public str toString(Expr::like(Expr exp1, Expr exp2)) = "(<toString(exp1)> LIKE <toString(exp2)>)";
public str toString(Expr::inPredicate(Expr exp, list[Not] not, ArrayLiteral arrLtrl)) = "(<toString(exp)> <prettyOptional(not, prettyNot)> IN <toString(arrLtrl)>)";
public str toString(Expr::between(Expr exp1, Expr expCVE1, Expr expCVE2)) = "(<toString(exp1)> BETWEEN <toString(expCVE1)> AND <toString(expCVE2)>)";
public str toString(Expr::isNull(Expr exp)) = "(<toString(exp)> IS NULL)";
public str toString(Expr::isNotNull(Expr exp)) = "(<toString(exp)> IS NOT NULL)";
public str toString(Expr::not(Expr exp)) = "(NOT <toString(exp)>)";
public str toString(Expr::and(Expr exp1, Expr exp2)) = "(<toString(exp1)> AND <toString(exp2)>)";
public str toString(Expr::or(Expr exp1, Expr exp2)) = "(<toString(exp1)> OR <toString(exp2)>)";
public str toString(
  Expr::simpleCase(
    Expr expr
    , list[WhenClause] whenCls
    , list[ElseClause] elseClsOpt
  )
) = "(CASE <toString(expr)> 
    '      <intercalate("\n", [ toString(whenClause) | whenClause <- whenCls])>
    '      <prettyOptional(elseClsOpt, toString)> 
    'END)";
public str toString(Expr::searchedCase(list[WhenClause] whenCls, list[ElseClause] elseCls)) = "(CASE <intercalate("\n", [ toString(whenClause) | whenClause <- whenCls])> 
                                                                                                '      <prettyOptional(elseCls, toString)> 
                                                                                                'END)";
public str toString(Expr::interval(str strConst, Duration dur)) = "INTERVAL <strConst> <toString(dur)>";

// ExpAsVar
public str toString(
  ExpAsVar::expAsVar(
    Expr exp
    , list[VarAssign] varAssign 
  )
) = "<toString(exp)>" + "<prettyOptional(varAssign, toString)>";
public str toString(
  ExpAsVar::namedStructExp(
    list[NamedStructEntry] namedStructEntries
    , list[VarAssign] varAssign 
  )
) = "NAMED_STRUCT(<intercalate(",", [ toString(entry) | entry <- namedStructEntries] )>) <prettyOptional(varAssign, toString)>";

// NamedStructEntry
public str toString(
  NamedStructEntry::namedStructEntry(
    str quotedId, Expr expr
  )
) = "<quotedId>, <toString(expr)>";

// ExpAsVarOrStar
public str prettyExpAsVarOrStar(
  ExpAsVarOrStar::projectionExpAsVar(
    ExpAsVar expAsVar
  )
) = "<toString(expAsVar)>";

public str prettyExpAsVarOrStar(
  ExpAsVarOrStar::tableNameDotStar(
    TableName tblName
  )
) = "<toString(tblName)>.*";

public str prettyExpAsVarOrStar(
  ExpAsVarOrStar::projectionStar()
) = "*";

// Boolean
public str toString(Boolean::\true()) = "TRUE";
public str toString(Boolean::\false()) = "FALSE";

// Duration 
public str toString(Duration dur) {
  switch(dur) {
    case year(): return "YEAR";
    case month(): return "MONTH"; // TODO: Ask Pius if there's no week
    case day(): return "DAY";
    case hour(): return "HOUR";
    case minute(): return "MINUTE";
    case second(): return "SECOND";
  }
  return "";
}

// Not
public str prettyNot(Not::not()) = "NOT";

// WhenClause
public str toString(
  WhenClause::whenClause(
    Expr expr1
    , Expr expr2
  )
) = "WHEN <toString(expr1)> THEN <toString(expr2)>";

// ElseClause
public str toString(ElseClause::elseClause(Expr expr)) = "ELSE <toString(expr)>";

// ArrayLiteral
public str toString(
  ArrayLiteral::array(list[Expr] exprs
)) = "(<intercalate(",", [ toString(exp) | exp <- exprs])>)";

// MapEntry
public str toString(
  MapEntry::mapEntry(
    Expr expr1
    , Expr expr2
  )
) = "<toString(expr1)>, <toString(expr2)>";

// DataType
public str toString(DataType::primitiveType(PrimitiveType pType)) = "<toString(pType)>";
public str toString(DataType::arrayType(DataType dType)) = "ARRAY \<<toString(dType)>\>";
public str toString(DataType::mapType(PrimitiveType pType, DataType dType)) = "MAP \<<toString(pType)>, <toString(dType)>\>";
public str toString(DataType::structType(list[StructTypeFieldSpec] structList)) = "STRUCT [<intercalate(",", [ toString(structItem) | structItem <- structList])>]";
public str toString(DataType::unionType(list[DataType] dTypeList)) = "UNIONTYPE \<<intercalate(",", [toString(dt) | dt <- dTypeList])>\>";

// PrimitiveType
public str toString(PrimitiveType pType) {
  switch(pType) {
    case intType(): return "INT";
    case smallIntType(): return "SMALLINT";
    case bigIntType(): return "BIGINT";
    case tinyIntType(): return "TINYINT";
    case booleanType(): return "BOOLEAN";
    case floatType(): return "FLOAT";
    case doubleType(): return "DOUBLE";
    case doubleWithPrecisionType(): return "DOUBLE PRECISION";
    case stringType(): return "STRING";
    case binaryType(): return "BINARY";
    case timestampType(): return "TIMESTAMP";
    case decimalType(list[TwoParameterSpec] twoParamSpec): return "DECIMAL" + "<prettyOptional(twoParamSpec, toString)>";
    case dateType(): return "DATE";
    case varCharType(list[SingleParameterSpec] singleParamSpec): return "VARCHAR" + "<prettyOptional(singleParamSpec, toString)>";
    case charType(list[SingleParameterSpec] singleParamSpec): return "CHAR" + "<prettyOptional(singleParamSpec, toString)>";
  }
  return "";
}

// TwoParameterSpec
public str toString(TwoParameterSpec::twoParameterSpec(str num1, str num2)) = "(<num1>, <num2>)";

// SingleParameterSpec
public str toString(SingleParameterSpec::singleParameterSpec(str num1)) = "(<num1>)";

// StructTypeFieldSpec
public str toString(StructTypeFieldSpec::structTypefieldSpec(Identifier id, DataType dt)) = "<toString(id)> : <toString(dt)>";

// Distinct
public str toString(Distinct::aggregateDistinct()) = "DISTINCT";

// StarOrExpr
public str toString(StarOrExpr::aggExpr(Expr exp)) = "<toString(exp)>";
public str toString(StarOrExpr::star()) = "*";


