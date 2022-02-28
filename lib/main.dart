import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hemsirem/screens/loginpage.dart';
import 'package:hemsirem/screens/profilpage.dart';
import 'firebase/auth_controller.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Hemşirem",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(
        backgroundColor: Colors.purple
      )),
      home: LoginPage(),
      getPages: [
        GetPage(name: "/profilPage", page: () => ProfilePage())
      ],
    );
  }
}