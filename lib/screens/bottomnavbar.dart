import 'package:flutter/material.dart';
import 'package:hemsirem/screens/homepage.dart';
import 'package:hemsirem/screens/likepage.dart';
import 'package:hemsirem/screens/profilpage.dart';
import 'package:hemsirem/screens/searchpage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _curretIndex = 0;
  final screens = [
    HomePage(),
    SearchPage(),
    LikePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  screens[_curretIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _curretIndex,
        onTap: (i) {
          setState(() {
            _curretIndex = i;
          });
        },
        items: [
          /// Ana Sayfa
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Arama Sayfası
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Likes"),
            selectedColor: Colors.pink,
          ),


          /// Profil Sayfası
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profil"),
            selectedColor: Colors.teal,
          ),

        ],
      ),
    );
  }
}
