import 'package:flutter/material.dart';
import 'package:sqlite/dao/DogDao.dart';
import '../model/DogModel.dart';

int ID_CONTROLLER = 0;

class TelaFormulario extends StatefulWidget {
  const TelaFormulario({super.key});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário")),
      body: ListView(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Nome do Dog",
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _controller2,
            decoration: InputDecoration(
              labelText: "Idade do Dog",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String name = _controller.text;
              int age = int.parse(_controller2.text);
              _controller.text = "";
              _controller2.text = "";
              Future<int> waiter = insertDog(
                new Dog(nome:name, idade:age, id:ID_CONTROLLER));
              ID_CONTROLLER++;
              print("DEVE TER IDO ESSA MERDA");
              Navigator.pop(context, true);
            },
            child: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
