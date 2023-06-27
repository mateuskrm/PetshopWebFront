import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/models/pet.dart';
import 'package:petshop_front/pages/createAgenda.dart';
import 'package:petshop_front/pages/createPet.dart';
import 'package:petshop_front/pages/updatePet.dart';
import 'package:petshop_front/services/auth_user.dart';

import '../models/cliente.dart';
import '../services/auth.service.dart';
import '../services/crud/firebase_cloud_storage.dart';

class Pets extends StatefulWidget {
  const Pets({super.key});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  late AuthUser _authUser;
  late List<Pet> pets;
  late Cliente dono;
  late final FirebaseCloudStorage _petsService;
  @override
  void initState(){
    super.initState();
    _authUser = AuthService.firebase().authUser!;
    _petsService = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
        return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.75,
            child: FutureBuilder(
              future: _petsService.getPets(userId: _authUser.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  pets = snapshot.data!.toList();
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,                
                      mainAxisExtent: 200,
                    ),
                  
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        height: 400,
                        child: FutureBuilder(
                          future: _petsService.getClientebyId(clienteId: pets[index].idDono),
                          builder: (context, snapshot) {
                            dono = snapshot.data!;
                            if(snapshot.hasData){
                            return Card(
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.06,
                                  height: MediaQuery.of(context).size.width * 0.09,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/images/homem.png"),
                                      ],
                                    ),
                                  ),
                                ),
                                VerticalDivider(),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Column(
                                    children: [
                                      Text(pets[index].nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      Divider(),
                                      SizedBox(height: 20,),
                                      Text("Tipo de Pet: ${pets[index].tipoPet}"),
                                      SizedBox(height: 10,),
                                      Text("Dono: ${dono.nome}"),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Expanded(
                                            child: Row(
                                              children: [
                                                IconButton(onPressed: (){
                                                  _petsService.deletePet(documentId: pets[index].petId);
                                                }, icon:  Icon(Icons.cancel, color: Colors.red,)),
                                                SizedBox(width: 10,),
                                                IconButton(onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePetPage(pet: pets[index]),));
                                                }, icon:  Icon(Icons.edit, color: Colors.yellow,)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                              );
                            }else {
                              return CircularProgressIndicator();
                            }
                          }
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child:Text("Sem dados"));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => createPetPage()));
              },
              child: Icon(Icons.add),
              ),
            ),
          )
        ],
      )
    );
  }
}