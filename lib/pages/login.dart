import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petshop_front/pages/home.dart';
import 'package:petshop_front/pages/register.dart';

import '../services/auth.service.dart';
import '../services/auth_excepetions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 final TextEditingController _email = TextEditingController();
 final TextEditingController _password =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              children: [
                Form(child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.5,
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
                              await AuthService.firebase().logIn(email: _email.text, password: _password.text);
                              final user = AuthService.firebase().authUser;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                            }on UserNotFoundException {
                              await showDialog(context: context, builder: (context) => const AlertDialog(
                                title: Text("Erro"),
                                content: Text("Usuário não encontrado"),
                              ));                            
                            }on WrongPasswordException {
                              await showDialog(context: context, builder: (context) => const AlertDialog(
                                title: Text("Erro"),
                                content: Text("Senha incorreta"),
                              ));
                            }on GenericAuthException {
                              await showDialog(context: context, builder: (context) => const AlertDialog(
                                title: Text("Erro"),
                                content: Text("Erro desconhecido"),
                              ));
                            }   
                          },
                          child: const Text('Entrar'),
                        ),
                        const SizedBox(height: 10,),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                        }, child: Text("Registrar"))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}