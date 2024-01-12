import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newapp/firebase_options.dart';
import 'package:newapp/src/features/authentication/controllers/network_controller/dependency_controller.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:newapp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:newapp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:newapp/src/utils/theme.dart';

Future<void> main() async {
  //---------------------firebase database initialization--------------------//
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//-------------network controller ------------------------//
  DependencyInjection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: splashScreen(),

        // StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const splashScreen();
        //     } else {
        //       if (snapshot.hasData) {
        //         return dashboard();
        //       } else {
        //         return Welcome();
        //       }
        //     }
        //   },
        // ),
      ),
    );
  }
}