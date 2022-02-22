import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isLogged = false.obs;
  var isLoading = false.obs;

  void login(String username, String password) {
    debugPrint("sign in...");

  }

}