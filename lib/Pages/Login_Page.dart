import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/Components/My_Button.dart';
import 'package:firebasesocialmediaapp/Components/My_TextField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signIn () async{
    showDialog(context: context, builder: (context){
      return Center(child: const CircularProgressIndicator());
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text
      );
      Navigator.pop(context);

    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      showErrorMessage(e.code);

    }



  }

  // method to display error message
  void showErrorMessage (String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.red,
        title: Text(
          message,
          style: const TextStyle(
            color: Colors.white

          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(Icons.lock, size: 100,),

                // Welcoe back message
                const SizedBox(height: 50,),
                Text(
                  'Welcome back you\'ve been missed ',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16
                  ),
                ),
                // Email textfield
                const SizedBox(height: 25,),
                MyTextField(
                  controller: emailcontroller,
                    hintText: 'Enter your Email',
                    isObscure: false
                ),
                const SizedBox(height: 10,),
                // password Textfield
                MyTextField(
                  controller: passwordcontroller,
                    hintText: 'Enter your password',
                    isObscure: true
                ),
                const SizedBox(height: 25,),
                // sign in
                MyButton(onTap: signIn, text: 'Sign In'),
                const SizedBox(height: 25,),

                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                          color: Colors.grey[700]
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue
                        ),
                      ),
                    ),

                  ],)
              ],
            ),
          ),
        ),
      ),

    );
  }
}
