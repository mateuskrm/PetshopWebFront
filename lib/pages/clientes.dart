import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/models/cliente.dart';
import 'package:petshop_front/pages/createCliente.dart';
import 'package:petshop_front/pages/updateCliente.dart';
import 'package:petshop_front/services/auth.service.dart';
import 'package:petshop_front/services/auth_user.dart';
import 'package:petshop_front/services/crud/firebase_cloud_storage.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  late AuthUser _authUser;
  late List<Cliente> clientes;
  late final FirebaseCloudStorage _clientesService;
  @override
  void initState() {
    super.initState();
    _authUser = AuthService.firebase().authUser!;
    _clientesService = FirebaseCloudStorage();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height,
      child: Row(
        
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.75,
            child: FutureBuilder(
              future: _clientesService.getClientes(userId: _authUser.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  clientes = snapshot.data!.toList();
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,                
                      mainAxisExtent: 200,
                    ),
                  
                    itemCount: clientes.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        height: 400,
                        child: Card(
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
                                    Text(clientes[index].nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                    Divider(),
                                    SizedBox(height: 20,),
                                    Text("Endereço: ${clientes[index].endereco}"),
                                    SizedBox(height: 10,),
                                    Text("Atendimentos Disponíveis: ${clientes[index].atendimentos.toString()}"),
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Expanded(
                                            child: Row(
                                              children: [
                                                IconButton(onPressed: (){
                                                  _clientesService.deleteCliente(documentId: clientes[index].clienteId);
                                                }, icon:  Icon(Icons.cancel, color: Colors.red,)),
                                                SizedBox(width: 10,),
                                                IconButton(onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateClientePage(cliente: clientes[index]),));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => createClientePage()));
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