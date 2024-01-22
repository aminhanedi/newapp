
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newapp/src/features/authentication/screens/common_screen/Privacy_Policy.dart';
import 'package:newapp/src/features/authentication/screens/common_screen/about_us.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/add_customer.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/gallery_screen.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/total_order_screen.dart';
import 'package:newapp/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:newapp/src/localization/language.dart';
import '../../../../../SignIn.dart';
import '../../../../localization/language_localization.dart';
import '../forget_password/forget_password_email/forget_password_email.dart';
import 'customer_screen/analys_screen.dart';
import 'customer_screen/backup_screen.dart';
import 'customer_screen/customer_list.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}
final auth = FirebaseAuth.instance;


class _dashboardState extends State<dashboard> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(


        //---------------------------------------------------------drawer navigation bar-------------------------------------------//
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.65, // Set the desired width of the draw
          child:ListView(
            children:  [
              const UserAccountsDrawerHeader(
                  accountName: Text("Amin Hamedi",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  accountEmail:Text("0093780700709", style: TextStyle(fontSize:16),),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/amin.jpg"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Row(
                  children: [
                    Text(AppLocalizations.of(context)!.language,),
                    DropdownButton<Language>(
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.black,
                      ),
                      onChanged: (Language? language) async {
                        if (language != null) {
                          Locale _locale = await setLocale(language.languageCode);
                          MyApp.setLocale(context, _locale);
                        }
                      },
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                            (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize:20),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                          .toList(),
                    ),

                  ],

                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.security),
                title:Text(AppLocalizations.of(context)!.changePassword,),
                onTap: (){
                  //---------------------empty ---------------//
                  Get.to((()=>forget_pass_mail_screen()));

                },
              ),

              ListTile(
                leading: Icon(Icons.font_download),
                title:Text(AppLocalizations.of(context)!.fontSize,),
                onTap: (){

                },
              ),
              ListTile(
                leading: Icon(Icons.note),
                title:Text(AppLocalizations.of(context)!.privacyP,),
                onTap: (){
                  Get.to(()=> Privacy_Policy() );

                  print('Item clicked!');

                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title:Text(AppLocalizations.of(context)!.logOut,),
                onTap: (){

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text(AppLocalizations.of(context)!.areYouSure,),
                        actions: [
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.no,),
                            onPressed: () {
                              // Dismiss the dialog
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(AppLocalizations.of(context)!.yes,),
                            onPressed: () {
                              // Sign out and navigate to the login screen
                              auth.signOut().then((value) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => Welcome(),
                                    maintainState: false,
                                  ),

                                );
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
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
                title:Text(AppLocalizations.of(context)!.aboutUs,),
                onTap: (){
                Get.to((()=>about_us())
                  );

                  print('Item clicked!');

                },
              ),
              ListTile(

                leading: Icon(Icons.share),
                title: const Text(
               "share app",
                  style: TextStyle(fontFamily: "roboto"),
                ),
                onTap: ()async{

                },
              ),
            ],


          ),
          
        ),

        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homePage),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Language>(
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    MyApp.setLocale(context, _locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ],

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
                    title: Text(AppLocalizations.of(context)!.helloArian,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    subtitle: Text(AppLocalizations.of(context)!.goodMorning,
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
                padding: const EdgeInsets.symmetric(horizontal:20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
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
                          Get.to(()=>MeasurementForm());


                          print('Item clicked!');
                        },
                        child: itemDashboard(translation(context).addCustomer,
                            CupertinoIcons.add, Colors.deepOrange),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(()=>const customer_list_scerrn());

                          print('Item clicked!');
                        },
                        child: itemDashboard(
                            translation(context).customerList, CupertinoIcons.person_2, Colors.pinkAccent),
                      ),
                      GestureDetector(
                        onTap: () {
                         Get.to(()=>const TotalListScreen()
                          );

                          print('Item clicked!');
                        },
                        child: itemDashboard(
                            translation(context).totalOrder, CupertinoIcons.person_2_fill, Colors.blue),
                      ),
                      GestureDetector(
                        onTap: () {
                        Get.to(() => const GalleryScreen(),);

                          print('Item clicked!');
                        },
                        child: itemDashboard(translation(context).gallery,
                            CupertinoIcons.photo_fill_on_rectangle_fill, Colors.indigo),
                      ),
                      GestureDetector(
                        onTap: () {
                         Get.to(() =>BackupWidget  ());

                          print('Item clicked!');
                        },
                        child: itemDashboard(
                            translation(context).backup, CupertinoIcons.cloud_upload, Colors.purple),
                      ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MonthlyOrderWidget());
                    },
                        child: itemDashboard(translation(context).analyes,
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
