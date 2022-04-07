import 'dart:convert';

import 'package:expensio/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.black38,
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.edit))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(0), // Border radius
              child: ClipOval(child: Image.asset('assets/images/profile.jpeg', //Image.memory(base64Decode(base64String),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 70, top: 10),
            child: Text("PERSONAL INFORMATION", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, color: Colors.grey),),
          ),
          Divider(thickness: 2),

          ListTile(
              leading: Icon(Icons.person),
              title: Text("Username:", style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("${AuthController.instance.firebaseUser.value!.displayName?? "No Name"}"),
              dense: true,
              trailing: Icon(Icons.verified, color: Colors.teal)
          ),
          ListTile(
            leading: Icon(Icons.art_track),
            title: Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(AuthController.instance.firebaseUser.value!.email?? "000000000000"),
            dense: true,
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(AuthController.instance.firebaseUser.value!.phoneNumber?? "xxx-xx-xx-xx"),
            dense: true,
          ),
          ListTile(
            leading: Icon(Icons.visibility_off),
            title: Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("*********"),
            trailing: TextButton(
              child: Text("CHANGE", style: TextStyle(color: Colors.grey, fontSize: 12,)),
              onPressed: (){
                Get.toNamed('/password-change-from-profile');
              },),
            dense: true,
          ),
        ],
      ),
    );
  }


}