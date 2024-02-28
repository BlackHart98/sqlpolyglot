module basesql::grammar::Common

extend basesql::grammar::Expressions;


syntax IfNotExists = ifNotExists: 'IF' 'NOT' 'EXISTS';

syntax IfExists = ifExists: 'IF' 'EXISTS';

syntax PartitionClause = partitionClause: 'PARTITION' "("{PartitionPart ","}+ ")";

syntax PartitionPart = partitionPart: Identifier PartitionPartValue;

syntax PartitionPartValue = partitionPartValue: "=" Expr;

syntax PartitionPartWithOptionalValue = partitionPartWithOptionalValue: Identifier PartitionPartValue?;

syntax PartitionWithOptionValueClause 
  = partitionWithOptionValueClause: 'PARTITION'"("{PartitionPartWithOptionalValue ","}+")";

syntax Table = table: 'TABLE';

syntax TableProperty = tableProperty: StringConstant "=" StringConstant;


syntax PackageName = packageName: REGULARIDENTIFIER'.';

syntax ColumnSpecification = columnSpecification: Identifier DataType Comment?;

syntax Comment = comment: 'COMMENT' StringConstant;

syntax RowFormatClause = rowFormat: 'ROW' 'FORMAT' RowFormatType;

syntax RowFormatType 
= delimited: 
    'DELIMITED' FieldsTerminatedBy? CollectionItemsTerminatedBy? MapKeysTerminatedBy? 
    NullDefinedAs?
  | serde: 'SERDE' StringConstant SerdePropertiesClause?
  ;

syntax FieldsTerminatedBy = fieldsTerminatedBy: 'FIELDS' 'TERMINATED' 'BY' StringConstant EscapedBy?;


syntax EscapedBy = escapedBy: 'ESCAPED' 'BY' 'char';

syntax CollectionItemsTerminatedBy 
  = collectionItemsTerminatedBy: 'COLLECTION' 'ITEMS' 'TERMINATED' 'BY' StringConstant;

syntax MapKeysTerminatedBy = mapKeysTerminatedBy: 'MAP' 'KEYS' 'TERMINATED' 'BY' StringConstant;


syntax LinesTerminatedBy = linesTerminatedBy: 'LINES' 'TERMINATED' 'BY' StringConstant;

syntax NullDefinedAs = nullDefinedAs: 'NULL' 'DEFINED' 'AS' StringConstant;


syntax SerdePropertiesClause = serdePropertiesClause: 'WITH' 'SERDEPROPERTIES' "("{TableProperty ","}+")";


syntax StorageClause
  = storageClauseStoredAs: StoredAs
  | storageClauseStoredBy: 'STORED' 'BY'  StringConstant SerdePropertiesClause?
  ;

syntax StoredAs = storedAs: 'STORED' 'AS' StoredAsType;

syntax StoredAsType 
  = sequenceFile: 'SEQUENCEFILE' 
  | textFile: 'TEXTFILE' 
  | rcFile: 'RCFILE' 
  | orc: 'ORC' 
  | parquet: 'PARQUET' 
  | avro: 'AVRO' 
  | jsonFile: 'JSONFILE'
  | custom: 'INPUTFORMAT' StringConstant 'OUTPUTFORMAT' StringConstant
  ;
