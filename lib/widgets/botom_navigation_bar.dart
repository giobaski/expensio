import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomnavigationBar extends StatefulWidget {
  MyBottomnavigationBar({Key? key,}) : super(key: key);

  @override
  State<MyBottomnavigationBar> createState() => _MyBottomnavigationBarState();
}

class _MyBottomnavigationBarState extends State<MyBottomnavigationBar> {

  // final AuthController authController = Get.find();
  final screens = ["/home", "/profile", "/support",];
  // int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return
      BottomNavigationBar(
      iconSize: 20,
      selectedFontSize: 14,
      selectedItemColor: Colors.grey[100],
      elevation: 1,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Help',
          // backgroundColor: Colors.blueGrey
        ),
      ],
      currentIndex: 0,
      onTap: (index){}
        );
  }
}
