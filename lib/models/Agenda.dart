import 'package:cloud_firestore/cloud_firestore.dart';

class Agenda{
  String dataId;
  String donoId;
  String petId;
  String userId;
  DateTime data;
  Agenda({required this.dataId, required this.donoId, required this.petId, required this.data, required this.userId});
  Agenda.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot): dataId = snapshot.id, donoId = snapshot.data()['donoId'], petId = snapshot.data()['petId'], data = snapshot.data()['data'].toDate(), userId = snapshot.data()['UserId'];
}