module basesql::prettyprint::Functions

import basesql::ast::BaseSQL;

import List;
import String;

extend basesql::prettyprint::Common;
extend basesql::prettyprint::SolutionModifiers;

// Expr 

// WindowSpecification
public str toString(
  WindowSpecification::windowSpecification(
    list[PartitionByClause] partitionByCls
    , list[OrderByClause] orderByCls
    , list[WindowFrameClause] windowFrameCls
  )
) = "(<prettyOptional(partitionByCls, toString)> <prettyOptional(orderByCls, toString)> <prettyOptional(windowFrameCls, toString)>)";

public str toString(WindowSpecification::namedWindow(Identifier id)) = "<toString(id)>";

// PartitionByClause
public str toString(PartitionByClause::partitionByClause(list[Expr] exprs)) = "PARTITION BY <intercalate(",", [ toString(exp) | exp <- exprs ])>";

// RowsOrRange
public str toString(RowsOrRange::rows()) = "ROWS";
public str toString(RowsOrRange::range()) = "RANGE";

// WindowFrameClause
public str toString(
  WindowFrameClause::windowFrameClause(
    RowsOrRange rowOrRange
    , FrameStartOrBetween frameStartOrBetween
  )
) = "<toString(rowOrRange)> <toString(frameStartOrBetween)>";

// FrameStartOrBetween
public str toString(FrameStartOrBetween::frameStart(FrameStart frmStart)) = "<toString(frmStart)>";
public str toString(FrameStartOrBetween::frameBetween(FrameBetween frmBetween)) = "<toString(frmBetween)>";

// FrameBetween
public str toString(
  FrameBetween::frameBetweenUnboundedPreceding(
    UnboundedPreceding unboundedPrec
    , FrameEndA frameEndA
  )
) = "BETWEEN <toString(unboundedPrec)> AND <toString(frameEndA)>";

public str toString(
  FrameBetween::frameBetweenNumericPreceding(
    NumericPreceding numericPreceding
    , FrameEndA frameEndA
  )
) = "BETWEEN <toString(numericPreceding)> AND <toString(frameEndA)>";

public str toString(
  FrameBetween::frameBetweenCurrentRow(
    CurrentRow currentRow
    , FrameEndB frameEndB
  )
) = "BETWEEN <toString(currentRow)> AND <toString(frameEndB)>";

public str toString(
  FrameBetween::frameBetweenNumericFollowing(
    NumericFollowing numericFollowing
    , FrameEndC frameEndC
  )
) = "BETWEEN <toString(numericFollowing)> AND <toString(frameEndC)>";

// FrameStart
public str toString(FrameStart::frameStartUnboundedPreceding(UnboundedPreceding unboundedPrec)) = "<toString(unboundedPrec)>";
public str toString(FrameStart::frameStartNumericPreceding(NumericPreceding numericPrec)) = "<toString(numericPrec)>";
public str toString(FrameStart::frameStartCurrentRow(CurrentRow currentRow)) = "<toString(currentRow)>";

// FrameEndA
public str toString(FrameEndA::frameEndANumericPreceding(NumericPreceding numericPrec)) = "<toString(numericPrec)>";
public str toString(FrameEndA::frameEndACurrentRow(CurrentRow currentRow)) = "<toString(currentRow)>";
public str toString(FrameEndA::frameEndANumericFollowing(NumericFollowing numericFol)) = "<toString(numericFol)>";
public str toString(FrameEndA::frameEndAUnboundedFollowing(UnboundedFollowing unboundedFol)) = "<toString(unboundedFol)>";

// FrameEndB
public str toString(FrameEndB::frameEndBCurrentRow(CurrentRow currentRow)) = "<toString(currentRow)>";
public str toString(FrameEndB::frameEndBNumericFollowing(NumericFollowing numericFol)) = "<toString(numericFol)>";
public str toString(FrameEndB::frameEndBUnboundedFollowing(UnboundedFollowing unboundedFol)) = "<toString(unboundedFol)>";

// FrameEndC
public str toString(FrameEndC::frameEndCNumericFollowing(NumericFollowing numericFol)) = "<toString(numericFol)>";
public str toString(FrameEndC::frameEndCUnboundedFollowing(UnboundedFollowing unboundedFol)) = "<toString(unboundedFol)>";

// UnboundedPreceding
public str toString(UnboundedPreceding::unboundedPreceding()) = "UNBOUNDED PRECEDING";

// NumericPreceding
public str toString(NumericPreceding::numericPreceding(str \int)) = "<\int> PRECEDING";

// UnboundedFollowing
public str toString(UnboundedFollowing::unboundedFollowing()) = "UNBOUNDED FOLLOWING";

// NumericFollowing
public str toString(NumericFollowing::numericFollowing(str \int)) = "<\int> FOLLOWING";

// CurrentRow
public str toString(CurrentRow::currentRow()) = "CURRENT ROW";

// WindowClause
public str toString(
  WindowClause::windowClause(
    Identifier id
    , list[PartitionByClause] partitionByCls
    , list[OrderByClause] orderByCls
    , list[WindowFrameClause] windowFrameCls
  )
) = "WINDOW <toString(id)> AS (<prettyOptional(partitionByCls, toString)> <prettyOptional(orderByCls, toString)> <prettyOptional(windowFrameCls, toString)>)";


