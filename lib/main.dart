import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlite/dao/DogDao.dart';
import 'package:sqlite/model/DogModel.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/TelaInicial.dart';

void main() {
  if(Platform.isWindows)
  {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();

  Dog meucachorro = Dog(id: 1, nome: "spike", idade: 5);
  debugPrint("Criando o cachorro...");
  insertDog(meucachorro);
  debugPrint("Lendo o cachorro: ${findAll()}");


  findAll().then(
    (dados) {
      for (Map<dynamic, dynamic> dado in dados)
      {
        debugPrint("Item: $dado");
      }
    }
  );
  runApp(MaterialApp(
    home: TelaInicial(),
    debugShowCheckedModeBanner: false, // opcional
  ));
}