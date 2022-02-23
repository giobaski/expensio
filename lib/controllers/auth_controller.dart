import 'package:expensio/utils/dialogs.dart';
import 'package:expensio/views/home_page.dart';
import 'package:expensio/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  var isLogged = false.obs;
  var isLoading = false.obs;

  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _checkLoginStatus);
  }

  void _checkLoginStatus(User? firebaseUser) {
    if (firebaseUser == null) {
      isLogged.value = false;
      Get.offAll(() => LoginPage());
    } else {
      isLogged.value = true;
      Get.offAll(() => HomePage());
    }
  }


  void login(String email, String password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      MyDialogs.success("Signed in!", "");
    } catch (e){
      print(e.toString());
      MyDialogs.error("Sign in has failed!", "Try again");
    }

  }

  void register(String email, String password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      MyDialogs.success("registered!", "");
    } catch (e){
      print(e.toString());
      MyDialogs.error("Registration has failed!", "Try again");
    }
  }

  void logout() async {
    await auth.signOut();
  }



}