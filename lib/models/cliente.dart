import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Cliente{
  String clienteId;
  String nome;
  String endereco;
  int atendimentos;
  String userId;
  Cliente({required this.clienteId,required this.nome,required this.atendimentos, required this.endereco, required this.userId});
  Cliente.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot): clienteId = snapshot.id, nome = snapshot.data()['Nome'], atendimentos = snapshot.data()['Atendimentos'], endereco = snapshot.data()['Endereco'], userId = snapshot.data()['UserId'];
}