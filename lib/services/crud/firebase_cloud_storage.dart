  import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petshop_front/models/agendaInfo.dart';
import 'package:petshop_front/models/cliente.dart';
import 'package:petshop_front/models/pet.dart';

import '../../models/Agenda.dart';
import 'cloud_storage_exceptions.dart';

class FirebaseCloudStorage
  {
    final clientes = FirebaseFirestore.instance.collection('Clientes');
    final pets = FirebaseFirestore.instance.collection('Pets');
    final agendas = FirebaseFirestore.instance.collection('Agendamento');


    Future<Cliente> getClientebyId({required String clienteId}) async{
      try{
        final query = await clientes.get();
        return await clientes.doc(clienteId).get().then((value) =>  Cliente(clienteId: value.id, nome: value['Nome'],
         atendimentos: value['Atendimentos'], endereco: value['Endereço'], userId: value['UserId']));
      }catch(_){
        throw CouldNotGetAllItemsException();
      }
    }

    Future<Pet>getPetbyId({required String petId}) async{
      try{
        final query = await pets.get();
        return await pets.doc(petId).get().then((value) => Pet(userId: value['UserId'], idDono: value['idDono'], nome: value['nome'], tipoPet: value['tipoPet'], petId: value.id));
      }catch(_){
        throw CouldNotGetAllItemsException();
      }
    }

    Future<AgendaInfo> getAgendaInfo({required String clienteId, required String petId})async{
      late final Cliente cliente;
      late final Pet pet;
      try{
        cliente = await getClientebyId(clienteId: clienteId);
        pet = await getPetbyId(petId: petId);
        return AgendaInfo(nomeCliente: cliente.nome, nomePet: pet.nome);
      }catch(_)
      {
        throw CouldNotGetAllItemsException();
      }
    }
    //create the CRUD for agendas
    Future<Agenda> createAgenda({
      required String userId,
      required String idDono,
      required String idPet,
      required DateTime data,
    }) async{
      try{
        final documento = await agendas.add({
          'UserId': userId,
          'IdDono': idDono,
          'IdPet': idPet,
          'Data': data,
        });
        final fetchedPet = await documento.get();
        return Agenda(
          dataId: documento.id,
          data: fetchedPet.data()!['Data'].toDate(),
          userId: fetchedPet.data()!['UserId'],
          donoId: fetchedPet.data()!['IdDono'],
          petId: fetchedPet.data()!['IdPet'],
        );
      }catch(e){
        throw CouldNotCreateException();
      }
    }
    //update the CRUD for agendas
    Future<void> updateAgenda({
      required String documentId,
      required String userId,
      required String idDono,
      required String idPet,
      required DateTime data,
    }) async{
      try{
        await agendas.doc(documentId).update({
          'UserId': userId,
          'IdDono': idDono,
          'IdPet': idPet,
          'Data': data,
        });
      }catch(e){
        throw CouldNotUpdateException();
      }
    }
    //delete the CRUD for agendas
    Future<void> deleteAgenda({
      required String documentId,
    }) async{
      try{
        await agendas.doc(documentId).delete();
      }catch(e){
        throw CouldNotDeleteException();
      }
    }
    //get the CRUD for agendas
    Stream<Iterable<Agenda>> allAgendas({required String userId}) =>
      agendas.snapshots().map((event) => event.docs.map((e) => Agenda.fromSnapshot(e)).where((element) => element.userId == userId));
    //get the agendas
      Future<Iterable<Agenda>> getAgendas({required String userId}) async{
        try{
          final query = await agendas.get();
          return await agendas.where('UserId', isEqualTo: userId).get().then((value) => value.docs.map((e) { return Agenda.fromSnapshot(e);}));
        }catch(e){
          throw CouldNotGetAllItemsException();
        }
      }
      
    //create the CRUD for pets
    Future<Pet> createPet({
      required String userId,
      required String idDono,
      required String nome,
      required String tipoPet
    }) async{
      try{
        final documento = await pets.add({
          'UserId': userId,
          'IdDono': idDono,
          'Nome': nome,
          'TipoPet': tipoPet
        });
        final fetchedPet = await documento.get();
        return Pet(
          petId: fetchedPet.id,
          userId: fetchedPet.data()!['UserId'],
          idDono: fetchedPet.data()!['IdDono'],
          nome: fetchedPet.data()!['Nome'],
          tipoPet: fetchedPet.data()!['TipoPet']
        );
      }catch(e){
        throw CouldNotCreateException();
      }
    }
    //update the CRUD for pets
    Future<void> updatePet({
      required String documentId,
      required String userId,
      required String idDono,
      required String nome,
      required String tipoPet
    }) async{
      try{
        await pets.doc(documentId).update({
          'UserId': userId,
          'IdDono': idDono,
          'Nome': nome,
          'TipoPet': tipoPet
        });
      }catch(e){
        throw CouldNotUpdateException();
      }
    }
    //delete the CRUD for pets
    Future<void> deletePet({required String documentId}) async{
      try{
        await pets.doc(documentId).delete();
      }catch(e){
        throw CouldNotDeleteException();
      }
    }
    //get all pets
    Stream<Iterable<Pet>> allPets({required String userId}) =>
      pets.snapshots().map((event) => event.docs.map((e) => Pet.fromSnapshot(e)).where((element) => element.userId == userId));
    //get the pets
    Future<Iterable<Pet>> getPets({required String userId}) async{
      try{
        return await pets.where('UserId', isEqualTo: userId).get().then((value) => value.docs.map((e) { return Pet.fromSnapshot(e);}
        ));
      }catch(e){
        throw CouldNotGetAllItemsException();
      }
    }

    Future<Iterable<Pet>> getPetsbyClienteId({required String clienteId}) async{
      try{
        return await pets.where('IdDono', isEqualTo: clienteId).get().then((value) => value.docs.map((e) { return Pet.fromSnapshot(e);}
        ));
      }catch(e){
        throw CouldNotGetAllItemsException();
      }
    }
    
    Future<void> updateCliente({
      required String documentId,
      required String nome,
      required String endereco,
      required int atendimentos
    }) async{
      try{
        await clientes.doc(documentId).update({
          'Nome': nome,
          'Endereco': endereco,
          'Atendimentos': atendimentos
        });
      }catch(e){
        throw CouldNotUpdateException();
      }
    }

    Future<void> deleteCliente({required String documentId}) async{
      try{
        await clientes.doc(documentId).delete();
      }catch(e){
        throw CouldNotDeleteException();
      }
    }

    Stream<Iterable<Cliente>> allClientes({required String userId}) =>
      clientes.snapshots().map((event) => event.docs.map((e) => Cliente.fromSnapshot(e)).where((element) => element.userId == userId));
    

    Future<Iterable<Cliente>>getClientes({required String userId}) async{
      try{
        return await clientes.where('UserId', isEqualTo: userId).get().then((value) => value.docs.map((e) { return Cliente(
          clienteId: e.id,
          userId: e.data()['UserId'],
          nome: e.data()['Nome'],
          atendimentos: e.data()['Atendimentos'],
          endereco: e.data()['Endereço']
        );}
        ));
      }catch(e){
        throw CouldNotGetAllItemsException();
      }
    }
    
    Future<Cliente> createCliente({required String userId, required String nome, required String endereco})async {
      final document = await clientes.add({
        'UserId': userId,
        'Nome': nome,
        'Endereco': endereco,
        'Atendimentos': 0
      });
      final fetchedCliente = await document.get();
      return Cliente(
        clienteId: fetchedCliente.id,
        userId: fetchedCliente.data()!['UserId'],
        nome: fetchedCliente.data()!['Nome'],
        endereco: fetchedCliente.data()!['Endereco'],
        atendimentos: fetchedCliente.data()!['Atendimentos']
      );
    }

    static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();
    FirebaseCloudStorage._sharedInstance();
    factory FirebaseCloudStorage() => _shared;
  }