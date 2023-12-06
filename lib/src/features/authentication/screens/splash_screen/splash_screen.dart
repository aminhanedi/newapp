
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:newapp/src/constants/color.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import '../welcome/welcome_screen.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool animate = false;
 

  @override
  void initState() {
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(

          children: [
            AnimatedPositioned(
                duration: const Duration(microseconds: 1600),
                top: animate ? 0 : -30,
                left: animate ? 0 : -30,

                child: Image.asset("assets/images/top_logo1.png", width: 100,)
            ),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
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

                child: Image.asset("assets/images/top_logo3.png", width:200,height:450,)
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
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(Duration(milliseconds: 5000));
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(contaxt)=> Welcome() ),);

  }
}


