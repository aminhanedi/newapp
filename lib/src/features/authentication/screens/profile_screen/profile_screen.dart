// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:newapp/src/features/authentication/screens/profile_screen/UpdateProfileScreen.dart';
//
// import '../../../../constants/color.dart';
// import '../../../../constants/sizes.dart';
// import '../../../../constants/text_string.dart';
// import '../../../../repository/authentecation_repository/authentecation_repository.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   String? get tProfileImage =>  null;
//
//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
//         title: Text(tProfile, style: Theme.of(context).textTheme.bodyMedium),
//         actions: [IconButton(onPressed: () {}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(tDefaultSize),
//           child: Column(
//             children: [
//
//               /// -- IMAGE
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: 120,
//                     height: 120,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage("assets/images/top_logo1.png"))),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 35,
//                       height: 35,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: tPrimaryColor),
//                       child: const Icon(
//                         LineAwesomeIcons.alternate_pencil,
//                         color: Colors.black,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Text(tProfileHeading, style: Theme.of(context).textTheme.headline4),
//               Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyText2),
//               const SizedBox(height: 20),
//
//               /// -- BUTTON
//               SizedBox(
//                 width: 200,
//                 child: ElevatedButton(
//                   onPressed: () => Get.to(() => update_profile_screen()),
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: tPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
//                   child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               const Divider(),
//               const SizedBox(height: 10),
//               const profileMenuWidget() // ListTile
//
//               /// -- MENU
//               profileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: () {}),
//               profileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () {}),
//               profileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
//               const Divider(),
//               const SizedBox(height: 10),
//               profileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
//               profileMenuWidget(
//                   title: "Logout",
//                   icon: LineAwesomeIcons.alternate_sign_out,
//                   textColor: Colors.red,
//                   endIcon: false,
//                   onPress: () {
//                     Get.defaultDialog(
//                       title: "LOGOUT",
//                       titleStyle: const TextStyle(fontSize: 20),
//                       content: const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 15.0),
//                         child: Text("Are you sure, you want to Logout?"),
//                       ),
//                       confirm: Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => AuthenticationRepository.instance.logout(),
//                           style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
//                           child: const Text("Yes"),
//                         ),
//                       ),
//                       cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class profileMenuWidget extends StatelessWidget {
//   const profileMenuWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular (100),
//           color: tAccentColor.withOpacity(0.1),
//         ), // BoxDecoration
//         child: const Icon(LineAwesomeIcons.cog, color: tAccentColor),
//       ), // Container
//       title: Text(tMenul, style: Theme.of(context).textTheme.bodyMedium),
//       trailing: Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular (100),
//             color: Colors.grey.withOpacity(0.1),
//           ), // BoxDecoration
//           child: const Icon(LineAwesomeIcons.angle_right, size: 18.0, color: Colors.grey)), // Container
//
//     );
//   }
// }