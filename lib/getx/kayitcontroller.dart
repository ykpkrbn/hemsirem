import 'package:cloud_firestore/cloud_firestore.dart';import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/my_text.dart';
import '../widgets/my_textfield.dart';

class KayitController extends GetxController{
  static KayitController get to => Get.find();
  late TextEditingController nameController, passwordController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  @override
  void onInit(){
    super.onInit();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    collectionReference = firebaseFirestore.collection("insanlar");
  }

  bool kayitliMi = true;
  void kayitKontrol (){
    kayitliMi = !kayitliMi;
    update();
  }

  myUstTextKontrol(){
    return kayitliMi == true
        ? const MyText(
      "Giriş",
      size: 46,
      fontWeight: FontWeight.w800,
    )
        : const MyText(
      "Kayıt",
      size: 46,
      fontWeight: FontWeight.w800,
    );
  }

   mySizeBoxKontol(){
    return kayitliMi == true
        ? const SizedBox(height: 0)
        : const SizedBox(height: 20);
  }

  myTextKontrol(){
    return kayitliMi == true
        ? const Center()
        : const MyTextField(
      //textEditingController: _password2EditingController,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      hintText: "Parola Tekrar",
      icon: Icons.vpn_key,
      obscureText: true,
    );
  }

  myTextButonKontrol(){
    return kayitliMi == true
        ? const Text("Hesabım Yok Kayıt Olayım")
        : const Text("Hesabım Var Giriş Yapayım");
  }

  myMaterialButonKontrol(){
    return kayitliMi == true
        ? const MyText("Giriş Yap")
        : const MyText("Kayıt Ol");
  }
}