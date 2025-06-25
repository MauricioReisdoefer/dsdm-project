import 'package:flutter/material.dart';
import 'package:sqlite/dao/DogDao.dart';
import 'TelaFormulario.dart';

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Lista de Dogs", selectionColor: Colors.white,),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        actions: [ FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaFormulario()),
            );

            if (result == true) {
              setState(() {
              });
            }
          },

    child: Icon(Icons.add),
  )],
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
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
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
                      trailing: IconButton(icon: Icon(Icons.pets), color: Colors.deepPurple, onPressed: () => {
                        setState(() {
                          deleteById(dogs[index]['id']);
                        })
                      },),
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
