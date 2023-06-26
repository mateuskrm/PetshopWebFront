import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeInfo extends StatefulWidget {
  const HomeInfo({super.key});

  @override
  State<HomeInfo> createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text("Bem Vindo!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          ClipRRect(
              borderRadius: const BorderRadius.only(  
                topLeft: Radius.circular(10),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(20),
              ),
           

            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.asset("assets/images/homeImage.jpg", fit: BoxFit.fill,
              )
            )
          ),
          SizedBox(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Clientes Ativos: X", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("Banhos e Tosas Marcados para hoje: Y", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}