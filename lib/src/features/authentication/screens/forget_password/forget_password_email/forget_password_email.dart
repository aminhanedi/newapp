import 'package:flutter/material.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/sizes.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
class forget_pass_mail_screen extends StatelessWidget {
  const forget_pass_mail_screen({super.key});

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
                    const TextField(
                        decoration: InputDecoration(label: Text(tEmail,style: TextStyle(fontSize: 20, ),),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)

                        ),

                    ),
                    const SizedBox(height: 20,),
                    SizedBox(width: double.infinity,
                  child:  ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(contaxt)=> const otp_screen() ),);


                  },
                      child: const Text("NEXT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),

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
