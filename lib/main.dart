import 'package:firebase_core/firebase_core.dart';
import 'package:firebasesocialmediaapp/auth/Login_Or_Register.dart';
import 'package:flutter/material.dart';

import 'Pages/Login_Page.dart';
import 'Pages/Register_page.dart';
import 'auth/Auth_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: authPage(),
    );
  }
}


