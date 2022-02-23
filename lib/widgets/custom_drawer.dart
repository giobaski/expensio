import 'package:expensio/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final AuthController authController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          // Text(username),
          UserAccountsDrawerHeader(
            accountName: Text(authController.firebaseUser.value!.displayName?? "Name"),
            accountEmail: Text(authController.firebaseUser.value!.email?? "email"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              child: Text("O _ O", style: TextStyle(fontSize: 14.0),),
            ),
            decoration:BoxDecoration(
              color: Colors.indigo[700],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Update the state of the app.
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Get.toNamed("/profile");
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.history),
          //   title: const Text('ჩემი განვადებები'),
          //   onTap: () {
          //     // Update the state of the app.
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('პარამეტრები'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          Card(
            // color: Colors.indigo[100],
            elevation: 5,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              onTap: () {
                Get.defaultDialog(
                  title: "Logout",
                  content: Text("Are you sure?"),
                  confirm: OutlinedButton(
                      onPressed: () {
                        authController.logout();
                      },
                      child: Text("Yes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent))),
                  cancel: OutlinedButton(
                      onPressed: () {
                        Get.back();
                        print(Get.isDialogOpen);
                      },
                      child: Text("No",
                          style: TextStyle(color: Colors.black))),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Version 0.0.1"),
          ),
        ],
      ),
    );
  }
}