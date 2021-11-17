import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/widgets/auth_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  void submitAuth1(
      String email, String password, String username, bool isLogin) async {
    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (err) {
      var message = "An error Occured";
      if (message != null) {
        message = err.toString();
        print("This error occured" + err.toString());
        SnackBar(content: Text(message));
      }
    }
  }

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuth),
    );
  }

  final auth = FirebaseAuth.instance;
  void submitAuth(
      String email, String password, String username, bool isLogin) async {
    try {
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (err) {
      var message = "An error Occured";
      if (message != null) {
        message = err.toString();
        print("This error occured" + err.toString());
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }
}
