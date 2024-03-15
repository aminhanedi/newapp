import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:newapp/src/features/authentication/screens/welcome/welcome_screen.dart';

class splash_controoler{
  void isLogin(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds:10),
      ()=>Get.to(()=>dashboard()));
    }else{
      Timer(Duration(seconds: 10),
              ()=>Get.to(()=>Welcome()));
    }
  }
}