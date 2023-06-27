import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/Agenda.dart';
import '../models/pet.dart';
import '../services/auth.service.dart';
import '../services/auth_user.dart';
import '../services/crud/firebase_cloud_storage.dart';

class UpdateAgendaPage extends StatefulWidget {
  final Agenda agenda;
  const UpdateAgendaPage({required this.agenda,super.key});

  @override
  State<UpdateAgendaPage> createState() => _UpdateAgendaPageState();
}

class _UpdateAgendaPageState extends State<UpdateAgendaPage> {
    late AuthUser _authUser;
    late DateTime? data = DateTime.now();
    late final FirebaseCloudStorage _service;
    final _formKey = GlobalKey<FormState>();
    TextEditingController dataController = TextEditingController();


  @override
  void initState(){
    super.initState();
    _authUser = AuthService.firebase().authUser!;
    _service = FirebaseCloudStorage();
    dataController.text = widget.agenda.data.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  controller: dataController,
                  decoration: InputDecoration(
                    labelText: "Data",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data é obrigatório';
                    }
                    return null;
                  },
                  onTap: () async{
                      data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now() ,
                        lastDate: DateTime(2025),
                      );
                      if(data != null){
                         dataController.text = data.toString();
                      }
                    },
                  
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    _service.updateAgenda(
                      data: data!,
                      documentId: widget.agenda.dataId,
                      idDono: widget.agenda.donoId,
                      idPet: widget.agenda.petId,
                      userId: _authUser.id
                    );
                    Navigator.pop(context);

                  }
                }, child: Text("Atualizar")),
              ],
            ),

          ),
        ),
      ),
    );
  }
}