import 'package:cloud_firestore/cloud_firestore.dart';

class Pet{
  String petId;
  String userId;
  String idDono;
  String nome;
  String tipoPet;
  Pet({required this.userId, required this.idDono, required this.nome, required this.tipoPet, required this.petId});
  Pet.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot): userId = snapshot.data()['UserId'], idDono = snapshot.data()['IdDono'], nome = snapshot.data()['Nome'], tipoPet = snapshot.data()['TipoPet'], petId = snapshot.id;
}