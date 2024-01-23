import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newapp/firebase_options.dart';
import 'package:newapp/src/features/authentication/controllers/network_controller/dependency_controller.dart';
import 'package:newapp/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:newapp/src/localization/language_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


Future<void> main() async {
  //---------------------firebase database initialization--------------------//
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//-------------network controller ------------------------//
  DependencyInjection.init();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context,Locale newLocal ){
    _MyAppState? state=context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocal);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      if (mounted) {
        setLocale(locale);
      }
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(

      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fa'), // Spanish
        // Add more supported locales as needed
      ],
      locale:_locale ,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: splashScreen(),


      ),
    );
  }

}




