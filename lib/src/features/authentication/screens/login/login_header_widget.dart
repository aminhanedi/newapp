import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newapp/src/constants/image_string.dart';
import 'package:newapp/src/constants/text_string.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image(
          image: const AssetImage(twelcon_image),
          height: size.height * 0.2), // Image
      Text(tSignup, style: Theme.of(context).textTheme.displaySmall),
      Text(tWelcomeSubTitle, style: Theme.of(context).textTheme.bodyLarge),
    ]);
  }
}
