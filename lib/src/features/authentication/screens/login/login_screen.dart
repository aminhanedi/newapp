import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/forget_password/forget_password_email/forget_password_email.dart';
import 'package:newapp/src/features/authentication/screens/signup/signup.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import '../../../../services/google_auth.dart';
import '../dashboard_screen/dashboard_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  String email = "", password = "";
  TextEditingController EmailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void dispose() {
    EmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> userLoginRegistration() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => dashboard(),
          maintainState: false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "User not found") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "No user found for that Email",
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Wrong password provided by user",
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  //-------------email validator--------------//
  void validEmail() {
    bool isValid = EmailValidator.validate(EmailController.text.trim());
    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          "Valid Email ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.green,
            backgroundColor: Colors.white,
          ),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "Enter a Registered Email ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );
    }
    //------------------------finished------------------------//
  }

  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Lottie.asset('assets/images/tailoring.json',
                              height: 300)),
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.welcomeB,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    AppLocalizations.of(context)!.makeIt,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Form(
                      key: _formkey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .requiredField;
                                }
                                return null;
                              },
                              controller: EmailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: AppLocalizations.of(context)!.email,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .requiredField;
                                }
                                return null;
                              },
                              maxLength: 16,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.fingerprint),
                                labelText:
                                    AppLocalizations.of(context)!.password,
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 20), //forget password //
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      context: context,
                                      builder: (context) => Container(
                                        padding: EdgeInsets.all(tDefaultSize),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              tForgetPasswordTitle,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const Text(
                                              tForgetPasswordSubTitle,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade200,
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .mail_outline_rounded,
                                                      size: 60,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          tEmail,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              Get.to(() =>
                                                                  const forget_pass_mail_screen());
                                                            },
                                                            child: const Text(
                                                              tResetViaEMail,
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .blue),
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.forgetP)),
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          email = EmailController.text;
                                          password = passwordController.text;
                                          validEmail();
                                        });
                                      }

                                      userLoginRegistration();
                                    },
                                    child: Text(tLogin.toUpperCase()))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("OR "),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                      icon: Image(
                                        image: AssetImage(tGoogleImage),
                                        width: 20,
                                      ),
                                      onPressed: () {
                                        AuthMethods().signInWithGoogle(context);
                                      },
                                      label: Text(
                                          AppLocalizations.of(context)!.signW)),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(() => const signup_screen());
                                    },
                                    child: Text.rich(TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .dontHave,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        children: [
                                          TextSpan(
                                              text: tSignup,
                                              style:
                                                  TextStyle(color: Colors.blue))
                                        ])))
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
