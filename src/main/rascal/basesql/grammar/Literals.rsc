module basesql::grammar::Literals

syntax Literal
  = Number
  | String 
  | Boolean
  | Date
  | Time
  | Timestamp
  | illegalNull: 'null'
  ;

syntax Number
  = integer: Int
  | long: Long
  | decimal: UNSIGNEDDECIMAL
  ;


syntax String = string: StringConstant
  ;

syntax Boolean
  = \true: 'TRUE'
  | \false: 'FALSE'
  ;


syntax Date
  = date: 'DATE' StringConstant
  ;


syntax Time
  = time: 'TIME' StringConstant
  ;


syntax Timestamp
  = timeStamp: 'TIMESTAMP' StringConstant
  ;


lexical Int = @category="Constant"  [0-9] !<< [0-9]+ !>> [0-9];

lexical Long = @category="Constant"  [0-9] !<< [0-9]+ !>> [0-9] "L";

lexical UNSIGNEDDECIMAL     = ( [0-9]* "." [0-9]+ ) | ( [0-9]+ "." );

lexical StringConstant 
  = @category="Constant"  [\"] StringCharacter* [\"]
  | @category="Constant"  [\'] SingleQuoteStringCharacter* [\']
  ; 

lexical StringCharacter
  = "\\" [\" \\ b f n r t] 
  | UnicodeEscape 
  | ![\" \\]
  | [\n][\ \t \u00A0 \u1680 \u2000-\u200A \u202F \u205F \u3000]* [\'] // margin 
  | "\\" Int
  ;

lexical SingleQuoteStringCharacter
  = "\\" [\' \\ b f n r t] 
  | UnicodeEscape 
  | ![\' \\]
  | [\n][\ \t \u00A0 \u1680 \u2000-\u200A \u202F \u205F \u3000]* [\'] // margin 
  | "\\" Int
  ; 

lexical UnicodeEscape
  = utf16: "\\" [u] [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] 
  | utf32: "\\" [U] (("0" [0-9 A-F a-f]) | "10") [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] [0-9 A-F a-f] // 24 bits 
  | ascii: "\\" [a] [0-7] [0-9A-Fa-f]
;
