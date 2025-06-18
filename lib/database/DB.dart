import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> getDataBase() async {
  String caminhoDataBase = join(await getDatabasesPath(), 'dogs.db');
  return openDatabase(
    caminhoDataBase,
    version: 1,
    onCreate: (db, version) {
      db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, idade INTEGER)",
      );
    },
  );
}
