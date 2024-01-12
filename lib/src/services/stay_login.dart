import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StayLoggedIn extends StatefulWidget {
  const StayLoggedIn({Key? key}) : super(key: key);

  @override
  State<StayLoggedIn> createState() => _StayLoggedInState();
}

class _StayLoggedInState extends State<StayLoggedIn> {
  User? user;

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  Future<void> checkCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        user = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(user != null ? 'User is logged in' : 'User is not logged in'),
    );
  }
}