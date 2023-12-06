import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:newapp/src/constants/sizes.dart';
class otp_screen extends StatelessWidget {
  const otp_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child:  Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            const Text("CODE",style: TextStyle(fontSize: 80,fontWeight: FontWeight.bold),),
            const Text("Verification",style: TextStyle(fontSize: 20),),
            const SizedBox(height: 15,),
            const Text("Enter the verification code send at "+"amin.hamedi2021@gmail.com",textAlign: TextAlign.center,style: TextStyle(fontSize: 15),),
            const SizedBox(height: 20,),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code)=> print("otp code is $code"),
              keyboardType:TextInputType.number,

            ),
            const SizedBox(height: 20,),
            SizedBox(width:double.infinity,
             child:   ElevatedButton(onPressed: (){}, child:const Text("NEXT"))),
          ],
        ),
        
      ),
    );
  }
}
