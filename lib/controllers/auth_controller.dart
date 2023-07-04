import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sign up function

  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Do something after successful sign-in
    } catch (error) {
      // Handle sign-in error

      const GetSnackBar(
        title: 'error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        duration: Duration(seconds: 1),
      );
    }
    // Notify listeners
    update();
  }

  // sign in function

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle the case when the user is not found
        Get.snackbar(
          'Error',
          'No user found with that email address.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        // Handle the case when the password is incorrect
        Get.snackbar(
          'Error',
          'Wrong password provided for that user.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Handle other exceptions
        Get.snackbar(
          'Error',
          'An error occurred, please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Handle other exceptions
      Get.snackbar('Error', 'please try again later');
    }
  }
}
