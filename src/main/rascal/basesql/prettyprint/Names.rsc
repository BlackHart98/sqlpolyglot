module basesql::prettyprint::Names

import basesql::ast::BaseSQL;

import List;

// PropRef
// public str prettyPropRef(PropRef::propRef(list[Identifier] ids)) = "<intercalate()>";

// VarAssign
public str toString(VarAssign::varAssign(list[VarAssignAs] varAssignAs, Identifier id)) = "<prettyOptional(varAssignAs, toString)>" + " <toString(id)>";

// VarAssignAs
public str toString(VarAssignAs::as()) = " AS";

// Identifier
public str toString(Identifier::varReference(str varRef)) = "${<varRef>}";
public str toString(Identifier::regularIdentifier(str regularId)) = "<regularId>";
public str toString(Identifier::quotedIdentifier(str quotedId)) = "<quotedId>";

// TableName
public str toString(
  TableName::name(
    list[SchemaNameDot] schemaNameDot
    , Identifier id
  )
) = "<prettyOptional(schemaNameDot, toString)><toString(id)>";

// SchemaNameDot
public str toString(SchemaNameDot::schemaName(Identifier id)) = "<toString(id)>.";

// Url
public str toString(
  Url::url(
    list[SchemePart] schemePt
    , list[DirectoryPart] directoryPt
    , FileNamePart filePt
  )
) = "<prettyOptional(schemePt, toString)><prettyOptional(directoryPt, toString)><toString(filePt)>";

public str toString(Url::urlVarReference(str regularId)) = "${<regularId>}";

// SchemePart
public str toString(SchemePart::schemePart(Scheme schm)) = "<toString(schm)>://";
public str toString(SchemePart::noScheme()) = "/";

// Scheme
public str toString(Scheme::hdfs()) = "hdfs";

// DirectoryPart
public str toString(
  DirectoryPart::directoryPart(
    list[Identifier] ids
  )
) = "<intercalate("/", [ toString(id) | id <- ids ])>/";

// FileNamePart
public str toString(FileNamePart::fileNamePart(Identifier id1, Identifier id2)) = "<toString(id1)>.<toString(id2)>";

// Utility - For pretty printing optional elements
public str prettyOptional(list[&T] lst, str (value) function, str sep = ""){
  if (sep != "") {
    resultList = [function(x) | x <- lst];
    if (isEmpty(resultList)) return "";
    else return intercalate("", resultList) + sep;
  }else return intercalate("", [function(x) | x <- lst]);
}
