import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemsirem/screens/bottomnavbar.dart';

import '../screens/loginpage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  late TextEditingController emailController, passwordController;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    collectionReference = firebaseFirestore.collection("user");
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  /// Kullanıcı Giriş Yapıp yapmadığını kontrol eden method
  _initialScreen(User? user) {
    if (user == null) {
      debugPrint("Kullanıcı Yok. Login Page Sayfasına Yönlendir");
      Get.offAll(() => const LoginPage());
    } else {
      debugPrint("Kullanıcı Giriş Yapmış. AnaSayfa Page Sayfasına Yönlendir");
      Get.offAll(() => const BottomNavBar());
    }
  }

  /// Kayıt Ol Methodu
  Future<User?> registerMethod(String email, String password, String telefonNo) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await collectionReference.doc(user.user?.uid ?? "").set({
        "email" : email,
        "password" : password,
        "telefonNo" : telefonNo
      }).whenComplete(() {
        Get.snackbar("Kayıt Başarılı", "Kullanıcı kaydı başarılı");
      });
      return user.user;
    } catch (e) {
      Get.snackbar(
        "Kayıt Hakkında",
        "Kullanıcı Mesajı",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        titleText: const Text(
          "Kayıt Olurken Bir Hata Yaşandı.",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  /// test@test.com
  /// test123test
  /// Giriş Yap Methodu
  Future<User?> loginMethod(String email, String password) async {
    try {
      var user = await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Giriş Başarılı", "Sayın Kullanıcı hoşgeldiniz",
          duration: const Duration(seconds: 20));
      return user.user;
    } catch (e) {
      Get.snackbar(
        "Giriş Hakkında",
        "Kullanıcı Mesajı",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        titleText: const Text(
          "Giriş Yaparken Bir Hata Yaşandı.",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  /// Email Değişikliği yap
  void resetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Get.snackbar(
        "Email Değişikliği Hakkında",
        "Kullanıcı Mesajı",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        titleText: const Text(
          "Email Değişikliği Yaparken Bir Hata Yaşandı.",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  /// Çıkış yap methodu
  logOutMethod() async {
    try {
      await auth.signOut();
      Get.snackbar(
        "Çıkış Hakkında",
        "Kullanıcı Mesajı",
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade800,
        titleText: const Text(
          "Başarılı Bir Çıkış Yapıldı",
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          "Çıkış Başarılı",
          style: TextStyle(color: Colors.white),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Çıkış Hakkında",
        "Kullanıcı Mesajı",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        titleText: const Text(
          "Çıkış Yaparken Bir Hata Yaşandı.",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

}
