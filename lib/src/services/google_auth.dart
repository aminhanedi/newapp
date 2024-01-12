import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:newapp/src/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    try {
      UserCredential result =
      await auth.signInWithCredential(credential);
      User? userDetails = result.user;
      if (result.user != null) {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails?.email,
          "name": userDetails?.displayName,
          "id": userDetails?.uid,
        };

        await DatabaseMethod().addUser(userDetails!.uid, userInfoMap);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => dashboard()),
        );
      }
      const snackBar = SnackBar(
        backgroundColor: Colors.white,
        content: Text('You logged in successfully ',style: TextStyle(fontSize: 20,color: Colors.blue) ,),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);


    } catch (e) {
      // Handle any errors
      print('Error signing in with Google: $e');
    }
  }
}