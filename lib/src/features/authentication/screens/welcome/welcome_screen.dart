import 'package:flutter/material.dart';
import 'package:newapp/src/constants/color.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/login/login_screen.dart';
import 'package:newapp/src/features/authentication/screens/signup/signup.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var he = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = Brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          // backgroundColor: isDarkMode? tSecondaryColor:twhiteColor,
          body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(
                twelcon_image,
              ),
              height: he * 0.4,
            ),
            Text(AppLocalizations.of(context)!.welcomeB, style: Theme.of(context).textTheme.displaySmall),
            Text(
                AppLocalizations.of(context)!.welcomeSubtitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                              builder: (contaxt) =>  login_screen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            foregroundColor: tSecondaryColor,
                            backgroundColor: tPrimaryColor,
                            side: BorderSide(color: tSecondaryColor),
                            padding:
                                const EdgeInsets.symmetric(vertical: tButtonHeight)),
                        child: Text(tLogin.toUpperCase()),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (contaxt) => const signup_screen()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(),
                              backgroundColor: tSecondaryColor,
                              elevation: 0,
                              foregroundColor: twhiteColor,
                              side: BorderSide(color: tSecondaryColor),
                              padding:
                                  EdgeInsets.symmetric(vertical: tButtonHeight)),
                          child: Text(tSignup.toUpperCase())),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
