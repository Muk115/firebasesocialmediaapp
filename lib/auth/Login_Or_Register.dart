import 'package:firebasesocialmediaapp/Pages/Login_Page.dart';
import 'package:firebasesocialmediaapp/Pages/Register_page.dart';
import 'package:flutter/material.dart';

class LoginORRegister extends StatefulWidget {
  const LoginORRegister({Key? key}) : super(key: key);

  @override
  State<LoginORRegister> createState() => _LoginORRegisterState();
}

class _LoginORRegisterState extends State<LoginORRegister> {
  // initially show ligin page
  bool showLogin = true;

  // toggle between login and register page
  void toggleState (){
    setState(() {
      showLogin = !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLogin){
      return LoginPage(onTap: toggleState,);
    } else{
      return RegisterPage(onTap: toggleState,);
    }
  }
}
