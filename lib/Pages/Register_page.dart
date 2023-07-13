import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesocialmediaapp/Components/My_Button.dart';
import 'package:firebasesocialmediaapp/Components/My_TextField.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();


  void signUp () async{
    // loading
    showDialog(context: context, builder: (context){
      return Center(child: const CircularProgressIndicator());
    });
    if (passwordcontroller.text != confirmpasswordcontroller.text){
      // pop loading
      Navigator.pop(context);

      // show error message
      showErrorMessage('Passwords don\'t match');
      return;

    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  const SizedBox(height: 50,),
                  Icon(Icons.lock, size: 100,),

                  // Welcoe back message
                  const SizedBox(height: 50,),
                  Text(
                    'Lets\'s create an account for you ',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16
                    ),
                  ),
                  // Email textfield
                  const SizedBox(height: 25,),
                  // Email textfield
                  MyTextField(
                      controller: emailcontroller,
                      hintText: 'Email',
                      isObscure: false
                  ),
                  const SizedBox(height: 10,),
                  // password Textfield
                  MyTextField(
                      controller: passwordcontroller,
                      hintText: 'Password',
                      isObscure: true
                  ),
                  const SizedBox(height: 10,),
                  MyTextField(
                      controller: confirmpasswordcontroller,
                      hintText: 'Confirm Password',
                      isObscure: true
                  ),
                  const SizedBox(height: 25,),
                  // sign in
                  MyButton(onTap: signUp, text: 'Sign Up'),
                  const SizedBox(height: 25,),

                  // register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: Colors.grey[700]
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now?',
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
      ),

    );
  }
}
