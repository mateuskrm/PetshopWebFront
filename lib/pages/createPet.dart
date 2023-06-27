import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/cliente.dart';
import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class createPetPage extends StatefulWidget {
  const createPetPage({super.key});

  @override
  State<createPetPage> createState() => _createPetPageState();
}

class _createPetPageState extends State<createPetPage> {
  late AuthUser _authUser;
  late List<Cliente> clientes = [];
  late Cliente clienteSelecionado;
  late final FirebaseCloudStorage _service;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController tipoPetController = TextEditingController();
  TextEditingController clienteController = TextEditingController();

  @override
  void initState(){
    super.initState();
     _authUser = AuthService.firebase().authUser!;
    clientes.add(Cliente(userId: _authUser.id, atendimentos: 0, clienteId: 'teste', endereco: 'teste', nome:'selecione um cliente'));
    clienteSelecionado = clientes[0];

    _service = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Pet'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Form(
            child: Column(
              children: [
                //create a form to create a new pet based on the class Pet
                //the form should have the following fields: nome, tipoPet
                //the form should have a button to submit the form
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do pet';
                    }
                    return null;
                  },
                  controller: nomeController,
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Tipo de Pet",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o tipo de pet';
                    }
                    return null;
                  },
                  controller: tipoPetController,
                ),
                SizedBox(height: 20,),
                /*FutureBuilder(
                  future: _service.getClientes(userId: _authUser.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      clientes = snapshot.data!.toList();
                      if(clienteSelecionado == null || clienteSelecionado.clienteId.isEmpty){
                        clienteSelecionado = clientes[0];
                      }
                      return DropdownButton(
                        value: clienteSelecionado,
                        items: clientes.map((cliente) {
                          return DropdownMenuItem(
                            value: cliente.clienteId,
                            child: Text(cliente.nome),
                          );
                        }).toList(),
                        onChanged: (value) {
                          clienteSelecionado = clientes.firstWhere((cliente) => cliente.clienteId == value);
                        },
                      );
                    } else {
                      return Placeholder();
                    }
                  },
                  ),*/
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Cliente",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o cliente';
                    }
                    return null;
                  },
                  controller: clienteController,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //create a new pet based on the form fields
                       ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                       _service.createPet(userId: _authUser.id, idDono: 'teste', nome: nomeController.text, tipoPet: tipoPetController.text);
                       Navigator.pop(context);
                    }},
                    child: Text("Criar"),
                )

              ],
            )),
        ),
      ),
    );
  }
}