module spark::grammar::Expressions

extend spark::grammar::Names;

syntax Expr 
    = setIndex: Expr "{" Expr index "}"
    > mapIndex: Expr".get" "(" Expr key ")"
    > not: "!" Expr
    > exist: 'EXISTS' Expr
    > non-assoc  like: Expr lhs 'LIKE' Expr rhs EscapeEx
    > non-assoc  like: Expr  RLikeOrRegex Expr  EscapeEx
    > non-assoc  notlike: Expr lhs 'NOT' 'LIKE' Expr rhs
    > non-assoc  ilike: Expr 'ILIKE' Expr EscapeEx?
    > non-assoc  likeAll: Expr lhs 'LIKE' 'ALL' "("{Expr ","}+")" 
    > non-assoc  notlikeAll: Expr lhs 'NOT' 'LIKE' 'ALL' "("{Expr ","}+")" 
    > non-assoc  likeAny: Expr lhs 'LIKE' 'ANY' "("{Expr ","}+")" 
    > non-assoc  notlikeAny: Expr lhs 'NOT' 'LIKE' 'ANY' "("{Expr ","}+")" 
    > non-assoc  likeSome: Expr 'LIKE' 'SOME' "("{Expr ","}+")" 
    > non-assoc  notlikeSome: Expr 'NOT' 'LIKE' 'SOME' "("{Expr ","}+")" 
    > non-assoc lambda: Identifier arg "=\>" Expr expr
    > non-assoc optValue: OptionValue
    > non-assoc @Foldable match: "(" Expr e ")" 'MATCH' "{" Case+ cases Default? d "}"  
    ;

// syntax Expr = mapIndex: Expr".get" "(" Expr key ")";
// syntax Expr = not: "!" Expr;
// syntax Expr = exist: 'EXISTS' Expr;
// syntax Expr = non-assoc  like: Expr lhs 'LIKE' Expr rhs EscapeEx;
// syntax Expr = non-assoc  like: Expr  RLikeOrRegex Expr  EscapeEx;
// syntax Expr = non-assoc  notlike: Expr lhs 'NOT' 'LIKE' Expr rhs;
// syntax Expr = non-assoc  ilike: Expr 'ILIKE' Expr EscapeEx?;
// syntax Expr = non-assoc  likeAll: Expr lhs 'LIKE' 'ALL' "("{Expr ","}+")" ;
// syntax Expr = non-assoc  notlikeAll: Expr lhs 'NOT' 'LIKE' 'ALL' "("{Expr ","}+")" ;
// syntax Expr = non-assoc  likeAny: Expr lhs 'LIKE' 'ANY' "("{Expr ","}+")" ;
// syntax Expr = non-assoc  notlikeAny: Expr lhs 'NOT' 'LIKE' 'ANY' "("{Expr ","}+")" ;
// syntax Expr = non-assoc  likeSome: Expr 'LIKE' 'SOME' "("{Expr ","}+")" ;
// syntax Expr = non-assoc  notlikeSome: Expr 'NOT' 'LIKE' 'SOME' "("{Expr ","}+")" ;
// syntax Expr = non-assoc lambda: Identifier arg "=\>" Expr expr;
// syntax Expr = non-assoc optValue: OptionValue;
// syntax Expr = non-assoc @Foldable match: "(" Expr e ")" 'MATCH' "{" Case+ cases Default? d "}";

syntax RLikeOrRegex 
    = rLike:'RLIKE'
    | regexp:'REGEXP'
    ;

// DataType
syntax PrimitiveType 
    = boolType: 'BOOL'	
    | timestampNTZType : 'TIMESTAMP_NTZ'
    | realType:'REAL'
    | byteType: 'BYTE'
    | shortType: 'SHORT'
    | longType: 'LONG'
    | decType : 'DEC'
    | numericType: 'NUMERIC'
    ;

syntax Timestamp = timestamp:'TIMESTAMP'| ltz: 'TIMESTAMP_LTZ';


syntax EscapeEx = escape:'ESCAPE' Expr;


syntax CommentLiteral = comment: 'COMMENT' StringConstant;

syntax Array
  = array: 'ARRAY'"(" {Expr ","}+ ")"
  ;


syntax OptionValue 
    = none:'NONE'
    | disk1:'DISK_ONLY'
    | disk2:'DISK_ONLY_2'
    | disk3:'DISK_ONLY_3'
    | memory1:'MEMORY_ONLY'
    | memory2:'MEMORY_ONLY_2'
    | memoryOnlyser: 'MEMORY_ONLY_SER'
    | memoryOnlyser2: 'MEMORY_ONLY_SER_2'
    | memAndDisk: 'MEMORY_AND_DISK'
    | memoryAndDisk2:'MEMORY_AND_DISK_2'
    | memoryAndDiskSer: 'MEMORY_AND_DISK_SER'
    | memoryAndDiskSer2: 'MEMORY_AND_DISK_SER_2'
    | offHeap:'OFF_HEAP'
    ;

syntax Default
    = @Foldable \default: 'DEFAULT' "=\>" Expr e ";"
    ;

syntax Case
    = @Foldable \case: 'CASE' Expr e1 "=\>" Expr e2 ";"
    ;