import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
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
          const SnackBar(
            dismissDirection: DismissDirection.up,
            backgroundColor: Colors.white,
            content: Text("password reset Email has been send check your E-mail"
              ,maxLines: 3,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.blue,backgroundColor: Colors.white,),),
          ));
    }on FirebaseAuthException catch (e){
      if (e.code=="user email not fount "){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text("User not found Enter a Registered Email ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.red,backgroundColor: Colors.white,),),
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
        const SnackBar(
          backgroundColor: Colors.white,
          content: Text("Not a valid E-mail ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.red,backgroundColor: Colors.white,),),
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
                const Text(tForgetPassword, style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const Text(tForgetMailSubTitle,style: TextStyle(fontSize: 18),),
                const SizedBox(height: 30,),
                Column(

                  children: [
                    Form(
                      key: _formkey,
                      child:  TextFormField(
                        controller: EmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return " Please Enter a valid Email ";


                          }
                          return null;
                        },


                          decoration: InputDecoration(label: Text(tEmail,style: TextStyle(fontSize: 20, ),),
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
                      child: const Text("Send Email",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

                    ),
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
