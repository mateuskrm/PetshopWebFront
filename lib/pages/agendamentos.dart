import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Agendamento extends StatefulWidget {
  const Agendamento({super.key});

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  @override
  Widget build(BuildContext context) {
    return const Text("Agendamento");
  }
}