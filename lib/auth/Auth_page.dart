
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/auth/Login_Or_Register.dart';
import 'package:flutter/material.dart';

import '../Pages/HomePage.dart';

class authPage extends StatelessWidget {
  const authPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        builder: (context, snapshot){
          if(snapshot.hasData){
            // if user is logged in
            return HomePage();
          } else {
            // if user is not logged in
            return LoginORRegister();
          }

        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),

    );
  }
}

