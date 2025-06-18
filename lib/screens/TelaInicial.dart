import 'package:flutter/material.dart';
import 'package:sqlite/dao/DogDao.dart';

class TelaInicial extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        initialData: [],
        future : findAll(), 
        builder: (context, snapshot) {
          switch(snapshot.connectionState)
          {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.none:
              debugPrint("ERRO NA CONEXÃO");
            case ConnectionState.done:
              List<Map> dogs = snapshot.data as List<Map>;
              return ListView.builder(
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  debugPrint("${dogs[index]['nome']}");
                  return ListTile(
                    title: Text("${dogs[index]['idade']}"),
                    subtitle: Text("${dogs[index]['nome']}"),
                  );
                },);
          }
          return Text("Erro Desconhecido");
      },),
    );
  }
}