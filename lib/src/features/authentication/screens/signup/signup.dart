import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newapp/src/common_wighets/form/form_header_widget.dart';
import 'package:newapp/src/constants/color.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:newapp/src/features/authentication/screens/login/login_screen.dart';
import 'package:newapp/src/services/google_auth.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';



class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}
class _signup_screenState extends State<signup_screen> {

  String fullName = "", Email = "", password = "";
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {

    fullNameController.dispose();
    EmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  //------------------REGISTRATION-----------------//
  registration() async {
    if (password != null &&
        fullNameController.text != "" &&
        EmailController.text != "") {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text,
          password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(
                AppLocalizations.of(context)!.registered,
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => dashboard(),
            maintainState: false,
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(    AppLocalizations.of(context)!.weakP,),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(
                AppLocalizations.of(context)!.accountA,
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
      }
    }
  }
  //-----------password aye------------//
  bool _passwordVisible = false;
  //-------------email validator--------------//
      void  validEmail(){
       bool isValid= EmailValidator.validate(EmailController.text.trim());
       if(isValid){
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               backgroundColor: Colors.white,
               content: Text(    AppLocalizations.of(context)!.validE,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.green,backgroundColor: Colors.white,),),
             ));
       }else{
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               backgroundColor: Colors.white,
               content: Text(    AppLocalizations.of(context)!.enterA,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.red,backgroundColor: Colors.white,),),
             ),);
       }

   //------------------------finished------------------------//
  }
  @override
  Widget build(BuildContext context) {
    // final controller=Get.put(SignUpController());

    return WillPopScope(
      onWillPop: () async => false,

      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("  "),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   FormHeaderWidget(
                      image: twelcon_image,
                      title: AppLocalizations.of(context)!.getO,
                      subTitle:AppLocalizations.of(context)!.createYourAcc),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: tDefaultSize - 10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.pleaseN;
                              }
                              return null;
                            },
                            maxLength: 16,
                            controller: fullNameController,

                            decoration:  InputDecoration(
                              label: Text(
                                AppLocalizations.of(context)!.name
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
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            maxLength: 30,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.requiredField;

                              }else if (value==" !#''%^&*()+-][}{/,? "){
                                return AppLocalizations.of(context)!.pleaseE;
                              }
                              return null;
                            },
                            controller: EmailController,
                            decoration:  InputDecoration(
                              label: Text(
                                  AppLocalizations.of(context)!.email,
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
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                AppLocalizations.of(context)!.requiredField;
                              }
                              return null;
                            },
                            maxLength: 16,


                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.fingerprint),
                              labelText: AppLocalizations.of(context)!.password,
                              border: const OutlineInputBorder(),
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

                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {

                                        setState(() {
                                          Email = EmailController.text;
                                          fullName = fullNameController.text;
                                          password = passwordController.text;
                                         // validEmail();
                                        });
                                      }
                                      validEmail();
                                     registration();
                                    },
                                    child: Text(AppLocalizations.of(context)!.signup.toUpperCase())),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "OR",
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    AuthMethods().signInWithGoogle(context);

                                  },
                                  icon: Image.asset(
                                    tGoogleImage,
                                    width: 20.0,
                                  ),
                                  label: Text(AppLocalizations.of(context)!.signW),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const login_screen());

                                  },
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text:AppLocalizations.of(context)!.alreadyH,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    TextSpan(
                                      text: "LOGIN ",
                                    )
                                  ])))
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
      ),
    );
  }

  void snackBar(String message, {required Text context}) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ...
}
