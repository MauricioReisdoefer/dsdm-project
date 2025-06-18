import 'package:sqflite/sqflite.dart';
import 'package:sqlite/database/DB.dart';
import 'package:sqlite/model/DogModel.dart';

//Função para inserir um Dog
Future<int> insertDog(Dog dog) async {
  final Database db = await getDataBase();
  return db.insert(
    "dogs",
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

//findAll()
Future<List<Map>> findAll() async {
  final Database db = await getDataBase();
  return db.query("dogs");
}
