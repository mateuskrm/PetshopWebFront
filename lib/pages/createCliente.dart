import 'package:flutter/material.dart';

import 'package:petshop_front/models/cliente.dart';

import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class createClientePage extends StatefulWidget {
  const createClientePage({super.key});

  @override
  State<createClientePage> createState() => _createClientePageState();
}

class _createClientePageState extends State<createClientePage> {
  final _formKey = GlobalKey<FormState>();
    late AuthUser _authUser;
  late final FirebaseCloudStorage _clientesService;

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();

  @override
  void iniitState() {
    super.initState();
     _authUser = AuthService.firebase().authUser!;
    _clientesService = FirebaseCloudStorage();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.75,
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    //create a form to create a new cliente based on the class Cliente
                    //the form should have the following fields: nome, endereco
                    //the form should have a button to submit the form
                    //the form should have a button to cancel the form
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do cliente';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _enderecoController,
                      decoration: InputDecoration(
                        labelText: "Endereço",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o endereço do cliente';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: ()async {
                        if (_formKey.currentState!.validate()){
                          await _clientesService.createCliente(userId: _authUser.id, nome: _nomeController.text, endereco: _enderecoController.text, );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  
                ],
              ),
            ),
           )
        ),
      ),
    );
  }
}