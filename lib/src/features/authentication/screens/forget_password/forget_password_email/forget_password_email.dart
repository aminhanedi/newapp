import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import '../../login/login_screen.dart';

class forget_pass_mail_screen extends StatefulWidget {
  const forget_pass_mail_screen({super.key});

  @override
  State<forget_pass_mail_screen> createState() => _forget_pass_mail_screenState();
}

class _forget_pass_mail_screenState extends State<forget_pass_mail_screen> {
  final _formkey = GlobalKey<FormState>();
  String email="";
  TextEditingController EmailController = new TextEditingController();
  resetPassword()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            dismissDirection: DismissDirection.up,
            backgroundColor: Colors.white,
            content: Text(AppLocalizations.of(context)!.checkE,
              maxLines: 3,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.blue,backgroundColor: Colors.white,),),
          ));
    }on FirebaseAuthException catch (e){
      if (e.code=="user email not fount "){
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            backgroundColor: Colors.white,
            content: Text(AppLocalizations.of(context)!.noteFound,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.red,backgroundColor: Colors.white,),),
          ),);
      }
    }
  }



 // -------------email validator--------------//
  void  validEmail(){
    bool isValid= EmailValidator.validate(EmailController.text.trim());
    if(isValid){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text("Valid E-mail ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.green,backgroundColor: Colors.white,),),
          ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: Colors.white,
          content: Text(AppLocalizations.of(context)!.notValid,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.red,backgroundColor: Colors.white,),),
        ),);
    }}

    //------------------------finished------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Container(
            padding: const EdgeInsets.symmetric(),
            margin: const EdgeInsets.all(1),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
               Image.asset(tForgetPasswordImage, height: 200,width: 400,),
                 Text( AppLocalizations.of(context)!.forgetP, style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                 Text( AppLocalizations.of(context)!.enterEmailto,style: TextStyle(fontSize: 18),),
                 SizedBox(height: 30,),
                Column(

                  children: [
                    Form(
                      key: _formkey,
                      child:  TextFormField(
                        controller: EmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.requiredField;


                          }
                          return null;
                        },


                          decoration: InputDecoration(label: Text(AppLocalizations.of(context)!.email,style: TextStyle(fontSize: 20, ),),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)

                          ),

                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(width: double.infinity,
                  child:  ElevatedButton(onPressed: (){

                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        email = EmailController.text;
                      });
                      resetPassword();
                     // validEmail();
                    }

                  },
                      child:  Text(AppLocalizations.of(context)!.sentEmail,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: IconButton(onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(AppLocalizations.of(context)!.conformation),
                              content:  Text(AppLocalizations.of(context)!.areYouSure),
                              actions: [
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!.no),
                                  onPressed: () {
                                    // Dismiss the dialog
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(AppLocalizations.of(context)!.yes),
                                  onPressed: () {
                                    // Sign out and navigate to the login screen
                                     Get.to(() => login_screen());
                                  },
                                ),
                              ],
                            );
                          },
                        );

                      }, icon:Icon(Icons.arrow_forward,size: 40,)),

                    )
                  ],
                )
              ],


            ),
          ),
        ),
      ),

    );
  }
}
