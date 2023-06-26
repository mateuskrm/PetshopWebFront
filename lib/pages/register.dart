import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/pages/home.dart';
import 'package:petshop_front/services/auth.service.dart';
import 'package:petshop_front/services/auth_excepetions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Text("Usuário"),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite seu usuário',
                ),
                controller: _email,
              ),
              const SizedBox(height: 10,),
              Text("Senha"),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite sua senha',
                ),
                controller: _password,
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () async{
                  try{
                    await AuthService.firebase().signUp(email: _email.text, password: _password.text);
                    final user = AuthService.firebase().authUser;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }on WeakPasswordException{
                    await showDialog(context: context, builder: (context) => const AlertDialog(
                      title: Text("Erro"),
                      content: Text("Senha fraca"),
                    ));
                  }on EmailAlreadyInUseException{
                    await showDialog(context: context, builder: (context) => const AlertDialog(
                      title: Text("Erro"),
                      content: Text("Email já cadastrado"),
                    ));
                  }on InvalidEmailException{
                    await showDialog(context: context, builder: (context) => const AlertDialog(
                      title: Text("Erro"),
                      content: Text("Email inválido"),
                    ));
                  }on GenericAuthException{
                    await showDialog(context: context, builder: (context) => const AlertDialog(
                      title: Text("Erro"),
                      content: Text("Erro ao cadastrar"),
                    ));
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ))
      ),
    );
  }
}