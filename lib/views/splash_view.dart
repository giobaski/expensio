import 'dart:async';
import 'package:flutter/material.dart';

import 'package:expensio/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final authController = Get.put(AuthController(), permanent: true);


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          Get.arguments ?? "#Welcome",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => Get.to(() => HomePage()),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.2,
                  0.9,
                ],
                colors: [
                  Colors.indigoAccent,
                  Colors.indigo,
                ],
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icon.png',
                  width: 250,
                  height: height * 0.1,
                  color: Colors.white,
                ),
                SizedBox(height: 25),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text('EXPENSIO!',
                    style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Track your expenses with us!', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  child: Text("Get Started"),
                  style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                  onPressed: () {
                    authController.isLogged.value
                        ? Get.off(() => HomePage())
                        : Get.off(() => LoginPage());
                  },
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
