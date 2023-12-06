import 'package:flutter/material.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/forget_password/forget_password_email/forget_password_email.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: const AssetImage(twelcon_image),
                  height: size.height * 0.2,
                ),
                Text(
                  tLoginTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  tLoginSubTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Form(
                    child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: tEmail,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const TextField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: tPassword,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20), //forget password //
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
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
                                                Icons.mail_outline_rounded,
                                                size: 60,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    tEmail,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (contaxt) =>
                                                                  forget_pass_mail_screen()),
                                                        );
                                                      },
                                                      child: const Text(
                                                        tResetViaEMail,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.blue),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
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
                                                Icons.mobile_friendly_outlined,
                                                size: 60,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    tPhoneNo,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (contaxt) =>
                                                                  forget_pass_mail_screen()),
                                                        );
                                                      },
                                                      child: const Text(
                                                        tResetViaPhone,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.blue),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Text(tForgetPassword)),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {},
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
                                onPressed: () {},
                                label: Text(tSignInWithGoogle)),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text.rich(TextSpan(
                                  text: tDontHaveAnAccount,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    TextSpan(
                                        text: tSignup,
                                        style: TextStyle(color: Colors.blue))
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
    );
  }
}
