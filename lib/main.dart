import 'package:expensio/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expensio/views/home_page.dart';
import 'package:expensio/views/login_page.dart';
import 'package:expensio/views/register_page.dart';
import 'package:expensio/views/splash_view.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expensio App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        // colorScheme: ColorScheme.dark(),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: Colors.indigoAccent,
                elevation: 1,
                padding: EdgeInsets.all(5),
                minimumSize: Size(100, 35),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)))),
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashView()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile', page: () => ProfilePage()),

      ],
    );
  }
}
