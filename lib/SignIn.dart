import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newapp/firebase_options.dart';
import 'package:newapp/src/features/authentication/controllers/network_controller/dependency_controller.dart';
import 'package:newapp/src/features/authentication/screens/splash_screen/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
     //.then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
  DependencyInjection.init();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      //themeMode: ThemeMode.system,
    //  theme: AppTheme.lightTheme,
     // darkTheme: AppTheme.darkTheme,
      home: splashScreen(),
    );
  }
}

