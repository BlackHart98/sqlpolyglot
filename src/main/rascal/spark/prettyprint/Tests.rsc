module spark::prettyprint::Tests

import spark::prettyprint::Spark;
import spark::utils::Implode;
import IO;
import util::FileSystem;

test bool testAlterDB() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/alterdb.ssql|;
  return prettyCond(file);
}
test bool testAlterV() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/alterv.ssql|;
  return prettyCond(file);
}
test bool testCreateDB() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/createDb.ssql|;
  return prettyCond(file);
}
test bool testCreateFunction() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/createfunction.ssql|;
  return prettyCond(file);
}
test bool testCreateTable() {
  loc anaFunc = |project://sqlpolyglot/src/main/rascal/spark/examples/createtable.ssql|;
  return prettyCond(anaFunc);
}
test bool testDropDB() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/dropDb.ssql|;
  return prettyCond(file);
}
test bool testDropFunc() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/dropFunc.ssql|;
  return prettyCond(file);
}
test bool testDropTable() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/dropTable.ssql|;
  return prettyCond(file);
}
test bool testDropView() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/altertable.ssql|;
  return prettyCond(file);
}
test bool testInsert() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/insert.ssql|;
  return prettyCond(file);
}
test bool testInsertDirectory() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/insertDirectory.ssql|;
  return prettyCond(file);
}
test bool testInsertOverwrite() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/insertOverwrite.ssql|;
  return prettyCond(file);
}
test bool testLoad() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/load.ssql|;
  return prettyCond(file);
}
test bool testRepair() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/repair.ssql|;
  return prettyCond(file);
}
test bool testUse() {
  loc file = |project://sqlpolyglot/src/main/rascal/spark/examples/use.ssql|;
  return prettyCond(file);
}

// test bool testSpark(){
//   int count = 0;

//   ignores = {};     
//   for (loc path <- |project://sqlpolyglot/src/main/rascal/spark/examples/|.ls, fs := crawl(path), /loc src := fs, src.file notin ignores, src.extension == "ssql") {  
//     count += 1;
//     println("<count> : <src>");
//     prettyCond(src);
//     ;
//   }
//   return true;
// }

bool prettyCond(loc file) {
  ast = loadSpark(file);
  x = loadSpark(toString(ast));
  return ast := x;
  // return true;
}
