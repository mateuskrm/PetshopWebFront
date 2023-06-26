import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/pages/agendamentos.dart';
import 'package:petshop_front/pages/clientes.dart';
import 'package:petshop_front/pages/home_info.dart';
import 'package:petshop_front/pages/pets.dart';

import '../services/auth.service.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200]
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Center(
          child: Row(
              children: [
                NavigationRail(
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text("Home")
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_rounded),
                      label: Text("Clientes")),
                    NavigationRailDestination(
                      icon: Icon(Icons.schedule),
                      label: Text("Agendamentos")),
                    NavigationRailDestination(
                      icon: Icon(Icons.pets),
                      label: Text("Pets")
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.cancel, color: Colors.red), label:Text("Sair"))
                  ],
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (value) async{
                    if(value == 4){
                      await AuthService.firebase().logOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    }else{
                    setState(() {
                      _selectedIndex = value;
                    });
                    }
                  },                  
                ),
                const VerticalDivider(thickness: 1, width: 1,),
                Expanded(
                  child: Center(
                    child: _selectedIndex == 0 ? const HomeInfo() :
                    _selectedIndex == 1 ? const Clientes() :
                    _selectedIndex == 2 ? const Agendamento() :
                    _selectedIndex == 3 ? const Pets() :
                    const HomeInfo(),
                  ),
                )
              ],
            )
          ),
        ),
      );
  }
}