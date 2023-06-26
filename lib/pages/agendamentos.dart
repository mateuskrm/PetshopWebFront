import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/models/Agenda.dart';
import 'package:petshop_front/models/agendaInfo.dart';

import '../models/cliente.dart';
import '../models/pet.dart';
import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class Agendamento extends StatefulWidget {
  const Agendamento({super.key});

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  late AgendaInfo agendaInfo;
  late AuthUser _authUser;
  late List<Agenda> agendas;
  late Cliente dono;
  late final FirebaseCloudStorage _agendasService;

  @override
  void initState(){
    super.initState();
    _authUser = AuthService.firebase().authUser!;
    _agendasService = FirebaseCloudStorage();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.75,
      child: FutureBuilder(
        future: _agendasService.getAgendas(userId: _authUser.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            agendas = snapshot.data!.toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,                
                mainAxisExtent: 200,
              ),
            
              itemCount: agendas.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 300,
                  height: 400,
                  child: FutureBuilder(
                    future: _agendasService.getAgendaInfo(clienteId: agendas[index].donoId, petId: agendas[index].petId),
                    builder: (context, snapshot) {
                      agendaInfo = snapshot.data!;
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
                                Text(agendas[index].data.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Divider(),
                                SizedBox(height: 20,),
                                Text("Cliente: ${agendaInfo.nomeCliente}"),
                                SizedBox(height: 10,),
                                Text("Pet: ${agendaInfo.nomePet}"),
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
      )
    );
  }
}