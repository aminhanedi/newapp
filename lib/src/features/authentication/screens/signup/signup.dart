import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:newapp/src/common_wighets/form/form_header_widget.dart';
import 'package:newapp/src/constants/color.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/controller/signup_controllr.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(SignUpController());
    final _formkey=GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormHeaderWidget(
                    image: twelcon_image,
                    title: tSignupTitle,
                    subTitle: tSignupSubTitle),
                Container(
                  padding: EdgeInsets.symmetric(vertical: tDefaultSize - 10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller:controller.fullName,
                          decoration: const InputDecoration(
                            label: Text(
                              "FULL NAME",
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: tSecondaryColor,
                            ),
                            labelStyle: TextStyle(
                              color: tSecondaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor)),
                          ),
                        ),
                        TextFormField(
                          controller:controller.email,
                          decoration: const InputDecoration(
                            label: Text(
                              "E-MAIL",
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.email,
                              color: tSecondaryColor,
                            ),
                            labelStyle: TextStyle(
                              color: tSecondaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor)),
                          ),
                        ),
                        TextFormField(
                          controller:controller.phoneNo,
                          decoration: const InputDecoration(
                            label: Text(
                              "PHONE NUMBER",
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.numbers,
                              color: tSecondaryColor,
                            ),
                            labelStyle: TextStyle(
                              color: tSecondaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor)),
                          ),
                        ),
                        TextFormField(
                          controller:controller.password,
                          decoration: const InputDecoration(
                            label: Text(
                              "PASSWORD",
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.fingerprint,
                              color: tSecondaryColor,
                            ),
                            labelStyle: TextStyle(
                              color: tSecondaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2.0, color: tSecondaryColor)),
                          ),

                        ),
                          SizedBox(
                            height: 15.0,
                          ),
                        Column(

                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                              }
                              },
                                  child: Text("SIGNUP".toUpperCase())
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("OR",),
                            SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(onPressed: () {

                              }, icon:
                              Image.asset(tGoogleImage, width: 20.0,),
                                label: Text("Signup with google"),),
                            ),
                            TextButton(onPressed: () {}, child:  Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Already Have An Account ",style: Theme.of(context).textTheme.bodySmall),
                                      TextSpan(text: "LOGIN ",)
                                    ]
                                )


                            )
                            )

                          ],
                        )

                      ],
                    ),
                  ),

                )

              ],

            ),
          ),
        ),
      ),
    );
  }
}
