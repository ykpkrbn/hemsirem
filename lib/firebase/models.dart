import 'package:cloud_firestore/cloud_firestore.dart';

class InsanModel {
  //String? docId;
 // String? name;
  String? email;
  String? password;

  InsanModel({this.email, this.password});

  InsanModel.fromMap(DocumentSnapshot data){
    // docId = data.id ?? "";
    // name = data["name"] ?? "";
    email = data["email"];
    password = data["password"];
  }
}
