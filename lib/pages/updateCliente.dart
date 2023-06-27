import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/models/cliente.dart';

import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class UpdateClientePage extends StatefulWidget {
  final Cliente cliente;
  const UpdateClientePage({required this.cliente,super.key});

  @override
  State<UpdateClientePage> createState() => _UpdateClientePageState();
}

class _UpdateClientePageState extends State<UpdateClientePage> {
      late AuthUser _authUser;
    late final FirebaseCloudStorage _service;
    final _formKey = GlobalKey<FormState>();
    TextEditingController nomeController = TextEditingController();
    TextEditingController enderecoController = TextEditingController();
  @override
  void initState(){
    super.initState();
    _authUser = AuthService.firebase().authUser!;
    _service = FirebaseCloudStorage();
    nomeController.text = widget.cliente.nome;
    enderecoController.text = widget.cliente.endereco;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome do cliente é obrigatório';
                    }
                    return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: enderecoController,
                  decoration: InputDecoration(
                    labelText: "Endereço",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Endereço do cliente é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _service.updateCliente(atendimentos: 0, documentId: widget.cliente.clienteId, endereco: enderecoController.text, nome: nomeController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Atualizar"),
                ),
              ]),
          ),
        ),
      ),
    );
  }
}