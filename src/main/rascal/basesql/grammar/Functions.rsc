module basesql::grammar::Functions

extend basesql::grammar::Common;
extend basesql::grammar::SolutionModifiers;


syntax Statement = addFile: 'ADD' 'FILE' Url;


  
syntax WindowSpecification 
  = windowSpecification: "("PartitionByClause? OrderByClause? WindowFrameClause?")"
  | namedWindow: Identifier
  ;

syntax PartitionByClause = partitionByClause: 'PARTITION' 'BY' {Expr ","}+;

syntax RowsOrRange 
  = rows: 'ROWS'
  | range: 'RANGE'
  ;


syntax WindowFrameClause = windowFrameClause: RowsOrRange FrameStartOrBetween;

syntax FrameStartOrBetween
  = frameStart: FrameStart
  | frameBetween: FrameBetween
  ; 

syntax FrameBetween
  = frameBetweenUnboundedPreceding: 'BETWEEN' UnboundedPreceding 'AND' FrameEndA
  | frameBetweenNumericPreceding: 'BETWEEN' NumericPreceding 'AND' FrameEndA
  | frameBetweenCurrentRow: 'BETWEEN' CurrentRow 'AND' FrameEndB
  | frameBetweenNumericFollowing: 'BETWEEN' NumericFollowing 'AND' FrameEndC
  ;

syntax FrameStart
  = frameStartUnboundedPreceding: UnboundedPreceding
  | frameStartNumericPreceding: NumericPreceding
  | frameStartCurrentRow: CurrentRow
  ;


syntax FrameEndA
  = frameEndANumericPreceding: NumericPreceding
  | frameEndACurrentRow: CurrentRow
  | frameEndANumericFollowing: NumericFollowing
  | frameEndAUnboundedFollowing: UnboundedFollowing
  ;

syntax FrameEndB
  = frameEndBCurrentRow: CurrentRow
  | frameEndBNumericFollowing: NumericFollowing
  | frameEndBUnboundedFollowing: UnboundedFollowing
  ; 


syntax FrameEndC
  = frameEndCNumericFollowing: NumericFollowing
  | frameEndCUnboundedFollowing: UnboundedFollowing
  ; 


syntax UnboundedPreceding = unboundedPreceding: 'UNBOUNDED' 'PRECEDING'; 

syntax NumericPreceding = numericPreceding: Int 'PRECEDING';

syntax UnboundedFollowing = unboundedFollowing: 'UNBOUNDED' 'FOLLOWING';

syntax NumericFollowing = numericFollowing: Int 'FOLLOWING';

syntax CurrentRow = currentRow: 'CURRENT' 'ROW';

syntax WindowClause 
  = windowClause: 'WINDOW' Identifier 'AS'"("PartitionByClause? OrderByClause? WindowFrameClause?")";

