import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hemsirem/firebase/auth_controller.dart';
import 'package:hemsirem/getx/vericontroller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  AuthController authController = AuthController();
  VeriController veriController = VeriController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(child: Text("Profil Page")),
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("Çıkış yapıldı. ${authController.logOutMethod()}");
                authController.logOutMethod();
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: veriController.userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Center(child: Text("Bi şeyler ters gitti"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['email']),
                subtitle: Text(data['password']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
