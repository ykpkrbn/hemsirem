import 'package:flutter/material.dart';
import 'package:hemsirem/firebase/auth_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Center(child: Text("Home Page")),
      ),
      body: Center(
        child: Text("asdasd"),
      )
    );
  }
}
