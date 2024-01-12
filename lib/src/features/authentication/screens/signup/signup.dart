import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/src/common_wighets/form/form_header_widget.dart';
import 'package:newapp/src/constants/color.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:newapp/src/features/authentication/screens/login/login_screen.dart';
import 'package:newapp/src/services/google_auth.dart';



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
          const SnackBar(
            content: Text(
              "Registered successfully",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const dashboard()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password provided is too weak"),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Account already exists",
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
             const SnackBar(
               backgroundColor: Colors.white,
               content: Text("Valid Email ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.green,backgroundColor: Colors.white,),),
             ));
       }else{
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
               backgroundColor: Colors.white,
               content: Text("Enter a Valid Email ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.red,backgroundColor: Colors.white,),),
             ),);
       }

   //------------------------finished------------------------//
  }
  @override
  Widget build(BuildContext context) {
    // final controller=Get.put(SignUpController());

    return SafeArea(
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
                const FormHeaderWidget(
                    image: twelcon_image,
                    title: tSignupTitle,
                    subTitle: tSignupSubTitle),
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
                              return " Please Eenter Name";
                            }
                            return null;
                          },
                          maxLength: 16,
                          controller: fullNameController,

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
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          maxLength: 30,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Please Enter a valid Email ";

                            }else if (value==" !#''%^&*()+-][}{/,? "){
                              return "Enter correct email";
                            }
                            return null;
                          },
                          controller: EmailController,
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
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Please Enter password";
                            }
                            return null;
                          },
                          maxLength: 16,


                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fingerprint),
                            labelText: tPassword,
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
                                  child: Text("SIGNUP".toUpperCase())),
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
                                label: Text("Signup with google"),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const login_screen()));
                                },
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text: "Already Have An Account ",
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
