
import 'dart:ffi';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:newapp/src/constants/color.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/controllers/splash_screen_controller/splash_screen_controller.dart';
import '../welcome/welcome_screen.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool animate = false;

  splash_controoler splashScreen = splash_controoler();
  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
    startAnimation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(

          children: [

            AnimatedPositioned(
                duration: const Duration(seconds: 3),
                top: 150,
                left: animate? tDefaultSize: -80,

                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity:animate ? 1 :0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(tAppName, style: TextStyle(fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),),
                      Text(tAppTagline, style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,),
                    ],
                  ),
                )
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2600),
                bottom : animate? 100:0,
                left: 80,

                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius:250.0,
                  duration: Duration(milliseconds:1010),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(     // Replace this child with your own
                    elevation:30.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                       child:  Lottie.asset('assets/images/tailoring.json',height:300),
                      radius:150.0,
                    ),
                  ),
                ),

              ],
            ),
            ),
            Positioned(
                bottom: 100,
                right: tDefaultSize,
                child: Container(
                  width: tSplashContainerSize,
                  height: tSplashContainerSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tPrimaryColor
                  ),
                )

            ),


          ],
        ),
      ),

    );
  }

  Future startAnimation() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() => animate = true);
    await Future.delayed(Duration(seconds: 3));

  }
}


