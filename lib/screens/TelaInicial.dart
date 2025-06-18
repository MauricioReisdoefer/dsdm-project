import 'package:flutter/material.dart';
import 'package:sqlite/dao/DogDao.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Lista de Dogs", selectionColor: Colors.white,),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: FutureBuilder(
        initialData: [],
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());

            case ConnectionState.none:
              debugPrint("ERRO NA CONEXÃO");
              return Center(
                child: Icon(Icons.error, color: Colors.red, size: 40),
              );

            case ConnectionState.done:
              List<Map> dogs = snapshot.data as List<Map>;
              if (dogs.isEmpty) {
                return Center(
                  child: Text(
                    "Nenhum dog encontrado",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          "${dogs[index]['id']}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        "${dogs[index]['nome']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text("Idade: ${dogs[index]['idade']} anos"),
                      trailing: Icon(Icons.pets, color: Colors.deepPurple),
                    ),
                  );
                },
              );
          }
        }
      ),
    );
  }
}
