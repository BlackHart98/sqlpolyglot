module spark::grammar::Names

extend basesql::grammar::BaseSQL;


lexical FUNCTIONNAME = REGULARIDENTIFIER \ IMPLEMENTED_FUNCTIONNAME;


keyword Keywords
    = 'LIKE'
    | 'MATCH'
    ;


keyword IMPLEMENTED_FUNCTIONNAME 
    = 'named_struct'
    | 'lead'
    | 'lag'
    | 'last_value'
    | 'first_value'
    | 'nth_value'
    | 'map'
    | 'rank'
    | 'inline'
    | 'explode_outer'
    | 'inline_outer'	
    | 'posexplode'
    | 'posexplode_outer'
    | 'stack'
    | 'posexplode'
    | 'row_number'
    | 'dense_rank'
    | 'cume_dist' 
    | 'percent_rank' 
    | 'ntile' 
    | 'count' 
    | 'min' 
    | 'max' 
    | 'sum' 
    | 'avg' 
    | 'array_agg' 
    | 'listagg' 
    | 'exists' 
    | 'asc' 
    | 'desc' 
    | 'not' 
    | 'distinct' 
    | 'path' 
    | 'as' 
    | 'select' 
    | 'from' 
    | 'match' 
    | 'where' 
    | 'group' 
    | 'order' 
    | 'by' 
    | 'having' 
    | 'limit' 
    | 'offset' 
    | 'to_date' 
    | 'to_utc_timestamp' 
    | 'from_utc_timestamp' 
    // | 'from_unixtime' 
    | 'unix_timestamp' 
    | 'regexp_replace' 
    | 'current_date' 
    | 'current_timestamp' 
    | 'substr' 
    | 'substring' 
    | 'nvl' 
    | 'if' 
    | 'hex'
    | 'unhex'
    | 'coalesce' 
    | 'date_sub' 
    | 'ceil' 
    | 'ceiling' 
    | 'length' 
    | 'month' 
    | 'year' 
    | 'variance'
    | 'date_add' 
    | 'datediff' 
    | 'concat' 
    | 'instr' 
    | 'upper' 
    | 'ucase' 
    | 'lower' 
    | 'lcase' 
    | 'exp' 
    | 'get_json_object' 
    | 'add_months'
    | 'months_between'
    | 'ascii'
    | 'base64'
    | regExpReplace: 'REGEXP_REPLACE'
    | base64:'base64'
    | btrim:'btrim'
    | 'bit_length'
    | 'encode'
    | 'decode'
    | 'char'
    | 'chr'
    | 'LENGTH'
    | 'LEN'
    | 'CONCAT'
    | 'INSTR'
    | 'SUBSTRING'
    | 'SUBSTRING'
    | 'SUBSTR'
    | 'SUBSTR'
    | 'SUBSTRING'
    | 'SUBSTR'
    | 'UPPER'
    | 'UCASE'
    | 'LOWER'
    | 'LCASE'
    | 'GET_JSON_OBJECT'
    | 'char_length'
    | 'character_length'
    | 'concat_ws' 
    | 'contains'
    | 'replace'
    | 'decode'
    | 'elt'
    | 'endswith'
    | 'find_in_set'
    |'format_number'
    | 'format_string'
    | 'initcap'
    | 'PERCENTILE_CONT'
    | 'explode'
    | 'left'
    | 'levenshtein'
    | 'locate'
    | 'lpad'	
    | 'ltrim'
    | 'luhn_check'
    | 'mask'
    | 'octet_length'
    | 'overlay'
    | 'position'
    | 'space'
    // |'split'
    | 'startswith'
    | 'substring_index'
    // translate(input, from, to)	Translates the `input` string by replacing the characters present in the `from` string with the corresponding characters in the `to` string.
    | 'trim'
    | 'trim'
    | 'rtrim'
    | 'transform'
    | 'rlike'
    ;