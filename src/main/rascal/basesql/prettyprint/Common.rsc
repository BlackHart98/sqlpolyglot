module basesql::prettyprint::Common

import basesql::ast::BaseSQL;

import String;
import List;

extend basesql::prettyprint::Expressions;

// IfNotExists
public str toString(IfNotExists::ifNotExists()) = "IF NOT EXISTS";

// IfExists
public str toString(IfExists::ifExists()) = "IF EXISTS";

// PartitionClause
public str toString(PartitionClause::partitionClause(list[PartitionPart] partitionParts)) = "PARTITION (<intercalate(",", [ toString(part) | part <- partitionParts])>)";

// PartitionPart
public str toString(PartitionPart::partitionPart(Identifier id, PartitionPartValue ppVal)) = "<toString(id)> <toString(ppVal)>";

// PartitionPartValue
public str toString(PartitionPartValue::partitionPartValue(Expr exp)) = "= <toString(exp)>";

// PartitionPartWithOptionalValue
public str toString(
  PartitionPartWithOptionalValue::partitionPartWithOptionalValue(
    Identifier id
    , list[PartitionPartValue] partitionPartVal 
  )
) = "<toString(id)> <prettyOptional(partitionPartVal, toString)>";

// PartitionWithOptionValueClause
public str toString(
  PartitionWithOptionValueClause::partitionWithOptionValueClause(
    list[PartitionPartWithOptionalValue] partitionPartWithOptVals
  )
) = "PARTITION (<intercalate(",", [ toString(part) | part <- partitionPartWithOptVals])>)";

// Table
public str toString(Table::table()) = "TABLE";

// TableProperty
public str toString(TableProperty::tableProperty(str strConst1, str strConst2)) = "<strConst1> = <strConst2>";

// PackageName
public str toString(PackageName::packageName(str regularId)) = "<regularId>.";

// ColumnSpecification
public str toString(
  ColumnSpecification::columnSpecification(
    Identifier id
    , DataType datatype
    , list[Comment] comment
  )
) = trim("<toString(id)> <toString(datatype)> " + "<prettyOptional(comment, toString)>");

// Comment
public str toString(Comment::comment(str strConst)) = "COMMENT <strConst>";

// RowFormatClause
public str toString(RowFormatClause::rowFormat(RowFormatType rowFormatType)) = "ROW FORMAT <toString(rowFormatType)>";

// RowFormatType
public str toString(
  RowFormatType::delimited(
        list[FieldsTerminatedBy] fieldsTerminatedBy
        , list[CollectionItemsTerminatedBy] collectionItemsTerminatedBy
        , list[MapKeysTerminatedBy] mapKeysTerminatedBy 
        , list[NullDefinedAs] nullDefinedAs
  )
) = "DELIMITED <prettyOptional(fieldsTerminatedBy, toString)> <prettyOptional(collectionItemsTerminatedBy, toString)> <prettyOptional(mapKeysTerminatedBy, toString)> <prettyOptional(nullDefinedAs, toString)>";

public str toString(
  RowFormatType::serde(
    str strConst
    , list[SerdePropertiesClause] serdePropertiesCls 
  )
) = "SERDE <strConst> <prettyOptional(serdePropertiesCls, toString)>";

// FieldsTerminatedBy
public str toString(
  FieldsTerminatedBy::fieldsTerminatedBy(
    str strConst
    , list[EscapedBy] escapedBy
  )
) = "FIELDS TERMINATED BY <strConst> <prettyOptional(escapedBy, toString)>";

// EscapedBy
public str toString(EscapedBy::escapedBy()) = "ESCAPED BY char";

// CollectionItemsTerminatedBy
public str toString(
  CollectionItemsTerminatedBy::collectionItemsTerminatedBy(
    str strConst
  )
) = "COLLECTION ITEMS TERMINATED BY <strConst>";

// MapKeysTerminatedBy
public str toString(
  MapKeysTerminatedBy::mapKeysTerminatedBy(
    str strConst
  )
) = "MAP KEYS TERMINATED BY <strConst>";

// LinesTerminatedBy
public str toString(
  LinesTerminatedBy::linesTerminatedBy(
    str strConst
  )
) = "LINES TERMINATED BY <strConst>";

// NullDefinedAs
public str toString(
  NullDefinedAs::nullDefinedAs(
    str strConst
  )
) = "NULL DEFINED AS <strConst>";

// SerdePropertiesClause
public str toString(
  SerdePropertiesClause::serdePropertiesClause(
    list[TableProperty] tblProperties
  )
) = "WITH SERDEPROPERTIES (<intercalate(",", [ toString(tblProperty) | tblProperty <- tblProperties])>)";

// StorageClause
public str toString(StorageClause::storageClauseStoredAs(StoredAs storedAs)) = "<toString(storedAs)>";
public str toString(StorageClause::storageClauseStoredBy(str strConst, list[SerdePropertiesClause] serdePropertiesCls)) = "STORED BY <strConst> <prettyOptional(serdePropertiesCls, toString)>";

// StoredAs
public str toString(StoredAs::storedAs(StoredAsType storedAsType)) = "STORED AS <toString(storedAsType)>";

// StoredAsType
public str toString(StoredAsType::sequenceFile()) = "SEQUENCEFILE";
public str toString(StoredAsType::textFile()) = "TEXTFILE";
public str toString(StoredAsType::rcFile()) = "RCFILE";
public str toString(StoredAsType::orc()) = "ORC";
public str toString(StoredAsType::parquet()) = "PARQUET";
public str toString(StoredAsType::avro()) = "AVRO";
public str toString(StoredAsType::jsonFile()) = "JSONFILE";
public str toString(StoredAsType::custom(str strConst1, str strConst2)) = "INPUTFORMAT <strConst1> OUTPUTFORMAT <strConst2>";

