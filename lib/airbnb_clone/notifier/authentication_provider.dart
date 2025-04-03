import 'package:airbnb_flutter_clone/airbnb_clone/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider extends ChangeNotifier {
  /// Function to sign up a new user using email and password.
  Future<void> signup(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Success")),
      );
      debugPrint('SUCCESS'); // Sign-up successful

      await Future.delayed(Duration(seconds: 3));
      // Navigate to HomeScreen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString()); // Catch any other errors
    }
  }

  /// Function to sign in an existing user using email and password.
  Future<void> signin(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Success")),
      );
      debugPrint('SUCCESS Login'); // Login successful

      await Future.delayed(Duration(seconds: 3));
      // Navigate to HomeScreen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }
}
