import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/models/pet.dart';

import '../models/cliente.dart';
import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class createAgendaPage extends StatefulWidget {
  const createAgendaPage({super.key});

  @override
  State<createAgendaPage> createState() => _createAgendaPageState();
}

class _createAgendaPageState extends State<createAgendaPage> {
  late AuthUser _authUser;
  late List<Cliente> clientes;
  late DateTime? data;
  late List<Pet> pets;
  late Pet petSelecionado;
  late Cliente clienteSelecionado;
  late final FirebaseCloudStorage _service;
  final _formKey = GlobalKey<FormState>();
    TextEditingController clienteController = TextEditingController();
    TextEditingController petController = TextEditingController();

  TextEditingController dataController = TextEditingController();


  @override
  void initState(){
    super.initState();
        _authUser = AuthService.firebase().authUser!;
    petSelecionado = Pet(userId: _authUser.id,idDono: '',  nome: '', petId: '', tipoPet: '');
    clienteSelecionado = Cliente(userId: _authUser.id, clienteId: '', nome: '',  atendimentos:  0, endereco: '');

    _service = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height:  MediaQuery.of(context).size.height * 0.5,  
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: clienteController,
                  decoration: InputDecoration(
                    labelText: "Cliente",
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
                  controller: petController,
                  decoration: InputDecoration(
                    labelText: "Pet",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do pet';
                    }
                    return null;
                  },
                ),

                /*FutureBuilder(
                  future: _service.getClientes(userId: _authUser.id),
                  builder: (context, snapshot) {
                      if (snapshot.hasData) {
                      clientes = snapshot.data as List<Cliente>;
                      if(clienteSelecionado == null){
                        clienteSelecionado = clientes[0];
                      }
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Cliente",
                          border: OutlineInputBorder(),
                        ),
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
                  },),*/
                  /*FutureBuilder(
                    future: _service.getPetsbyClienteId(clienteId: clienteSelecionado.clienteId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                      pets = snapshot.data as List<Pet>;
                      if(petSelecionado == null){
                        petSelecionado = pets[0];
                      }
                      return DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Pet",
                          border: OutlineInputBorder(),
                        ),
                        value: petSelecionado,
                        items: pets.map((pet) {
                          return DropdownMenuItem(
                            value: pet.petId,
                            child: Text(pet.nome),
                          );
                        }).toList(),
                        onChanged: (value) {
                          petSelecionado = pets.firstWhere((pet) => pet.petId == value);
                        },
                      );
                    } else {
                      return Placeholder();
                    }}),*/
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Data",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a data';
                      }
                      return null;
                    },
                    onTap: () async{
                      data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now() ,
                        lastDate: DateTime(2025),
                      );
                      if(data != null){
                         dataController.text = data.toString();
                      }
                    },
                    controller: dataController,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        await _service.createAgenda(
                          idDono: clienteController.text,
                          idPet: petController.text,
                          data: data!,
                          userId: _authUser.id,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Criar"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}