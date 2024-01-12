import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:newapp/src/features/authentication/screens/common_screen/Privacy_Policy.dart';
import 'package:newapp/src/features/authentication/screens/common_screen/about_us.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/add_customer.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/gallery_screen.dart';
import 'package:newapp/src/features/authentication/screens/login/login_screen.dart';
import 'package:newapp/src/features/authentication/screens/welcome/welcome_screen.dart';
import '../forget_password/forget_password_email/forget_password_email.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}
final auth = FirebaseAuth.instance;


class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---------------------------------------------------------drawer navigation bar-------------------------------------------//
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.60, // Set the desired width of the draw
        child:ListView(
          children:  [
            const UserAccountsDrawerHeader(
                accountName: Text("Arain",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                accountEmail:Text("0093780700709", style: TextStyle(fontSize:16),),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/amin.jpg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title:Text("Languages"),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.security),
              title:Text("Change password"),
              onTap: (){

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (contaxt) =>forget_pass_mail_screen()),
                  );

                  print('Item clicked!');

              },
            ),

            ListTile(
              leading: Icon(Icons.font_download),
              title:Text("Font size"),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.note),
              title:Text("Privacy Policy"),
              onTap: (){

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contaxt) =>Privacy_Policy()),
                );

                print('Item clicked!');

              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title:Text("Log out"),
              onTap: (){

                auth.signOut().then((value) =>
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (contaxt) =>  login_screen()),
                )
                );

                print('Item clicked!');

              },
            ),
            const Divider(
              color: Colors.blue, // Customize the color of the divider
              thickness: 2.6, // Set the thickness of the divider
              indent: 20, // Set the indent or left-padding of the divider
              endIndent: 20, // Set the end-indent or right-padding of the divider
            ),
            ListTile(
              leading: Icon(Icons.person_pin_circle),
              title:Text("About Us"),
              onTap: (){
                setState(() {
                  Navigator.pop(context);
                });

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (contaxt) =>about_us()),
                );

                print('Item clicked!');

              },
            ),
          ],


        ),
        
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      //----------------------------------------------------------------body ---------------------------------------------------------//
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [

                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Arain!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Good Morning',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GestureDetector(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => MeasurementForm()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Add CUSTOMER',
                          CupertinoIcons.add, Colors.deepOrange),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard(
                          'CUSTOMER List', CupertinoIcons.person_2, Colors.pinkAccent),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard(
                          'Total Order', CupertinoIcons.person_2_fill, Colors.blue),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => GalleryScreen()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Gallery',
                          CupertinoIcons.photo_fill_on_rectangle_fill, Colors.indigo),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) =>  GalleryScreen()),

                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard(
                          'Sitting', CupertinoIcons.gear_big, Colors.purple),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) =>GalleryScreen()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Calculator',
                          CupertinoIcons.square_favorites_alt    , Colors.brown),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: itemDashboard('Analytics',
                          CupertinoIcons.graph_circle, Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 1),
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium),


          ],

        ),
      );
}
