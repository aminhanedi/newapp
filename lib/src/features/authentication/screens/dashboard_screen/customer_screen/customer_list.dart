import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/Search_screen/searchScreenCL.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/total_order_screen.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/update_record.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:url_launcher/url_launcher.dart';

class customer_list_scerrn extends StatefulWidget {
  const customer_list_scerrn({super.key});

  @override
  State<customer_list_scerrn> createState() => _customer_list_scerrnState();
}

class _customer_list_scerrnState extends State<customer_list_scerrn> {
  Widget listItem({required Map customers}) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue, // Background color of the container
          borderRadius: BorderRadius.circular(15), // Rounded corner radius
          border: Border.all(
            color: Colors.amberAccent,
            width: 2,
          ), // Border properties
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ], // Box shadow properties
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              children: [
                Icon(
                  Icons.important_devices,
                  size: 18,
                  color: Colors.amberAccent,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!.customerId} ${customers["customerID"]}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Gap(5),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.amberAccent,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!.customerName} ${customers["customerName"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Gap(5),
            Row(
              children: [
                Icon(
                  Icons.numbers,
                  size: 18,
                  color: Colors.amberAccent,
                ),
                SizedBox(width: 10),
                Text(
                  '${AppLocalizations.of(context)!.customerPhone}${customers["customerPhone"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Gap(40),
                IconButton(
                  onPressed: () async {
                    String uri = 'tel:${customers["customerPhone"]}';

                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                  },
                  icon: Icon(Icons.call,
                      color: Colors.lightGreenAccent,
                      size: 30,
                      shadows: [BoxShadow(offset: Offset(0, 5))]),
                ),
              ],
            ),


            Container(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => total_screen(
                                      customerskey: customers["key"])));
                        },
                        child:Text(" See More..." ,style: TextStyle(fontSize:16,color: Colors.amberAccent),)
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => upddate_record(
                                        customerskey: customers["key"])));
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.amberAccent,
                          ),
                        ),

                        SizedBox(
                          height: 20,
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!.conformationD),
                                  content: Text(AppLocalizations.of(context)!.areD),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(AppLocalizations.of(context)!.no),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the alert dialog
                                      },
                                    ),
                                    TextButton(
                                      child: Text(AppLocalizations.of(context)!.yes),
                                      onPressed: () {
                                        reference.child(customers["key"]).remove();
                                        Navigator.of(context)
                                            .pop(); // Close the alert dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Query dbref = FirebaseDatabase.instance.ref().child("customer");
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child("customer");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.to(() =>
                  SearchScreen()); // Navigate to the REPORT screen when the button is pressed
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Set the background color to transparent
              elevation: 0, // Remove the button elevation
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.transparent, // Set the ink color to transparent
              ),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream:
              dbref.onValue, // Subscribe to a Firebase Realtime Database stream
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loader while data is loading
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.loading,
                      style: TextStyle(color: Colors.green),
                    ),
                    Gap(15),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              // Handle error state
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

             if (!snapshot.hasData) {
              // Handle empty data state
              return Center(
                child: Text(AppLocalizations.of(context)!.noData),
              );
            }

            // Data is available
            Map customers = snapshot.data.snapshot.value
                as Map; // Extract the data from the snapshot
            customers["key"] = snapshot.data.snapshot.key; // Add the snapshot key to the 'customers' map

            return FirebaseAnimatedList(
              query:
                  dbref, // Pass the database reference to the FirebaseAnimatedList
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map customers =
                    snapshot.value as Map; // Extract the data from the snapshot
                customers["key"] =
                    snapshot.key; // Add the snapshot key to the 'customers' map
                return listItem(
                    customers:
                        customers); // Use the 'customers' map to build your list items
              },
            );
          },
        ),
      ),
    );
  }
}
