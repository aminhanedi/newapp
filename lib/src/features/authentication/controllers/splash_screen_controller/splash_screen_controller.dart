



import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:newapp/src/features/authentication/screens/login/login_screen.dart';

class splash_controoler{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 5),
      ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard())));
    }else{
      Timer(Duration(seconds: 5),
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen())));
    }
  }
}