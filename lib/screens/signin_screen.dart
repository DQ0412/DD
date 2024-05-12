import 'dart:js';

import 'package:app/screens/admin/home_admin_screen.dart';
import 'package:app/screens/change_password_screen.dart';
import 'package:app/screens/signup_screen.dart';
import 'package:app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:app/reusable_widgets/reusable_widget.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  Future<void> _signIn(BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    )
        .then((value) {
      if (_emailTextController.text == 'diemquynhqqq@gmail.com') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeAdminScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  } on FirebaseAuthException catch (e) {
    _showErrorDialog(context, e.code);
  }
}

  void _showErrorDialog(BuildContext context, String errorCode) {
    String errorMessage;
    switch (errorCode) {
      case 'user-not-found':
      case 'wrong-password':
        errorMessage = 'The email or password you entered is incorrect.';
        break;
      default:
        errorMessage = 'An unknown error occurred.';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SignInBody(
        emailTextController: _emailTextController,
        passwordTextController: _passwordTextController,
        signIn: _signIn,
      ),
    );
  }
}

class _SignInBody extends StatelessWidget {
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final Future<void> Function(BuildContext) signIn;

  const _SignInBody({
    Key? key,
    required this.emailTextController,
    required this.passwordTextController,
    required this.signIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).size.height * 0.15,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              reusableTextField(
                "Enter UserName",
                Icons.person_outline,
                false,
                emailTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                "Enter Password",
                Icons.lock_outline,
                true,
                passwordTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPassword()),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              firebaseUIButton(
                context,
                "Sign In",
                () {
                  signIn(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              signUpOption(context),
            ],
          ),
        ),
      ),
    );
  }
}

Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account?",
        style: TextStyle(color: Colors.white70),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      const SizedBox(width: 16),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
          );
        },
        child: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );
}