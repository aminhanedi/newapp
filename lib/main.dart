// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';
// import 'package:newapp/firebase_options.dart';
// import 'package:newapp/src/features/authentication/screens/splash_screen/splash_screen.dart';
// import 'package:newapp/src/repository/authentecation_repository/authentecation_repository.dart';
// import 'package:newapp/src/utils/theme.dart';
//
// main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
//       .then((value) => Get.put(AuthenticationRepository()));
//   runApp(Myapp());
//
//
//
// }
// class Myapp extends StatelessWidget {
//   const Myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return   MaterialApp(
//
//         theme: AppTheme.lightTheme,
//         darkTheme: AppTheme.darkTheme,
//         themeMode: ThemeMode.system,
//         home: splashScreen(),
//
//     );
//   }
// }
