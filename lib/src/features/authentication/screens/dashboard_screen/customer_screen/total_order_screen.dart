import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';


import '../Search_screen/search_screenTCl.dart';

class TotalListScreen extends StatefulWidget {
  const TotalListScreen({Key? key}) : super(key: key);

  @override
  State<TotalListScreen> createState() => _TotalListScreenState();
}

class _TotalListScreenState extends State<TotalListScreen> {
  List<Map> customersList = [];
  double totalAmount = 0.0;
  int totalRecords = 0;

  void calculateTotalAmount() {
    totalAmount = 0.0;
    totalRecords = customersList.length;

    for (var customer in customersList) {
      double amount = double.parse(customer["customerAmount"].toString());
      totalAmount += amount;
    }
  }

  Widget listItem({required Map customers}) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.amberAccent,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),

        //--------------------items-------------------//
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Gap(10),
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
            Gap(10),
            Row(
              children: [
                Icon(
                  Icons.call,
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
                  icon: Icon(Icons.call, color: Colors.lightGreenAccent,
                      size: 30,
                      shadows: [BoxShadow(offset: Offset(4, 0))]),
                ),
              ],
            ),
            Gap(10),
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 18,
                  color: Colors.amberAccent,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!.customerAmount} ${customers["customerAmount"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
      // ... (rest of the code remains the same)
    );
  }

  Query dbref = FirebaseDatabase.instance.ref().child("customer");
// Create a Query object named dbref that represents the "customer" node in the Firebase database

  @override
  void initState() {
    super.initState();
    // Call the initState method of the superclass

    dbref.onChildAdded.listen((event) {
      // Listen for child added events on the dbref query
      // This will be triggered whenever a new child is added to the "customer" node

      Map customers = event.snapshot.value as Map;
      // Extract the customer data from the event snapshot and cast it to a Map

      customers["key"] = event.snapshot.key;
      // Add a new key called "key" to the customers map and assign it the key of the snapshot
      // This is useful for identifying each customer record

      customersList.add(customers);
      // Add the customers map to the customersList list

      calculateTotalAmount();
      // Calculate the total amount based on the updated customersList

      setState(() {});
      // Trigger a rebuild of the widget tree to update the UI
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.total),
        actions: [
          ElevatedButton(onPressed: (){

            Get.to(()=>tSearchScreen());
          }, child: Icon(Icons.search,size: 35,),
          )
        ],
      ),
      body: Container(
        child: Container(
            child: StreamBuilder(
          stream: dbref
              .onValue, // Replace 'dbref' with your Firebase database reference
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loader while data is loading
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.loading,
                      style: TextStyle(color: Colors.green),
                    ),
                    Gap(10),
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
                child: Text(
                  AppLocalizations.of(context)!.noData,
                ),
              );
            }

            // Data is available
            Map customers = snapshot.data.snapshot.value as Map;
            customers["key"] = snapshot.data.snapshot.key;

            return FirebaseAnimatedList(
              query: dbref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map customers = snapshot.value as Map;
                customers["key"] = snapshot
                    .key; // Use the 'customers' map here to build your list items
                return listItem(customers: customers);
              },
            );
          },
        )),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.amberAccent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        height: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.totalOrder} $totalRecords',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.amberAccent,
                    shadows: [BoxShadow(offset: Offset(5, 0))],
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.totalAmount} $totalAmount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.money,
                    color: Colors.amberAccent,
                    shadows: [BoxShadow(offset: Offset(5, 0))],
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
