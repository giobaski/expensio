import 'package:expensio/controllers/auth_controller.dart';
import 'package:expensio/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text("Hello ${AuthController.instance.firebaseUser.value!.email}"),
      ),
    );
  }
}
