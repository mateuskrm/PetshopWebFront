import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/pet.dart';
import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class UpdatePetPage extends StatefulWidget {
  final Pet pet;
  const UpdatePetPage({required this.pet,super.key});

  @override
  State<UpdatePetPage> createState() => _UpdatePetPageState();
}

class _UpdatePetPageState extends State<UpdatePetPage> {
    late AuthUser _authUser;
    late final FirebaseCloudStorage _service;
    final _formKey = GlobalKey<FormState>();
    TextEditingController nomeController = TextEditingController();
    TextEditingController tipoPetController = TextEditingController();
    TextEditingController clienteController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _authUser = AuthService.firebase().authUser!;
    _service = FirebaseCloudStorage();
    nomeController.text = widget.pet.nome;
    tipoPetController.text = widget.pet.tipoPet;
    clienteController.text = widget.pet.idDono;
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
                      return 'Nome do pet é obrigatório';
                    }
                    return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: tipoPetController,
                  decoration: InputDecoration(
                    labelText: "Tipo do pet",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tipo do pet é obrigatório';
                    }
                    return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: clienteController,
                  decoration: InputDecoration(
                    labelText: "Cliente",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cliente é obrigatório';
                    }
                    return null;
                  },
                  
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {

                      await _service.updatePet(userId: _authUser.id,documentId: widget.pet.petId, nome: nomeController.text, tipoPet: tipoPetController.text, idDono: clienteController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Atualizar"),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}