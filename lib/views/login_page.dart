import 'package:expensio/controllers/auth_controller.dart';
import 'package:expensio/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          // color: Colors.indigo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Start building login form
              SizedBox(height: 50),
              _buildEmailTextField(),
              _buildPasswordTextField(),
              _buildForgotPasswordBtn(),
              _buildLoginBtn(),
              TextButton(
                  onPressed: () => {
                    Get.toNamed('/register')
                  },
                  child: Text("Don't have an account? create here", style: TextStyle(color: Colors.indigoAccent),)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.email, color: Colors.indigoAccent),
            labelText: 'username',
            contentPadding: EdgeInsets.all(0),
          ),
        ),
      ],
    );
  }


  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: _isObscure,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.lock, color: Colors.indigoAccent),
            suffixIcon: IconButton(
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            labelText: 'password',
            contentPadding: EdgeInsets.all(0),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () => {
            Get.toNamed('/password-change')
          },
          child: Text("Forgot your password?", style: TextStyle(color: Colors.indigoAccent),)),
    );
  }

  Widget _buildLoginBtn() {
    return Obx(() =>
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  // primary: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
              ),
              onPressed: authController.isLoading.value
                  ? null
                  : () {
                if(_emailController.text.isEmpty ||_passwordController.text.isEmpty ){
                  MyDialogs.error("Shouldn't be empty!", "please fill both inputs");
                  return;
                }
                authController.login(_emailController.text, _passwordController.text);
              },
              child: authController.isLoading.value
                  ? Text("loading...") // CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
                  : Text("Sign In")
          ),
        )
    );
  }





}
